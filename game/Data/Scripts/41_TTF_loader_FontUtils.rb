# ==============================
# ■ FontUtils
# ------------------------------
# Pure Ruby helpers for reading .ttf/.otf font metadata
# Compatible with RPG Maker VX Ace (RGSS3 / Ruby 1.9.x)
# ==============================
module FontUtils
	# Reads a font file and returns the full font name (name_id == 4).
	# Falls back to family name (name_id == 1) if needed.
	def self.read_font_name(path)
		File.open(path, "rb") do |f|
			# --- Offset table ---
			scaler_type = f.read(4) # "\0\1\0\0" (TTF) or "OTTO" (OTF)
			num_tables = f.read(2).unpack("n")[0]
			f.read(6) # skip searchRange, entrySelector, rangeShift

			# --- Find 'name' table ---
			name_offset = nil
			name_length = nil
			num_tables.times do
				tag = f.read(4)
				checksum, offset, length = f.read(12).unpack("NNN")
				if tag == "name"
					name_offset = offset
					name_length = length
				end
			end
			return nil unless name_offset

			# --- Read name table header ---
			f.seek(name_offset)
			format_selector, count, string_offset = f.read(6).unpack("nnn")

			records = []
			count.times do
				platform_id, encoding_id, language_id,
						name_id, length, offset = f.read(12).unpack("nnnnnn")
				records << {
					:platform => platform_id,
					:encoding => encoding_id,
					:language => language_id,
					:name_id  => name_id,
					:length   => length,
					:offset   => offset
				}
			end

			# --- Prefer Full Font Name (ID 4), else Family Name (ID 1) ---
			record = records.find { |r| r[:name_id] == 4 } ||
               records.find { |r| r[:name_id] == 1 }
			return nil unless record

			string_pos = name_offset + string_offset + record[:offset]
			f.seek(string_pos)
			raw = f.read(record[:length])

			if record[:platform] == 0 || record[:platform] == 3
				decode_utf16be(raw)
			else
				raw.force_encoding("ASCII-8BIT")
				.encode("UTF-8", :invalid => :replace)
			end
		end
	end

	# --- Helpers ---


	# Scan Fonts\ folder and build a hash of font mappings

	def self.scan_fonts(folder = "Fonts")
		fonts = {}
		default_font_name = nil

		Dir.glob("#{folder}/*.{ttf,otf}").each do |path|
			filename = File.basename(path)
			font_name = read_font_name(path) || "(Unknown Font)"

			if filename =~ /^SYS-DEFAULT-/
				default_font_name = font_name
				fonts["DEFAULT"] = font_name

			elsif filename =~ /^SYS-([A-Z]+)-/
					key = $1
				fonts[key] = font_name
			#else
			#	fonts[filename] = font_name
			end
		end

		# wrap into a hash with default value
		if default_font_name
			Hash.new(default_font_name).merge(fonts)
		else
			fonts # no SYS-DEFAULT file, just return plain hash
		end
	end


	# Decode UTF-16BE manually (works in RGSS3 where UTF-16BE encoding is missing)
	def self.decode_utf16be(str)
		str.unpack("n*").pack("U*")
	end
end

# ==============================
# ■ Example Usage
# ==============================
# puts FontUtils.read_font_name("VL-Gothic-Regular.ttf")
# => "VL Gothic"
#
# puts FontUtils.read_font_name("NotoSansCJKtc-Black.otf")
# => "Noto Sans CJK TC Black"
