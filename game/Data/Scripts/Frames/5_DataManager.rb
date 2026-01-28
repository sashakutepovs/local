#==============================================================================
# This script has been altered by Kslander for the need of LonaRPG
#==============================================================================
#==============================================================================
# ** DataManager
#------------------------------------------------------------------------------
#  This module manages the database and game objects. Almost all of the 
# global variables used by the game are initialized by this module.
#==============================================================================
module DataManager
	$debug_dataloading=true #flag for debug in this file
	#--------------------------------------------------------------------------
	# * Module Instance Variables
	#--------------------------------------------------------------------------
	@last_savefile_index = 0				# most recently accessed file
	@customLoadName = 0						# Name for custom game Load
	#--------------------------------------------------------------------------
	# * Initialize Module
	#--------------------------------------------------------------------------
	
	
	def self.init
		load_peripheral_devices #must on top
		load_FirstTimeLaunchLangSetup
		InputUtils.load_input_settings
		load_FirstTimeLaunchGamePadUiSetup
		load_core_data
	end
	#--------------------------------------------------------------------------
	# * Load Database
	#--------------------------------------------------------------------------
	def self.load_peripheral_devices
		Graphics.load_fullscreen_settings
		p "DataManager -load_peripheral_devices- Check GameLona.ini"
		if $LonaINI["LonaRPG"]["StartingSetted"] != 1
			p "DataManager First time? Load Default setup."
			$LonaINI["LonaRPG"]["StartingSetted"] = 1
			$LonaINI["LonaRPG"]["SNDvol"] = 100
			$LonaINI["LonaRPG"]["BGMvol"] = 100
			#$LonaINI["LonaRPG"]["PrtFocusMode"] = 1 #Unused
			$LonaINI["LonaRPG"]["MapBgMode"] = 1
			$LonaINI["Screen"]["Fullscreen"] = 0
			$LonaINI["Screen"]["FullscreenRatio"] = 0
			$LonaINI["Screen"]["WindowedRatio"] = 1
			$LonaINI["Screen"]["ScreenScale"] = "16:9"
			$LonaINI["LonaRPG"]["COMPRESSED"] = 0
			$LonaINI["LonaRPG"]["WRITING_LIST"] = 0
			$LonaINI["Cache"]["PrecacheLonaPoseBitmaps"] = 0
			$LonaINI["Cache"]["PrecacheLonaChcgBitmaps"] = 0
			$LonaINI["Cache"]["PrecacheLonaAllBitmaps"] = 0
			$LonaINI["Cache"]["PrecacheNpcPrtBitmaps"] = 0
			$LonaINI["Cache"]["DisablePartsClear"] = 0
			$LonaINI["Cache"]["DisableChsMaterialClear"] = 0
			$LonaINI["Cache"]["DisableChsDataCacheClear"] = 0
			$LonaINI["GameOptions"]["oev_OutDress_always_parallel"] = 0
			$LonaINI["GameOptions"]["ui_opt_warping"] = 1
			$LonaINI["GameOptions"]["ui_opt_warping_mouse_off"] = 1
			$LonaINI.save
			InputUtils.load_MouseDefautKeys_to_ini
			Graphics.toggle_ratio
		end
		#if ["Steam Runtime","Linux"].include?(DataManager.get_os_id) && $LonaINI["Linux"] == {}
		#	$LonaINI["Linux"]["GameScope"] = 0
		#	$LonaINI["Linux"]["Height"] = 0
		#	$LonaINI["Linux"]["Width"] = 0
		#	$LonaINI.save
		#end
		p "DataManager -load_peripheral_devices- Sound setting"
		$data_BGMvol		= DataManager.get_vol_constant("BGMvol")
		$data_SNDvol		= DataManager.get_vol_constant("SNDvol")
		Mouse.setup
		Mouse.enable if DataManager.get_constant("LonaRPG","MouseEnable",1) == 1
	end
	def self.load_core_data
		p "DataManager load_core_data"
		update_Lang
		@last_savefile_index = 0
		load_database
		create_game_objects
	end
	def self.load_FirstTimeLaunchGamePadUiSetup
		p "DataManager BuildInput UI data from game.ini"
		if [0,"",nil].include?(DataManager.get_text_constant("LonaRPG","GamePadUImode",16))
			if WolfPad.plugged_in?
				DataManager.write_constant("LonaRPG","GamePadUImode","XB")
				$data_GamePadUImode = "XB"
			else
				DataManager.write_constant("LonaRPG","GamePadUImode","KB")
				$data_GamePadUImode = "KB"
			end
		end
	end
	
	def self.load_FirstTimeLaunchLangSetup
		p "DataManager Lang set is #{get_lang_constant}"
		if !createLangArray.include?(get_lang_constant) #get_lang_constant == "\x00  "
			$langFirstPick = true
			$lang = "ENG"
			write_lang_constant
			p "DataManager Lang NoT found! Lang set to #{$lang}"
			return update_Lang
		end
	end
	
	def self.get_lang_constant
		$lang = $LonaINI["LonaRPG"]["Language"]
		$lang
	end
	#def self.get_font_name
	#	selectedFont = nil
	#	fontList=FileGetter.getFileList("Fonts/SYS-*")
	#	system_font_list = Array.new
	#	fontList.each{|fileName|
	#		p "DataManager.create_font_data FondListed #{fileName}"
	#		fileName = fileName[10..-1]
	#		fileName = fileName.chomp('.ttf')
	#		fileName = fileName.chomp('.otf')
	#		system_font_list << fileName
	#	}
	#	tmpLang = get_lang_constant
	#	tmpLang = "ENG" if ["XHT",nil].include?(tmpLang)
	#	point_format=/(#{tmpLang}-)(.+)/
	#	system_font_list.each{|fileName|
	#		next if !fileName.split(point_format)[2]
	#		selectedFont = fileName.split(point_format)[2]
	#	}
	#	if selectedFont
	#		p "Font Found!! #{tmpLang} now using #{selectedFont}"
	#		p "Script.rvdata2 will force default.font to #{selectedFont}"
	#	else
	#		selectedFont = "Noto Sans CJK TC Black"
	#		p "Font NOT Found!! #{tmpLang} now using #{selectedFont}"
	#	end
	#	selectedFont
	#end
	def self.get_font_name
		$data_fonts = FontUtils.scan_fonts if !$data_fonts || $data_fonts.empty?
		tmpLang = get_lang_constant
		$data_fonts[tmpLang]
	end
	def self.update_Lang
		$game_text = Text.new("Text/#{$lang}")
		$mod_manager.link_texts
	end
	
	def self.load_database
		load_normal_database
		check_player_location
		#load_notetags_aee #moved to ItemConfig.rb
	end
  #--------------------------------------------------------------------------
  # * Load Normal Database
  #--------------------------------------------------------------------------
	def self.load_normal_database
		$data_actors					= load_data("Data/Actors.rvdata2")
		$data_classes					= load_data("Data/Classes.rvdata2")
		$data_skills					= load_data("Data/Skills.rvdata2")
		$data_weapons					= load_data("Data/Weapons.rvdata2")
		$data_armors					= load_data("Data/Armors.rvdata2")
		#$data_enemies					= load_data("Data/Enemies.rvdata2")
		#$data_troops					= load_data("Data/Troops.rvdata2")
		$data_states					= load_data("Data/States.rvdata2")
		$data_items						= load_data("Data/Items.rvdata2")
		#$data_animations				= load_data("Data/Animations.rvdata2")
		#$data_tilesets					= load_data("Data/Tilesets.rvdata2")
		$data_tilesets					= load_tilesets
		$data_common_events				= load_common_events
		$data_common_parallel			= $data_common_events.values.select{|event|event.parallel?}
		$data_common_auto				= $data_common_events.values.select{|event|event.autorun?}
		$data_system					= load_data("Data/System.rvdata2") #RPG::System.new #

		load_system_term_configs #overwrite system
		$data_mapinfos					= load_data("Data/MapInfos.rvdata2")
		$data_LonaMood					= FileGetter.load_mood
		load_skills_to_SkillHash
		load_items_to_ItemHash #create $data_ItemName
		load_state_to_StateHash #create $data_StateHash
		load_itemconfigs
		load_itemconfigs_actors
		load_itemconfigs_classes
		$chs_data				= load_chs_datas
		$loading_screen.update("Init NPC") if $loading_screen
		$data_npcs				= load_npcs
		$data_tag_maps			= {}
		$data_region_maps		= {}
		$loading_screen.update("Init ARPG SKILLS") if $loading_screen
		$data_arpgskills				= FileGetter.load_skill_data
		$data_EventLib					= FileGetter.read_EventLib
		$data_barters					= FileGetter.load_barter_settings_from_dir
		$data_AlchemyRecipes			= FileGetter.load_alchemy_recipes_from_dir
		load_tag_and_reg_maps #
		$loading_screen.update("Init NPC PORTRAIT") if $loading_screen
		$data_npc_portraits		= FileGetter.load_npc_portraits
		$loading_screen.update("Init LONA PORTRAIT") if $loading_screen
		$data_lona_portrait		= FileGetter.load_lona_portrait # data composition : [name_order,parts] , note this is a relatively ancient one
		#$data_npcLayered_portrait	= FileGetter.load_NPC_layered_portrait # data composition : [name_order,parts] , note this is a relatively ancient one
		$data_BGMvol			= get_vol_constant("BGMvol")
		$data_SNDvol			= get_vol_constant("SNDvol")
		$data_PrtFocusMode		= get_constant("LonaRPG","PrtFocusMode",1) #0 auto #1 Skip when combat #2 except EV #unused
		$data_ToneMode			= get_map_background_color_constant #get_constant("LonaRPG","MapBgMode",1)
		$data_GamePadUImode		= get_text_constant("LonaRPG","GamePadUImode",16)
		$loading_screen.update("Init MODS") if $loading_screen
		load_mod_database #create MOD loader
		InputUtils.update_padSYM_in_UI
		dbg_itemDataBase if $TEST
		dbg_skillsDataBase if $TEST
		dbg_statesDataBase if $TEST
		dbg_eventlib if $TEST
		dbg_dump_mapinfo_tree if $TEST
		#dbg_barters if $TEST

		Cache.precache_lona_prt_bitmap("pose") if $LonaINI["Cache"]["PrecacheLonaPoseBitmaps"] == 1 && $LonaINI["Cache"]["PrecacheLonaAllBitmaps"] != 1
		Cache.precache_lona_prt_bitmap("chcg") if $LonaINI["Cache"]["PrecacheLonaChcgBitmaps"] == 1 && $LonaINI["Cache"]["PrecacheLonaAllBitmaps"] != 1
		Cache.precache_lona_prt_bitmap("all") if $LonaINI["Cache"]["PrecacheLonaAllBitmaps"] == 1
		Cache.precache_npc_prt_bitmap if $LonaINI["Cache"]["PrecacheNpcPrtBitmaps"] == 1
	end
	
	def self.load_mod_database
		#empty  so u can mod
	end
	def self.load_skills_to_SkillHash
		$data_SkillName = Hash.new
		p "DataManager.load_skills_to_SkillHash generate SkillHash"
		p "$data_skills generate SkillHash"
		$data_skills.each{|skill|
			next if !skill
			next if !skill.name
			$data_SkillName[skill.name] = skill
		}
		p "DataManager.load_skills_to_SkillHash Finished"
	end
	def self.load_items_to_ItemHash
		$data_ItemName = Hash.new
		p "DataManager.load_items_to_ItemHash generate ItemHash"
		p "$data_weapons generate ItemHash"
		$data_weapons.each{|item|
			next if !item
			next if !item.name
			$data_ItemName[item.name] = item
		}
		p "$data_armors generate ItemHash"
		$data_armors.each{|item|
			next if !item
			next if !item.name
			$data_ItemName[item.name] = item
		}
		p "$data_items generate ItemHash"
		$data_items.each{|item|
			next if !item
			next if !item.name
			$data_ItemName[item.name] = item
		}
		p "DataManager.load_items_to_ItemHash Finished"
	end
	def self.load_state_to_StateHash
		$data_StateName = Hash.new
		p "DataManager.load_states_to_StateHash generate StateHash"
		p "$data_skills generate SkillHash"
		$data_states.each{|state|
			next if !state
			next if !state.name
			$data_StateName[state.name] = state
		}
		p "DataManager.load_states_to_StateHash Finished"
	end
	
	def self.createLangArray
		langIndex = 0
		langFolderCheck = Array.new
		Dir.entries('Text').select { |file|
			next if file == '.'
			next if file == '..'
			next if !File.directory?(File.join('Text', file))
			tmpTarLang = file.to_s
			langIndex +=1
			#break if langIndex >4
			langFolderCheck << tmpTarLang
		}
		langFolderCheck
	end
	
  
	def self.get_text_constant(tmpFolder="LonaRPG",tmpName,tmpBuffer)
		info = $LonaINI[tmpFolder][tmpName]
		return info if info
		return ""
	end
  
	def self.write_lang_constant
		$LonaINI["LonaRPG"]["Language"] = $lang
		$LonaINI.save
	end
  
	def self.get_rec_constant(tmpRec)
		info = $LonaINI["LonaRPG_Rec"][tmpRec]
		return info if info
		return 0
	end
  
	def self.write_rec_constant(tmpRec,tmpVol)
		$LonaINI["LonaRPG_Rec"][tmpRec] = tmpVol
		$LonaINI.save
	end

	def self.get_constant(tmpFolder="LonaRPG",tmpName,tmpBuffer)
		info = $LonaINI[tmpFolder][tmpName]
		return info if info
		return 0
	end
  
	def self.write_constant(tmpFolder="LonaRPG",tmpName,tmpVol)
		$LonaINI[tmpFolder][tmpName] = tmpVol
		$LonaINI.save
	end

	def self.get_map_background_color_constant
		# Array with file names only
		result = get_map_background_color_result
		file_names = result.keys
		info = $LonaINI["LonaRPG"]["MapBgMode"]
		result[info]
	end
	#will make hash with files {filename=>path/name.png}
	def self.get_map_background_color_result
		files = Dir.glob("Graphics/System/MapBackgroundColor/*.png")

		# Create hash from files
		result = Hash[files.map { |f| [File.basename(f, ".png"), f] }]
		# Set default value if key not found
		result.default = "nil"

		result
	end
	def self.get_vol_constant(tmpRec)
		info = $LonaINI["LonaRPG"][tmpRec]
		return info if info
		return 100
	end

	def self.write_vol_constant(tmpRec,tmpVol)
		$LonaINI["LonaRPG"][tmpRec] = tmpVol
		$LonaINI.save
	end
	
	def self.load_tag_and_reg_maps
		#$data_MapFilename = {} if !$data_MapFilename
		mapinfo=load_data("Data/MapInfos.rvdata2")
		mapinfo.keys.each{|key|
			begin 
			filename = sprintf("Data/Map%03d.rvdata2", key)
			map = load_data(filename)
			add_data=Note.get_data(map.note)
			set_tag_maps(key,add_data)
			set_region_maps(key,add_data)
			$data_mapinfos[key].id = key
			$data_mapinfos[key].filename = filename
			#$data_MapFilename[filename] = $data_mapinfos[key]
			rescue =>ex
				msgbox "Error on map #{sprintf("Data/Map%03d.rvdata2", key)}, need attention, exception:#{ex.message}"
			end
		}
		prp "aft load_tag_and_reg_maps"
	end

	def self.set_tag_maps(map_id,add_data)
		return if add_data["event"].nil?
		events=add_data["event"].split(",")
		events.each{
			|event|
			$data_tag_maps[event]=Array.new if $data_tag_maps[event].nil?
			$data_tag_maps[event] << map_id
		}
	end

	def self.set_region_maps(map_id,add_data)
		return if add_data["region"].nil?
		regions=add_data["region"].split(",")
		regions.each{|reg|
			$data_region_maps[reg.to_i]=Array.new if $data_region_maps[reg.to_i].nil?
			$data_region_maps[reg.to_i] << map_id
		}
	end
  
	def self.extra_map_register(mapname,filename)
		#$data_MapFilename = {} if !$data_MapFilename
		#tgtID = $data_mapinfos.keys.max+1
		tgtID = 0
		$data_mapinfos.each{|k, v| tgtID = v.id if v.id > tgtID }
		tgtID = tgtID+1
		$data_mapinfos[filename] = RPG::MapInfo.new
		$data_mapinfos[filename].name = mapname
		$data_mapinfos[filename].filename = filename
		$data_mapinfos[filename].id = tgtID
		#map = load_data(filename)
		#add_data=Note.get_data(map.note)
		#set_tag_maps(tgtID,add_data)
		#set_region_maps(tgtID,add_data)
		#$data_MapFilename[filename] = $data_mapinfos[filename]
	end

	def self.load_npcs
		return load_data("Data/NonPlayerCharacters.rvdata2") if FileGetter::COMPRESSED 
		return FileGetter.load_NPCs_from_dir(tmpDir="Data/NPCdata/")
	end

	def self.load_system_term_configs
		prp "DataManager.load_system_term_configs"
		$data_system.airship = nil
		$data_system.test_battlers = nil
		$data_system.elements = nil
		$data_system.battle_end_me = nil
		$data_system.ship = nil
		$data_system.sounds = nil
		$data_system.gameover_me = nil
		$data_system.terms = nil
		$data_system.title_bgm = nil
		$data_system.battle_bgm = nil
		$data_system.starting_equip = nil
		$data_system.gear_stats_update_flow = nil
		data = FileGetter.load_system_term_configs
		data.each do |hashName,hashData|
			p "data.json"
			p "overwrite $data_system #{hashName}"
			eval("$data_system.#{hashName} = hashData")
		end
		$data_system.equip_type = $data_system.equip_type.transform_keys(&:to_i)
		$data_system.equip_type_name = $data_system.equip_type.map { |id, (name, removable, optimize)| [name, id] }.to_h #reverse it to [name,id]
		prp "load_system_term_configs end"
	end
	def self.load_itemconfigs
		prp "DataManager.load_itemconfigs"
		$data_itemconfigs = {}
		order=0
		data_type=["Items","Weapons","Armors","States"]
		[$data_items,$data_weapons,$data_armors,$data_states,$data_skills].each{|dataSet|
			order+=1
			num=-1
				dataSet.each{|data| 
				num+=1
				next if data.nil?
				begin
					data.load_additional_data
				rescue =>ex
					p "num #{num} of type : #{data_type[order-1]} name=#{data.name}"
				end
			}
		}
	end
	def self.load_itemconfigs_actors
		prp "DataManager.load_itemconfigs_actors"
		$data_actors.each{|data|
			next if data.nil?
			data.load_additional_data
		}
	end
	def self.load_itemconfigs_classes
		prp "DataManager.load_itemconfigs_classes"
		$data_classes.each{|data|
			next if data.nil?
			data.load_additional_data
		}
	end

	def self.load_chs_datas
		#return load_data("Data/CHS_Data.rvdata2") if FileGetter::COMPRESSED
		chs_datas=FileGetter::load_chs_settings_from_dir
		#save_data(chs_datas,"Data/CHS_Data.rvdata2") if !FileGetter::COMPRESSED && FileGetter::WRITING_LIST
		chs_datas
	end
	def self.load_tilesets(file="Data/Tilesets.rvdata2")
		exportHash = {}
		sourceData = load_data(file)
		sourceData.each_index{|i|
			exportHash[i] = sourceData[i]
			next if sourceData[i].nil?
			next if sourceData[i].name == ""
			exportHash[sourceData[i].name] = sourceData[i]
		}
		exportHash
	end
	def self.load_extra_tilesets(file,bmpPath)
		exportHash = {}
		sourceData = load_data(file)
		sourceData.each_index{|i|
			next if sourceData[i].nil?
			next if sourceData[i].name == ""
			sourceData[i].tileset_names.each_index{|tileNameI|
				next if sourceData[i].tileset_names[tileNameI].nil?
				next if sourceData[i].tileset_names[tileNameI] == ""
				#p FileTest.exist?(bmpPath + sourceData[i].tileset_names[tileNameI] + ".png")
				#p "../../" + bmpPath + sourceData[i].tileset_names[tileNameI] + ".png"
				#msgbox "Asdaslkjdalskjdasd"
				next unless FileTest.exist?(bmpPath + sourceData[i].tileset_names[tileNameI] + ".png")
				sourceData[i].tileset_names[tileNameI] = "../../" + bmpPath + sourceData[i].tileset_names[tileNameI]
			}
			exportHash[sourceData[i].name] = sourceData[i]
		}
		exportHash
	end
	def self.load_common_events
		prp "DataManager.load_common_events"
		exportHash = {}
		sourceData = FileGetter.load_common_events_from_dir
		sourceData.each{|tgtData|
			newEV = RPG::CommonEvent.new
			newEV.load_common_event_data(tgtData)
			exportHash[tgtData["name"].to_sym] = newEV
		}
		exportHash
	end

	#$data_weapons					= load_data_weapons ######################################################################################3
	#load_itemconfigs_weapons 					######################################################################################3

	#def self.load_data_weapons
	#	exportHash = {}
	#	fileNamelist = FileGetter.getFileListFileOnly("Data/Effects/Weapons/*.json")
	#	filelistWithPath = FileGetter.getFileList("Data/Effects/Weapons/*.json")
	#	fileNamelist.each.with_index(0) do |fileName, index|
	#		json_file = File.open(filelistWithPath[index])
	#		json_data = JSON.decode(json_file.read)
	#		tgtID = index + 1
	#		puts "Processing file ##{tgtID}: #{fileName} #{json_data["item_name"]}"
	#		tgtWeapon = RPG::Weapon.new
	#		tgtWeapon.id = tgtID
	#		tgtWeapon.addData = {} if !tgtWeapon.addData
	#		tgtWeapon.addData["eff_cfg"] = fileName
	#		exportHash[json_data["item_name"]] = tgtWeapon
	#	end
	#	exportHash
	#end
	#def self.load_itemconfigs_weapons
	#	$data_weapons.each{|hashName,data|
	#		$data_weapons[hashName].load_additional_data(data.base_folder + "/" + data.addData["eff_cfg"])
	#	}
	#end
  #--------------------------------------------------------------------------
  # * Check Player Start Location Existence
  #--------------------------------------------------------------------------
  def self.check_player_location
    if $data_system.start_map_id == 0
      msgbox(Vocab::PlayerPosError)
      exit
    end
  end
  #--------------------------------------------------------------------------
  # * Create Game Objects
  #--------------------------------------------------------------------------
	def self.create_game_objects
		$story_stats		= Story_Stats.new 
		$game_date			= Game_Date.new(1772,3,1,1)
		$game_temp			= Game_Temp.new
		$game_system		= Game_System.new
		$game_timer			= Game_Timer.new
		$game_message		= Game_Message.new
		$game_switches		= Game_Switches.new
		$game_variables		= Game_Variables.new
		$game_self_switches	= Game_SelfSwitches.new
		$game_actors		= Game_Actors.new
		$game_NPCLayerMain	= Game_NPC_Actor.new("NPCLayerMain") # to class actors.
		$game_NPCLayerSub	= Game_NPC_Actor.new("NPCLayerSub") # to class actors.
		$game_portraits		= Portrait_System.new  # automatically grabs existing $data_npc_portraits & $data_lona_portrait
		$game_party			= Game_Party.new
		#$game_troop			= Game_Troop.new #remove in future
		$game_map			= Game_Map.new
		$game_player		= Game_Player.new
		$dialog_timer		= Dialog_Timer.new
		$game_text			= Text.new("Text/#{$lang}")
		$mail_text			= MailText.new("Text/#{$lang}/mail/")
		$game_boxes 		= IMP1_Game_Boxes.new
		$game_pause			= false
		$hudForceHide		= false
		$balloonForceHide	= false
		load_mod_game_objects
		update_Lang
	end

	def self.load_mod_game_objects
		#empty so u can mod
	end
  #--------------------------------------------------------------------------
  # * Set Up New Game
  #--------------------------------------------------------------------------
	def self.setup_new_game(tmp_tomap=true,tagName="NoerSewer")
		create_game_objects
		create_temp_graphics
		$game_party.setup_starting_members
		$game_map.force_setup=true
		$game_pause = false
		if tmp_tomap
			$game_map.setup($data_tag_maps[tagName].sample)
			$game_player.moveto(0, 0)
		end
		#$game_actors[1].setup(1) #setup twice
		$game_player.actor.post_setup
		$game_player.actor.prtmood("normal") #Lona portrait loaded here ,must fix
		$game_player.actor.update_state_frames
		$game_player.refresh
		$game_map.set_light
		#$game_temp.reserve_story("BIOS")
		Graphics.frame_count = 0
		$game_map.interpreter.new_game_setting ##29_Functions_417
		$game_player.actor.setup_inheritance($inheritance)
		$game_map.interpreter.new_game_SetFetishLevel ##29_Functions_417
		$story_stats["VerInfo"] = export_full_ver_info
		$game_player.actor.refresh_equip_part_covered
		$game_player.actor.refresh
	end

  #--------------------------------------------------------------------------
  # * Maximum Number of Save Files
  #--------------------------------------------------------------------------
  #--------------------------------------------------------------------------
  # * Determine Existence of Save File
  #--------------------------------------------------------------------------
	def self.saveFileMAX
		System_Settings::SAVE_FILE_MAX
	end
	def self.userDataPath
		System_Settings::USER_DATA_PATH
	end
	def self.userDataPath_FileSaveDoom
		System_Settings::USER_DATA_PATH_FILE_SAVE_DOOM
	end
	def self.userDataPath_FileSaveAuto_E
		System_Settings::USER_DATA_PATH_FILE_SAVE_AUTO_E
	end

	def self.userDataPath_FileSaveAuto_S
		System_Settings::USER_DATA_PATH_FILE_SAVE_AUTO_S
	end
	def self.saveFileExistsRGSS? #basic game saves
		!Dir.glob(userDataPath+'Save*.rvdata2').empty?
	end
	
	def self.saveFileExistsRGSS_slot?(slot)#basic game saves for LOAD/SAVE UI
		!Dir.glob(userDataPath+'Save0'+"#{slot}"+".rvdata2").empty?
	end

	def self.saveFileExistsDOOM?
		FileTest.exist?(userDataPath_FileSaveDoom)
	end
	
	def self.saveFileExistsAUTO_E?
		FileTest.exist?(userDataPath_FileSaveAuto_E)
	end
	def self.saveFileExistsAUTO_S?
		FileTest.exist?(userDataPath_FileSaveAuto_S)
	end
	def self.saveFileDeleteDoom
		return if !self.saveFileExistsDOOM?
		File.delete(userDataPath_FileSaveDoom)
	end
	def self.make_filename(index)
		sprintf(userDataPath+"Save%02d.rvdata2", index + 1)
	end
	def self.make_filename_screenshot(index)
		sprintf(userDataPath+"Save%02d.png", index + 1)
	end
	def self.make_filenameDoom
		sprintf(userDataPath_FileSaveDoom)
	end
  #--------------------------------------------------------------------------
  # * Execute Save
  #--------------------------------------------------------------------------
	def self.save_game(index)
		return if $story_stats["Setup_Hardcore"] >= 2
		begin
			save_game_without_rescue(index)
		rescue => ex
			msgbox("exception during save")
			p ex
			delete_save_file(index)
			false
		end
	end
  
	def self.doomModeSave
		begin
			save_doom_without_header
		rescue => ex
			msgbox("exception during save")
			p ex
			saveFileDeleteDoom
			false
		end
	end

	
	def self.doAutoSave(tmpDepose=false,doomOnly=false)
		return if $story_stats["MenuSysSavegameOff"] >= 1
		SceneManager.scene.dispose_spriteset if tmpDepose
		if $story_stats["Setup_Hardcore"] >= 2
			doomModeSave
		else
			if $game_date.dateAmt.even?
				save_custom_without_header("SavAutoE") if !doomOnly
			else
				save_custom_without_header("SavAutoS") if !doomOnly
			end
			#save_custom_without_header("SavAuto") if !doomOnly
		end
		SceneManager.scene.create_spriteset if tmpDepose
	end
	
  #--------------------------------------------------------------------------
  # * Execute Load
  #--------------------------------------------------------------------------
  
	def self.load_game(index)
		load_game_without_rescue(index) rescue false
	end
  
	def self.doomModeLoad
		load_doom_without_rescue rescue false
	end
 
	def self.customModeLoad(tmpName)
		load_custom_without_rescue(tmpName) rescue false
	end
  
  #--------------------------------------------------------------------------
  # * Load Save Header
  #--------------------------------------------------------------------------
  def self.load_header(index)
    load_header_without_rescue(index) rescue nil
  end
  #--------------------------------------------------------------------------
  # * Execute Save (No Exception Processing)
  #--------------------------------------------------------------------------
	def self.make_save_screenshot(index)
		bmp=Bitmap.new(264,160)
		x_origin=Graphics.width/2 - bmp.width/2
		y_origin= Graphics.height/2 - bmp.height/2
		bmp.blt(0,0,SceneManager.background_bitmap,Rect.new(x_origin,y_origin,bmp.width,bmp.height))
		begin
			bmp.export(make_filename_screenshot(index))
		rescue  => ex
			p "DataManager failed to export file #{make_filename_screenshot(index)}"
		end
		bmp.dispose
	end
	def self.save_game_without_rescue(index)
		return false if $story_stats["Setup_Hardcore"] >= 2
		$story_stats["record_GameSaved"] += 1
		make_save_screenshot(index)
		File.open(make_filename(index), "wb") do |file|
			$game_system.on_before_save
			$game_map.clear_cached_npc_skills
			Marshal.dump(make_save_header, file)
			Marshal.dump(make_save_contents, file)
			@last_savefile_index = index
		end
		return true
	end
  
	def self.save_doom_without_header
		File.open(make_filenameDoom, "wb") do |file|
			$game_system.on_before_save
			$game_map.clear_cached_npc_skills
			Marshal.dump(make_DoomSave_header, file)
			Marshal.dump(make_save_contents, file)
		end
		return true
	end
  
	def self.save_custom_without_header(tmpName)
		tmpTar = sprintf(userDataPath+"#{tmpName}.rvdata2")
		File.open(tmpTar, "wb") do |file|
		$game_system.on_before_save
		$game_map.clear_cached_npc_skills
		Marshal.dump(make_DoomSave_header, file)
		Marshal.dump(make_save_contents, file)
		end
		return true
	end
  #--------------------------------------------------------------------------
  # * Execute Load (No Exception Processing)
  #--------------------------------------------------------------------------
	def self.load_game_without_rescue(index)
		return false if !FileTest.exist?(make_filename(index))
		DataManager.create_game_objects #to clearn up all key and data remain
		File.open(make_filename(index), "rb") do |file|
			header = DataManager.load_header(index) #temp
			header = Hash.new("ERR") if !header
			return false if header[:doom_mode] && header[:doom_mode] != "ERR"
			Marshal.load(file)
			extract_save_contents(Marshal.load(file))
			@last_savefile_index = index
			$hudForceHide = false
			$balloonForceHide = false
		end
		return true
	end
	
	def self.load_doom_without_rescue
			File.open(make_filenameDoom, "rb") do |file|
			Marshal.load(file)
			extract_save_contents(Marshal.load(file))
			$hudForceHide = false
			$balloonForceHide = false
		end
		return true
	end
	
	def self.load_custom_without_rescue(tmpName)
		tmpTar = sprintf(userDataPath+"#{tmpName}.rvdata2")
		File.open(tmpTar, "rb") do |file|
			Marshal.load(file)
			extract_save_contents(Marshal.load(file))
			$hudForceHide = false
			$balloonForceHide = false
		end
		return true
	end

	def self.customLoadName
		@customLoadName
	end
	
	def self.customLoadNameSet(tmpVal)
		@customLoadName = tmpVal
	end
  #--------------------------------------------------------------------------
  # * Load Save Header (No Exception Processing)
  #--------------------------------------------------------------------------
  def self.load_header_without_rescue(index)
    File.open(make_filename(index), "rb") do |file|
      return Marshal.load(file)
    end
    return nil
  end
  #--------------------------------------------------------------------------
  # * Delete Save File
  #--------------------------------------------------------------------------
  def self.delete_save_file(index)
    File.delete(make_filename(index)) rescue nil
  end
  #--------------------------------------------------------------------------
  # * Create Save Header
  #--------------------------------------------------------------------------
	def self.export_full_ver_info
		"#{$GameINI["Game"]["Title"]}.#{$data_system.version_id.to_s(16).upcase}"
	end
  def self.make_save_header
		header = {}
		if $story_stats["VerInfo"] == export_full_ver_info
			header[:ver] 			= export_full_ver_info
		else
			header[:ver]			= "#{$story_stats["VerInfo"]}"
		end
			header[:date] 				= "#{$game_date.date[0]}.#{$game_date.date[1]}.#{$game_date.date[2]}"
			header[:characters] 		= "#{$game_party.characters_for_savefile}"
			header[:playtime_s]			= "#{$game_system.playtime_s}"
			header[:stat_lv] 			= "Lv#{$game_player.actor.level}"
			header[:stat_health] 		= "#{$game_player.actor.health.round}"
			header[:stat_sta] 			= "#{$game_player.actor.sta.round}"
			header[:stat_sat] 			= "#{$game_player.actor.sat.round}"
			header[:stat_mood] 			= "#{$game_player.actor.mood.round}"
			header[:stat_atk] 			= "#{$game_player.actor.atk.round(2)}"
			header[:stat_def] 			= "#{$game_player.actor.def.round(2)}"
			header[:stat_combat] 		= "#{$game_player.actor.combat.round(2)}"
			header[:stat_scoutcraft]	= "#{$game_player.actor.scoutcraft.round(2)}"
			header[:stat_wisdom]		= "#{$game_player.actor.wisdom.round(2)}"
			header[:stat_constitution]	= "#{$game_player.actor.constitution.round(2)}"
			header[:stat_survival]		= "#{$game_player.actor.survival.round(2)}"
			header[:stat_sexy]			= "#{$game_player.actor.sexy.round(2)}"
			header[:stat_weak]			= "#{$game_player.actor.weak.round(2)}"
			header[:stat_morality]		= "#{$game_player.actor.morality.round(2)}"
			header[:title] 				= "DataTitle:#{$game_player.actor.record_lona_title}"
			header[:mod_data ]			= $mod_manager.output_data_to_array
		header
	end
	
	def self.make_DoomSave_header
		header = {}
		if $story_stats["VerInfo"] == export_full_ver_info
			header[:ver] 			= export_full_ver_info
		else
			header[:ver]			= "#{$story_stats["VerInfo"]}"
		end
		header[:doom_mode] 			= true 
		header
	end
	
	
  #--------------------------------------------------------------------------
  # * Create Save Contents
  #--------------------------------------------------------------------------
	def self.make_save_contents
		contents = {}
		contents[:system]			= $game_system
		contents[:timer]			= $game_timer
		contents[:message]			= $game_message
		contents[:switches]			= $game_switches #will be remove
		contents[:variables]		= $game_variables #will be remove
		contents[:self_switches]	= $game_self_switches #will be remove
		contents[:actors]			= $game_actors
		contents[:party]			= $game_party
		#contents[:troop]			= $game_troop
		contents[:map]				= $game_map
		contents[:player]			= $game_player
		contents[:game_NPCLayerMain]= $game_NPCLayerMain
		contents[:game_NPCLayerSub]	= $game_NPCLayerSub
		contents[:date]				= $game_date
		contents[:story]			= $story_stats
		contents[:game_pause]		= $game_pause
		contents[:imp_boxes]		= $game_boxes
		#contents[:mod_data ]		= $mod_manager.output_data_to_array # in make_save_header
		contents
	end
  #--------------------------------------------------------------------------
  # * Extract Save Contents
  #--------------------------------------------------------------------------
  def self.extract_save_contents(contents)
		create_temp_graphics
		$game_system				= contents[:system]
		$game_timer					= contents[:timer]
		$game_message				= contents[:message]
		$game_switches				= contents[:switches] #will be remove
		$game_variables				= contents[:variables] #will be remove
		$game_self_switches			= contents[:self_switches] #will be remove
		$game_actors				= contents[:actors]
		$game_party					= contents[:party]
		#$game_troop				= contents[:troop]
		$game_map					= contents[:map]
		$game_player				= contents[:player]
		$game_NPCLayerMain 			= contents[:game_NPCLayerMain]
		$game_NPCLayerSub  			= contents[:game_NPCLayerSub]
		$game_date					= contents[:date]
		$game_pause					= contents[:game_pause]
		$story_stats				= contents[:story]
		$game_boxes					= contents[:imp_boxes]
		$game_portraits.getPortrait("Lona").base_char			= $game_actors[1]
		$game_portraits.getPortrait("NPCLayerMain").base_char	= $game_NPCLayerMain
		$game_portraits.getPortrait("NPCLayerSub").base_char	= $game_NPCLayerSub
		$game_map.starting_events = [] if $game_map.starting_events.nil? #antiLag
		$game_player.actor.actStat.actor = $game_player.actor
  end
  
	def self.create_temp_graphics
		p "create_temp_graphics 1"
		$cg = TempCG.new(["nil"])
		p "create_temp_graphics 2"
		$cg.erase
		p "create_temp_graphics 3"
		$bg = TempBG.new(["nil"])
		$bg.erase
  end
  
  #--------------------------------------------------------------------------
  # * Reload Map if Data Is Updated
  #--------------------------------------------------------------------------
  def self.reload_map_if_updated
    if $game_system.version_id != $data_system.version_id
      $game_map.setup($game_map.map_id)
      $game_player.center($game_player.x, $game_player.y)
      $game_player.make_encounter_count
    end
  end
  #--------------------------------------------------------------------------
  # * Get Update Date of Save File
  #--------------------------------------------------------------------------
  def self.savefile_time_stamp(index)
    File.mtime(make_filename(index)) rescue Time.at(0)
  end
  #--------------------------------------------------------------------------
  # * Get File Index with Latest Update Date
  #--------------------------------------------------------------------------
	def self.latest_savefile_index
		saveFileMAX.times.max_by {|i| savefile_time_stamp(i) }
	end
  #--------------------------------------------------------------------------
  # * Get Index of File Most Recently Accessed
  #--------------------------------------------------------------------------
  def self.last_savefile_index
    @last_savefile_index
  end
  #debug function
	def self.dbg_exportTXT(data)
		open("_asdasdasd.txt","w")do|file|
			info= data
			file.print(info)
		end
	end
	def self.dbg_eventlib
		open("_EventLib.txt","w")do
			|file|
			file.print("EventLib:  \n")
			file.print("Date : #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}  \n")
			$data_EventLib.each{|evID,evData|
				next if !evID
				next if !evData
				info= "#{evData[0]} X:#{evData[1].x} Y:#{evData[1].y} #{evID} "
				file.print(info+"\n")
			}
		end
		p "Log generated at _EventLib.txt"
	end
