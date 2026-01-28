#==============================================================================
# This script is created by Kslander 
#==============================================================================
#==============================================================================
# Text
#------------------------------------------------------------------------------
# Maps keys to text Strings. Reference at $game_text.
# Based on Text class written by DB
#==============================================================================

class MailText
	attr_accessor		:base_folder
	attr_accessor		:filenameList
	attr_accessor		:map
	#def initialize(base_folder="Text/CHT/mail")
	#	super(base_folder)
	#	@filenameList={}
	#	load_file_and_create_list
	#end
	def initialize(base_folder = "Text/CHT/mail/") #umm
		@map = {}
		@base_folder = base_folder
		@filenameList = {}
		load_file_and_create_list(target = @base_folder)
	end

	def load_file(target)#umm merge
		begin
			tgt = target + ".txt"
			sth = File.read(tgt)
			return parse(sth.to_s.encode("utf-8"))
		rescue => ex
			msgbox "ERROR: missing translation file #{tgt}"
			return Hash.new
		end
	end


	########### GPT ver1
	def parse(string)
		blocks = {}
		lines = string.split("\n")
		current_section = nil

		lines.each do |line|
			next if line.strip.empty? || line.start_with?('#')

			if line.include?("/")
				section, key = line.split("/", 2)
				blocks[section] ||= {}
				current_section = section
				#blocks[section][key] = line        #@map={"Text/CHT/mail/DarkPot.txt"=>{"Tutorial_MainControl"=> {"Sender"=>"Tutorial_MainControl/Sender","Title"=>"Tutorial_MainControl/Title","Text"=>"DarkPotBasic1/Text"},
				blocks[section] = true
			end
		end

		blocks
	end

	# Simulating file scanning and data transformation
	def load_file_and_create_list(target)
		p "load_file_and_create_list #{target}"
		@map = {}
		Dir[target + "*.txt"].each do |file|
			next unless File.file?(file)

			content = File.read(file)
			parsed_data = parse(content)

			@map[file] = parsed_data
			create_key_list(file)
		end
	end

	#for mod api load single file.
	# Load a single file dynamically and update @map and @filenameList
	def load_new_file(file_path)
		return unless File.file?(file_path)
		
		begin
			content = File.read(file_path)
			parsed_data = parse(content)
			@map[file_path] = parsed_data
			
			# Update filenameList
			parsed_data.keys.each do |key|
				@filenameList[key.split("/")[0]] = file_path
			end
			
			p "Loaded new file: #{file_path}"
		rescue => ex
			p "ERROR loading file #{file_path}: #{ex.message}"
		end
	end

	def decode_text(content, header) # $mail_text.get_text("Text/CHT/mail/DarkPot.txt","DarkPotBasic1/Sender")
	#def get_text(file, header) # $mail_text.get_text("Text/CHT/mail/DarkPot.txt","DarkPotBasic1/Sender")
		#content = File.read(file)
		content = "" if !content
		match = content.match(/#{header}(\s*.*?)\n(?:[A-Za-z_]+\/[A-Za-z_]+|$)/m)
		return match ? match[1].strip : ""
	end
	def create_key_list(file) #umm merge
		p " create_key_list for file =>#{file}"
		@map[file].keys.each {|key|
		 	 @filenameList[key.split("/")[0]] = file
		}
	end
end
