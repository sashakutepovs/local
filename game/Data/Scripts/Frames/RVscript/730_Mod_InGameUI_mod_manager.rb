# frozen_string_literal: true

MODS_DIR = "ModScripts/_Mods"

class ModManager
	attr_reader :new_mods
	attr_reader :mods
	attr_reader :mods_ini

	def initialize
		@mods = {}
		@loaded_mods = false
		@preloaded_mods = false
		unless File.exist?("UserData/GameMods.ini")
		File.open("UserData/GameMods.ini", "w").close
		end
		sleep(0.1)
		@mods_ini = IniFile.load("UserData/GameMods.ini")
		sleep(0.1)
		@new_mods = []
		Dir["#{MODS_DIR}/*"].each do |path|
			next unless File.directory? path
			begin
				mod = load_mod_info path
				basename = File.basename path
				if @mods_ini.sections.include? basename
				@mods_ini[basename]["Banned"] = 1 unless @mods_ini[basename].include? "Banned"
				@mods_ini[basename]["LoadOrder"] = 0 unless @mods_ini[basename].include? "LoadOrder"
				mod.enabled = @mods_ini[basename]["Banned"] == 0
				else
				@mods_ini[basename]["Banned"] = 1
				@mods_ini[basename]["LoadOrder"] = 0
				@new_mods.push(mod)
				end
			rescue => e
				print "raised exception while loading mod info #{e}\n#{e.backtrace.join("\n")}\n"
			end
		end
		load_state_save(get_state_save)
	end

	def [](mod_id, setting_id = nil)
		if setting_id.nil?
		(mod_id.is_a? Integer) ? @load_order[mod_id] : @mods[mod_id]
		else
		#self[mod_id].settings[setting_id].value
		end
	end

	def []=(mod_id, setting_id, value)
		s = self[mod_id].settings[setting_id]
		s.value = value
		@mods_ini[File.basename self[mod_id].path][setting_id] = value
		save_ini
		s.callback.call(value)
	end

	def load_order
		@load_order
	end

	def mods_count
		@mods.size
	end

	def ids
		@mods.keys
	end

	def load_mods(bnd)
		return if @loaded_mods
		@loaded_mods = true
		@load_order.each { |mod| mod.load_scripts(bnd) if mod.enabled }
	end

	def preload_mods
		return if @preloaded_mods
		@preloaded_mods = true
		@load_order.each { |mod| mod.preload_scripts if mod.enabled }
	end

	def load_mod_info(path)
		p "read mod info #{path}"
		mod = Mod.new(path)
		if @mods.include? mod.id
		p "ERROR mod ids conflict for id #{mod.id}: #{@mods[mod.id].path}, #{mod.path}\n"
		@mods[mod.id].error += "\\c[1]mod ids conflict: #{@mods[mod.id].path}, #{mod.path}\\c[0]\n"
		else
		@mods[mod.id] = mod
		end
		@mods[mod.id]
	end

	def fix_dependencies
		load_ord = @load_order
		@load_order = []
		started_loading = []
		@mods.each { |_, mod| mod.clear_error }
		load_ord.each do |mod|
			begin
				check_dependencies_for(mod, started_loading,  auto_sort = true)
			rescue => e
				@mods[mod.id].error += "\\c[1]raised exception #{e} while loading mod info\\c[0]\n"
			end
		end
		save_ini
	end
	def create_error_msg
		load_ord = @load_order
		started_loading = []
		@mods.each { |_, mod| mod.clear_error }
		load_ord.each do |mod|
			begin
				next if @load_order.include? mod
				if started_loading.include? mod
					mod.error += "\\c[1]cyclic dependency\n"
					next
				end
				check_loaded_all_before(mod, started_loading , auto_sort = false)
				check_passed_checks(mod)
			rescue => e
				@mods[mod.id].error += "\\c[1]raised exception #{e} while loading mod info\\c[0]\n"
			end
		end
	end

	def check_dependencies_for(mod, started_loading,  auto_sort = true)
		return if @load_order.include? mod
		if started_loading.include? mod
			mod.error += "\\c[1]cyclic dependency\\c[0]\n"
			return
		end
		loaded_all_before = check_loaded_all_before(mod, started_loading , auto_sort)
		started_loading.push(mod)
		mod.enabled &= loaded_all_before

		passed_checks = check_passed_checks(mod)
		mod.enabled &= passed_checks
		@load_order.push mod
	end
	def check_loaded_all_before(mod, started_loading , auto_sort = false)
		loaded_all_before = @mods.all? do |id, m|
			if m.before.include?(mod.id)
				check_dependencies_for(m, started_loading) if auto_sort
				unless @load_order.include? m
					mod.error += "\\c[1]mod should load before #{id}\\c[0]\n"
					next false
				end
			end
			true
		end
	end
	def check_passed_checks(mod)
		error_reported = nil
		passed_checks = mod.requires.all? do |required_id, version_constrains|
			modCompareSym = version_constrains[0]
			modCompareVer = version_constrains[1]
			if required_id == "LonaRPG"
				gameVer = DataManager.translate_game_ver(DataManager.export_full_ver_info)
				ver_checks = check_required_constrain(modCompareSym,gameVer,modCompareVer)
				unless ver_checks
					mod.error += "\\c[1]LonaRPG req ver #{modCompareSym} #{modCompareVer}\\c[0]\n"
				end
				next true
			end
			unless @mods.include? required_id
				mod.error += "\\c[1]req mod #{required_id} not found\\c[0]\n"
				error_reported = true
				next true
			end
			tgtMod = @mods[required_id]
			tgtModver = tgtMod.version
			ver_checks = check_required_constrain(modCompareSym,tgtModver,modCompareVer)
			unless ver_checks
				mod.error += "\\c[1]req mod ver #{modCompareSym} #{required_id}\\c[0]\n"
				error_reported = true
			end
			unless tgtMod.enabled
				mod.error += "\\c[1]req mod #{required_id} is not enabled\\c[0]\n"
				error_reported = true
			end
			tgtMod.enabled
		end
		return false if error_reported
		passed_checks
	end
	def check_required_constrain(modCompareSym,tgtModver,modCompareVer)
		case modCompareSym
			when ">=" ;		return tgtModver >= modCompareVer
			when "<=" ;		return tgtModver <= modCompareVer
			when ">" ;		return tgtModver >  modCompareVer
			when "<" ;		return tgtModver <  modCompareVer
			when "==" ;		return tgtModver == modCompareVer
			when "!=" ;		return tgtModver != modCompareVer
		end
		return false
	end

	def get_state_save
		a = @mods_ini.to_h
		a.each { |k, v| a[k] = v.dup }
	end

	def load_state_save(save)
		save.each { |seg, part| part.each { |k, v| @mods_ini[seg][k] = v } }
		@load_order = @mods.values
		@load_order.each { |mod| mod.enabled = @mods_ini[File.basename mod.path]["Banned"] == 0 }
		@load_order.sort! do |a, b|
		  ini_a = @mods_ini[File.basename a.path]
		  ini_b = @mods_ini[File.basename b.path]
		  if ini_a["LoadOrder"] != ini_b["LoadOrder"]
		    next ini_a["LoadOrder"] <=> ini_b["LoadOrder"]
		  end
		  a.id <=> b.id
		end
		fix_dependencies
	end

	def swap(a, b)
		a, b = *([a, b].sort!)
		mod_a = @load_order[a]
		mod_b = @load_order[b]
		@load_order.delete mod_b
		@load_order.delete mod_a
		@load_order.insert(a, mod_b)
		@load_order.insert(b, mod_a)
		@mods_ini[File.basename mod_a.path]["LoadOrder"] = b
		@mods_ini[File.basename mod_b.path]["LoadOrder"] = a
		fix_dependencies
	end

	def save_ini
		@load_order.each_with_index do |m, i|
		@mods_ini[File.basename m.path]["LoadOrder"] = i
		@mods_ini[File.basename m.path]["Banned"] = m.enabled ? 0 : 1
		end
		@mods_ini.write
	end

	def link_texts
		@mods.each_value do |mod|
		$game_text.add_part(mod.id, "#{mod.path}/#{mod.texts}/#{$lang}")
		end
	end

	def found_mode(name)
		@mods.include? name
	end

	def declare_setting(mod_id, setting_id, localized_name, possible_values, default_value, &on_change)
		mod = @mods[mod_id]
		init_value = @mods_ini[File.basename mod.path].include?(setting_id) ? @mods_ini[File.basename mod.path][setting_id] : default_value
		mod.settings[setting_id] = Setting.new(setting_id, localized_name, possible_values, init_value, on_change)
		@mods_ini[File.basename mod.path][setting_id] = init_value
		save_ini
	end

	def get_resource(mod_id, relative_path)
		File.join @mods[mod_id].path, relative_path
	end
	def output_data_to_array
		original_hash= {}
		@mods.each{|hashName,hashData|
			next unless hashData.enabled
			original_hash[hashData.id] = hashData
		}

		result = {}
		original_hash.each do |key, mod|
			mod_hash = {}
			mod.instance_variables.each do |var|
				next if var.to_s == "@type"  # skip @type
				value = mod.instance_variable_get(var)
				clean_key = var.to_s.sub(/^@/, "")  # manually remove @ prefix
				mod_hash[clean_key] = value
			end
			# Convert the cleaned hash into an array of stringified key=value pairs
			formatted_array = mod_hash.map do |k, v|
				if v.is_a?(String)
					"\"#{k}\"=\"#{v}\""
				else
					"\"#{k}\"=#{v.inspect}"
				end
			end
			result[key] = formatted_array
		end
		result
	end

	def asd
		@mod
	end
end

$mod_manager = ModManager.new