#	def self.dbg_mapids
#		open("_MapIdList.txt", "w") do |file|
#			file.print("MapInfo:  \n")
#			file.print("Date : #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}  \n")
#
#			# Separate integer and non-integer keys
#			int_keys = $data_mapinfos.select { |k, _| k.is_a?(Integer) }.sort
#			str_keys = $data_mapinfos.select { |k, _| k.is_a?(String) }.sort
#
#			# Process integer keys first
#			int_keys.each do |k, v|
#				info = sprintf("id:%-3d   name:  %s", k, v.name)
#				p info
#				file.print(info + "\n")
#			end
#
#			# Process string keys next
#			str_keys.each do |k, v|
#				info = sprintf("id:%-3s   name:  %s", k, v.name)
#				p info
#				file.print(info + "\n")
#			end
#		end
#		p "Log generated at _MapIdList.txt"
#	end
	def self.dbg_itemDataBase
		open("_ItemDataBase.txt","w")do 
		|file|
			file.print("$data_ItemName ItemList:  \n")
			file.print("Date : #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}  \n")
			$data_ItemName.each{|wut,item|
				next if !item
				next if !item.id
				next if !item.item_name
				itemType = "Unknow"
				itemType = "0 RPG::Item" if item.class == RPG::Item
				itemType = "1 RPG::Armor" if item.class == RPG::Armor
				itemType = "2 RPG::Weapon" if item.class == RPG::Weapon
				info= "#{itemType} #{item.id} #{item.item_name}"
				#info= "class =>#{itemType} id=>#{item.id} item_name#{item.item_name}"
				p info
				file.print(info+"\n")
			}
		end
		p "Log generated at _itemDataBase.txt"
	end
	def self.dbg_name_order_scan
		log_file = "_NameOrderScanLog.txt"
		open(log_file, "w") do |file|
			file.puts "Name Order Scan Report"
			file.puts "Date : #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}"
			file.puts "-" * 60

			base_path = "Data/Pconfig/Pconfig_lona/poses/"
			Dir.glob("#{base_path}*/").each do |folder|
				mismatches = FileGetter.debug_scan_name_order(folder)

				# Console + Msgbox feedback
				#msgbox("Scanned folder: #{File.basename(folder)}\nCheck your console + log file.")
				p "Scanning #{folder}"

				if mismatches.empty?
					result = "✔ Folder #{File.basename(folder)} has no mismatches."
					p result
					file.puts result
				else
					result = "✘ Folder #{File.basename(folder)} has #{mismatches.size} mismatches."
					p result
					file.puts result
					mismatches.each { |m| file.puts "   - #{m}" }
				end

				file.puts "-" * 40
			end
		end

		p "Log generated at #{log_file}"
	end
	def self.dbg_name_order_scan
		log_file = "_NameOrderScanLog.txt"
		open(log_file, "w") do |file|
			file.puts "Name Order Scan Report"
			file.puts "Date : #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}"
			file.puts "-" * 60

			# case 1: Pconfig_lona scans subfolders
			folderList = Dir.glob("Data/Pconfig/Pconfig_lona/poses/*/")
			folderList += [
				"Data/Pconfig/Pconfig_LayeredNPC/poses/",
				"Data/CHSConfig/CHSconfigs_ActorHLayer/",
				"Data/CHSConfig/CHSconfigs_ActorLayer/"
			]
			folderList.each do |folder|
				mismatches = FileGetter.debug_scan_name_order(folder)

				#msgbox("Scanned folder: #{File.basename(folder)}\nCheck your console + log file.")
				p "Scanning #{folder}"

				if mismatches.empty?
					result = "✔ Folder #{folder} has no mismatches."
					p result
					file.puts result
				else
					result = "✘ Folder #{folder} has #{mismatches.size} mismatches."
					p result
					file.puts result
					mismatches.each { |m| file.puts "   - #{m}" }
				end
				file.puts "-" * 40
			end
		end

		p "Log generated at #{log_file}"
	end

	def self.dbg_skillsDataBase
		open("_SkillDataBase.txt","w")do 
		|file|
			file.print("$data_SkillName SkillList:  \n")
			file.print("Date : #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}  \n")
			$data_SkillName.each{|wut,item|
				next if !item
				next if !item.id
				next if !item.item_name
				info= " #{item.id} #{item.item_name}"
				p info
				file.print(info+"\n")
			}
		end
		p "Log generated at _SkillDataBase.txt"
	end
  
	def self.dbg_statesDataBase
		open("_StateDataBase.txt","w")do 
		|file|
			file.print("$data_StateName SkillList:  \n")
			file.print("Date : #{Time.now.strftime("%Y/%m/%d %H:%M:%S")}  \n")
			$data_StateName.each{|wut,state|
				next if !state
				next if !state.id
				next if !state.item_name
				info= " #{state.id} #{state.item_name}"
				p info
				file.print(info+"\n")
			}
		end
		p "Log generated at _StateDataBase.txt"
	end
	def self.dbg_dump_mapinfo_tree(path = "_MapInfoTree.txt", ascending = true)
		# 可先在腳本最前面 $data_mapinfos = load_data(...)，這裡就不用再載
		infos = $data_mapinfos || load_data("Data/MapInfos.rvdata2")  # {id => RPG::MapInfo}

		# 分開整數 ID 與字串 ID
		int_infos = infos.select { |k, _| k.is_a?(Integer) }
		str_infos = infos.select { |k, _| k.is_a?(String) }

		# ---------- 建立 children 關係（只處理整數 ID） ----------
		children = Hash.new { |h, k| h[k] = [] }
		int_infos.each do |id, info|
			next unless info
			children[info.parent_id] << [id, info]
		end

		# ---------- 依 order 排序 ----------
		sorter = ascending ? ->(pair) { pair[1].order } : ->(pair) { -pair[1].order }
		children.each_value { |ary| ary.sort_by!(&sorter) }

		File.open(path, "w") do |file|
			# ----- 標頭 -----
			file.puts "MapInfo:"
			file.puts "Date : #{Time.now.strftime('%Y/%m/%d %H:%M:%S')}"
			file.puts

			# ----- 走訪整數 ID 樹狀 -----
			walker = lambda do |node_id, info, depth|
				file.puts "#{'	' * depth}id:#{node_id} => \"#{info.name}\""
				children[node_id].each { |cid, cinfo| walker.call(cid, cinfo, depth + 1) }
			end
			children[0].each { |rid, rinfo| walker.call(rid, rinfo, 0) }

			# ----- 在最下面列出字串 ID（模組地圖） -----
			unless str_infos.empty?
				file.puts
				file.puts "# ---- Modded maps (string IDs) ----"
				str_infos.sort_by { |k, _| k }.each do |sid, sinfo|
					file.puts "id:#{sid} => \"#{sinfo.name}\""
				end
			end
		end

		puts "Log generated at #{path}"
	end

	#for mod api
	#$data_AlchemyRecipes.insert( darkPot_find_item_index("ItemCarbon")+1,your_REcipe_data)
	#this insert ur recipe under ItemCarbon.
	def self.darkPot_find_item_index(recipe_name, ary=$data_AlchemyRecipes)
		index = ary.find_index { |item| item["export_name"] == recipe_name }
		if index
			puts "#{recipe_name} found at index #{index}"
		else
			return msgbox "#{recipe_name} not found"
		end
		index
	end
end
