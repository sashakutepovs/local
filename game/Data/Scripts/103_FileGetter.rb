#==============================================================================
# This script is created by Kslander 
#==============================================================================
#==================================================================================
#這個模組主要負責處理壓縮檔案狀況下的讀取與載入。
#FileGetter::COMPRESSED :  是否為已壓縮的狀態
#FileGetter::WRITING_LIST :	是否需要更新已寫成rvdata2的清單，只在非壓縮狀態下有效。
#==================================================================================


module FileGetter

	def self.getFileList(dir)
		fileList=Dir[dir].select{|item|
			File.file?(item)
		}
		#讓檔案按照檔名理的數字排序
		fileList.sort_by!{|x| 
		@rst=x.split("/").last.split("_")[0]
		@rst.to_i
		}
		fileList.each{|filePath|
			filePath=filePath.gsub(/^.\//,"")
			$loading_screen.update(nil) if $loading_screen
		}
		fileList
	end
	def self.getFileListFileOnly(dir)             #unused
		fileList = Dir[dir].select { |item| File.file?(item) }
		# 讓檔案按照檔名裡的數字排序
		fileList.sort_by! do |x|
			x.split("/").last.split("_")[0].to_i
		end
		# 移除路徑，只保留檔名
		fileList.map! do |filePath|
			$loading_screen.update(nil) if $loading_screen
			File.basename(filePath)
		end
		fileList
	end

	def self.load_from_list(list)
		for i in 0...list.length
			prp "load:#{list[i]}"
			$loading_screen.update("Init script list") if $loading_screen
			load_script(list[i])
	end
    
  end
  
  #載入流程的主要觸發器
  def self.load_lona_scripts
		#return load_from_rvdata if COMPRESSED
		return load_from_driectory
  end
  
  def self.load_from_rvdata
	@list0=load_data("Data/list0.rvdata2")
	prp "file Data/list0.rvdata2 loaded "
	@list4=load_data("Data/list4.rvdata2")
	prp "file Data/list4.rvdata2 loaded "
	@list1=load_data("Data/list1.rvdata2")
	prp "file Data/list1.rvdata2 loaded "
	@list2=load_data("Data/list2.rvdata2")
	prp "file Data/list2.rvdata2 loaded "
	@list3=load_data("Data/list3.rvdata2")
	prp "file Data/list3.rvdata2 loaded "
	#@list5=load_data("Data/list5.rvdata2")
	#prp "file Data/list5.rvdata2 loaded "
	@list6=load_data("Data/list6.rvdata2")
	prp "file Data/list6.rvdata2 loaded "
	@listRV=load_data("Data/listRV.rvdata2")
	prp "file Data/listRV.rvdata2 loaded "
	@list7=getFileList("ModScripts/*.rb")
    prp "load from dir MODS"
	load_from_list(@list4)
	load_from_list(@list0)
	load_from_list(@list1)
	load_from_list(@list2)
	load_from_list(@list6)
	#load_from_list(@list5)
	load_from_list(@listRV)
	load_from_list(@list7)
  end
  
  def self.load_starter
    load_from_list(@list3)
    prp "load from dir list 3"
  end
  
  def self.clear_dot(list)
	list.each{
		|unit|
		unit=unit.gsub()
	}
  end
  
  def self.load_from_driectory
		@list0=getFileList("Data/Scripts/Frames/Game_InterpreterModifies/*")
		@list4=getFileList("Data/Scripts/Frames/Modules/**/*")
		@list1=getFileList("Data/Scripts/Frames/*.rb")
		@list2=getFileList("Data/Scripts/Frames/fqScripts/**/*")
		@list3=getFileList("Data/Scripts/Frames/Starter/*")
		#@list5=getFileList("Data/Scripts/Frames/Starter/**/MiscSetup.rb")
		@list6=getFileList("Data/Scripts/Editables/*.rb")
		@listRV=getFileList("Data/Scripts/Frames/RVscript/*")
		@list7=getFileList("ModScripts/*.rb")
		load_from_list(@list4)
		prp "load from dir list 4"
		load_from_list(@list0)
		prp "load from dir list 0"
		load_from_list(@list1)
		prp "load from dir list 1"
		load_from_list(@list2)
		prp "load from dir list 2"
		load_from_list(@list6)
		prp "load from dir list 6"
		#load_from_list(@list5)
		#p "load from dir list 5"
		load_from_list(@listRV)
		prp "load from dir list RV scripts"
		load_from_list(@list7)
		prp "load from dir MODS"
		return unless WRITING_LIST
		save_data(@list0,"Data/list0.rvdata2")
		prp "file Data/list0.rvdata2 saved "
		save_data(@list1,"Data/list1.rvdata2")
		prp "file Data/list1.rvdata2 saved "
		save_data(@list2,"Data/list2.rvdata2")
		prp "file Data/list2.rvdata2 saved "
		save_data(@list3,"Data/list3.rvdata2")
		prp "file Data/list3.rvdata2 saved "
		save_data(@list4,"Data/list4.rvdata2")
		prp "file Data/list4.rvdata2 saved "
		#save_data(@list5,"Data/list5.rvdata2")
		#p "file Data/list5.rvdata2 saved "
		save_data(@list6,"Data/list6.rvdata2")
		prp "file Data/list6.rvdata2 saved "
		save_data(@listRV,"Data/listRV.rvdata2")
		prp "file Data/listRV.rvdata2 saved "
  end
  
  
  def self.load_mood
		#return load_mood_from_rvdata if COMPRESSED
		return load_mood_from_directory
  end
  
  def self.load_mood_from_rvdata
		load_data("Data/moods.rvdata2")
  end
  
	def self.load_mood_from_directory
		prp "load_mood_from_directory"
		moodlist=getFileList("Data/Pconfig/Pconfig_lona/moods/*.json")
		moodlist += getFileList("Data/Pconfig/Pconfig_LayeredNPC/moods/*.json")
		mood=Hash.new
		moodlist.each{|fileDir|
			file=File.open(fileDir)
			jsonArr=JSON.decode(remove_json_comments(file.read))
			jsonArr.each{|moodSrc|
				mood[moodSrc["mood_name"]]=Array.new if(mood[moodSrc["mood_name"]].nil?)
				mood[moodSrc["mood_name"]].push(Moods::Mood.new(moodSrc))
				#p mood[moodSrc["mood_name"]]
				}
			#save_data(mood,"Data/moods.rvdata2") if WRITING_LIST
			}
		prp "load_mood_from_directory end"
		mood
	end

	def self.load_system_term_configs_from_dir
		prp "load_system_term_configs_from_dir"
		base_folder = "Data/Effects/_Sys_Term"
		data = JSON.decode(open("#{base_folder}/data.json").read)
		#save_data(mood,"data/system_term_configs.rvdata2") if WRITING_LIST
		prp "load_system_term_configs_from_dir end"
		data
	end
	#def self.load_system_term_configs_from_rvdata
	#	load_data("Data/system_term_configs.rvdata2")
	#end
	def self.load_system_term_configs
		#return load_system_term_configs_from_rvdata if COMPRESSED
		return load_system_term_configs_from_dir
	end

	def self.remove_json_comments(jsonString)
		return jsonString.gsub(/<.*>/,"")
	end


	def self.load_npc_portraits
		#return load_npc_portraits_rvdata if COMPRESSED
		return load_npc_portraits_dir 
	end
  
  
	def self.load_lona_portrait
		#return load_lona_portrait_parts_rvdata if COMPRESSED
		return load_lona_portrait_parts_dir
	end
	#def self.load_lona_portrait_parts_rvdata
	#	prp "loading lona portrait from rvdata"
	#	load_data("Data/lona_pcanvas.rvdata2").each{|name,blt|
	#		System_Settings::LONA_PORTRAIT_CANVAS_SETTING[name] = blt
	#	}
	#	load_data("Data/lona_pconfig.rvdata2")
	#end
  
	#def self.load_NPC_layered_portrait_parts_rvdata #unuse
	#	prp "loading NPC_layered_pconfig portrait from rvdata"
	#	load_data("Data/NPC_layered_pconfig.rvdata2")
	#end
  
	#def self.load_npc_portraits_rvdata
	#	prp "load_nPPc_portrait RVDATA"
	#	data=load_data("Data/npc_portraits.rvdata2")
	#	npc_portraits = Array.new
	#	data.each{
	#		|prt|
	#		npc_portraits << NPC_Portrait.fromHash(prt)
	#		#$game_portraits.addPortrait(NPC_Portrait.fromHash(prt))
	#	}
	#	npc_portraits
	#end
  
	def self.load_npc_portraits_dir(folder="Data/Pconfig/Pconfig_npc/")
		npc_portraits = Array.new
		prp "load_nPPc_portrait"
		fileList=getFileList("#{folder}*.json")
		npc_datas=[]
			fileList.each{|fileDir|
			file=File.open(fileDir)
			npc_data=JSON.decode(remove_json_comments(file.read))
			npc_datas.push(npc_data)
			npc_portraits << NPC_Portrait.fromHash(npc_data)
			#$game_portraits.addPortrait(NPC_Portrait.fromHash(npc_data))
		}
		save_data(npc_datas,"Data/npc_portraits.rvdata2") if WRITING_LIST
		npc_portraits
	end
  
	def self.load_lona_portrait_parts_dir
		dirlist=Dir.glob("Data/Pconfig/Pconfig_lona/poses/*")
		partsHash=Hash.new
		name_order=Hash.new
		for c in 0...dirlist.length
			fileList=getFileList(dirlist[c]+"/*.json")
			pose_name=dirlist[c].split("/").last.downcase
			prp "lona pose #{pose_name}"
			for d in 0...fileList.length
					prp "load portrait json: #{fileList[d]}"
					file=File.open(fileList[d])
					parts_config=handle_lona_parts_arr(JSON.decode(file.read()),name_order)		#[name_order,parts]
					partsHash[pose_name].nil? ? partsHash[pose_name]=parts_config[1] : partsHash[pose_name]+=parts_config[1]
					name_order=parts_config[0]
			end
		end
		
		fileList=getFileList("Data/Pconfig/Pconfig_LayeredNPC/poses/*.json")
		for d in 0...fileList.length
				pose_name = fileList[d][38..-6]  #裁到剩檔名本名
				prp "load portrait json: #{fileList[d]}"
				prp "NPC pose #{pose_name}"
				file=File.open(fileList[d])
				parts_config=handle_lona_parts_arr(JSON.decode(file.read()),name_order)		#[name_order,parts]
				partsHash[pose_name].nil? ? partsHash[pose_name]=parts_config[1] : partsHash[pose_name]+=parts_config[1]
				name_order=parts_config[0]
		end
		
		save_data(System_Settings::LONA_PORTRAIT_CANVAS_SETTING,"Data/lona_pcanvas.rvdata2") if FileGetter::WRITING_LIST
		save_data([name_order,partsHash],"Data/lona_pconfig.rvdata2") if FileGetter::WRITING_LIST
		prp "Data/lona_parts.rvdata2 written" if FileGetter::WRITING_LIST
		partsHash.each{
			|key,value|
		}
		return [name_order,partsHash]
	end
	
	

	#def self.load_NPC_layered_portrait_parts_dir #unuse
	#	partsHash=Hash.new
	#	name_order=Hash.new
	#	fileList=getFileList("Data/Pconfig/Pconfig_LayeredNPC/*.json")
	#	pose_name="npcCHCG"
	#	for d in 0...fileList.length
	#			prp "load portrait json: #{fileList[d]}"
	#			file=File.open(fileList[d])
	#			parts_config=handle_lona_parts_arr(JSON.decode(file.read()),name_order)		#[name_order,parts]
	#			partsHash[pose_name].nil? ? partsHash[pose_name]=parts_config[1] : partsHash[pose_name]+=parts_config[1]
	#			name_order=parts_config[0]
	#	end
	#
	#
	#	save_data([name_order,partsHash],"Data/NPC_layered_pconfig.rvdata2") if FileGetter::WRITING_LIST
	#	prp "Data/NPC_layered_pconfig.rvdata2 written" if FileGetter::WRITING_LIST
	#	partsHash.each{
	#		|key,value|
	#	}
	#	return [name_order,partsHash]
	#end
	def self.load_mod_lona_portrait_parts_dir(folder="Data/Pconfig/Pconfig_LayeredNPC/",pose_name="mod") #for mod
		prp "load_mod_lona_portrait_parts_dir #{pose_name}"
		fileList=getFileList("#{folder}*.json")
		partsHash=Hash.new
		name_order=Hash.new
		prp "NPC pose #{pose_name}"
		for d in 0...fileList.length
				prp "load portrait json: #{fileList[d]}"
				file=File.open(fileList[d])
				parts_config=handle_lona_parts_arr(JSON.decode(file.read()),name_order)		#[name_order,parts]
				partsHash[pose_name].nil? ? partsHash[pose_name]=parts_config[1] : partsHash[pose_name]+=parts_config[1]
				name_order=parts_config[0]
		end
		partsHash.each{
			|key,value|
		}
		return [name_order,partsHash]
	end
  
  
	def self.load_npc_charset_settings_from_dir(folder="Data/CHSConfig/CHSconfigs_NPC/")
		prp "load_npc_charset_settings_from_dir"
		chs_datas={}
		fileList=getFileList("#{folder}*.json")
		fileList.each{|fileDir|
			file=File.open(fileDir)
			chs_data=JSON.decode(remove_json_comments(file.read))
			chs_data=CHS::CHS_Data.create_from_hash(chs_data)
			chs_datas[chs_data.char_type]=chs_data
		}
		chs_datas
	end
	
	
	############mod loader way
	def self.load_lona_chs_settings_from_dir(folder="Data/CHSConfig/CHSconfigs_ActorLayer/",chsh=false)
		prp "load_lona_chs_settings_from_dir"
		chs_datas={}
		actorCount=$data_actors.length
		actorCHSConfigs=Array.new($data_actors.length)
		actor_chs_config = $data_actors[1].chs_configured
		#actorNote=Note.get_data($data_actors[1].note)
		#chs_config=remove_json_comments(File.open("Data/CHSConfig/CHSconfigs_ActorSetting/#{actorNote["chs_config"]}").read)
		chs_config=remove_json_comments(File.open("Data/CHSConfig/CHSconfigs_ActorSetting/#{actor_chs_config}").read)
		chs_config=JSON.decode(chs_config)
		chs_config["parts"]=[]
		fileList=getFileList("#{folder}*.json")
		chsPartSrc=[]
		fileList.each{|partfile|
			p "partfile=>#{partfile}"
			file= File.open(partfile)
			partSrcArr=JSON.decode(remove_json_comments(file.read))
			chs_config["parts"]+=partSrcArr
		}
		chs_data=CHS::Lona_CHS_Data.create_from_hash(chs_config)
		if chsh
			chs_datas[chs_data.char_type+"_H"]=chs_data
		else
			chs_datas[chs_data.char_type]=chs_data
		end
		chs_datas
	end

	def self.load_barter_settings_from_dir(folder="Data/Barters/*.json")
		prp "load_barter_settings_from_dir"
		fileList=getFileList(folder)
		barterExport = {}
		fileList.each{|fileDir|
			prp "Barters data from ->#{fileDir}"
			file=File.open(fileDir)
			tmpBarterData = JSON.decode(remove_json_comments(file.read))
			unless barterExport[tmpBarterData["name"]].nil?
				raise "duplicate Barter name on:#{tmpBarterData["name"]}"
			end
			barterExport[tmpBarterData["name"]] = tmpBarterData
		}
		barterExport
	end
	def self.load_common_events_from_dir(folder="Data/CommonEvents/*.json")
		prp "load_common_events_from_dir"
		fileList=getFileList(folder)
		common_events = []
		fileList.each{|fileDir|
			prp "common_events data from ->#{fileDir}"
			file=File.open(fileDir)
			tgt = JSON.decode(remove_json_comments(file.read))
			common_events << tgt
		}
		common_events
	end
	def self.load_chs_settings_from_dir
		prp "load_chs_settings_from_dir"
		####filegetter mod
		#load_npc_charset_settings_from_dir.merge(load_lona_chs_settings_from_dir).merge(load_lona_h_chs_settings_from_dir)
		
		####mod loader
		tmpLonaCHS = load_lona_chs_settings_from_dir(folder="Data/CHSConfig/CHSconfigs_ActorLayer/",chsh=false)
		tmpLonaCHSH = load_lona_chs_settings_from_dir(folder="Data/CHSConfig/CHSconfigs_ActorHLayer/",chsh=true)
		tmpNpcCHS = load_npc_charset_settings_from_dir(folder="Data/CHSConfig/CHSconfigs_NPC/")
		tmpNpcCHS.merge(tmpLonaCHS).merge(tmpLonaCHSH)
	end
	
	def self.load_NPCs_from_dir(folder="Data/NPCdata/")
			prp "load_NPCs_from_dir"
			fileList=getFileList("#{folder}*.json")
			npc_datas = {}
			fileList.each{|fileDir|
				prp "NonPlayerCharacter dir NPC ->#{fileDir}"
				file = File.open(fileDir)
				npcJSON = JSON.decode(remove_json_comments(file.read))
				npc=NonPlayerCharacter::Data_NPC.load_from_json(npcJSON)
				unless npc_datas[npc.name].nil?
					raise "duplicate NPC name on:#{npc.name}" 
				end
				npc_datas[npc.name] = npc
			}
			save_data(npc_datas,"Data/NonPlayerCharacters.rvdata2") if WRITING_LIST	
			npc_datas
	end
  
	def self.read_EventLib
		return load_data("Data/MonsterLib.rvdata2") if FileGetter::COMPRESSED
		mapinfo=load_data("Data/MapInfos.rvdata2")
		lib_map=/(-lib-)(.+)/
		library={}
		existing_ev={}
		mapinfo.keys.each{|mapkey|
			next if !lib_map.match(mapinfo[mapkey].name)
			librarymap=load_data(sprintf("Data/Map%03d.rvdata2", mapkey))
			librarymap.events.keys.each{
			|evkey|
			event_name=librarymap.events[evkey].name
			if(event_name.to_s.empty?)
				raise "no event name given on event id=#{librarymap.events[evkey].id}"
			end
			existing_ev.each{|evlName,evl|
				raise "dup ev=#{event_name} at (#{evl[0]},x=>#{evl[1]},y=>#{evl[2]})|(#{mapinfo[mapkey].name},x=>#{librarymap.events[evkey].x},y=>#{librarymap.events[evkey].y})" if evlName.eql?(event_name)
			}
			lib_ev=librarymap.events[evkey]
			existing_ev[event_name]=[mapinfo[mapkey].name,lib_ev.x,lib_ev.y]
			library[event_name]=[mapinfo[mapkey].name,librarymap.events[evkey]]
			}
		}
		save_data(library,"Data/MonsterLib.rvdata2") if WRITING_LIST
		library
	end

	def self.load_mod_EventLib(targetMAP)
		mapkey= -1 #LULZ?
		librarymap=load_data(sprintf(targetMAP, mapkey))
		tmpHash = {}
		librarymap.events.keys.each{|evkey|
			event_name=librarymap.events[evkey].name
			if(event_name.to_s.empty?)
				raise "no event name given on event id=#{librarymap.events[evkey].id}"
			end
			tmpHash[event_name]=[targetMAP,librarymap.events[evkey]]
			#$data_EventLib[event_name]=[targetMAP,librarymap.events[evkey]]
		}
		tmpHash
	end
  
	#[name_order,parts]
	def self.handle_lona_parts_arr(partsArr,name_order)
		parts=Array.new
		partsArr.each{|part|
			use_custom_root_folder = part["root_folder"]
			if part["CanvasSetting"]  #TRANS npc layer json 的canvas設定 TO System_Settings::LONA_PORTRAIT_CANVAS_SETTING
				tmpCanvasAry = []
				part["CanvasSetting"]["canvas"].each{|tar|
					tar = tar.to_i
					tmpCanvasAry << tar
				}
				System_Settings::LONA_PORTRAIT_CANVAS_SETTING[part["CanvasSetting"]["char_name"]] = tmpCanvasAry
				#msgbox "#{part["CanvasSetting"]["char_name"]  } #{System_Settings::LONA_PORTRAIT_CANVAS_SETTING[part["CanvasSetting"]["char_name"]]}"
				next
			end
			portrait_part=Lona_Part.new(part["bmps"],part["x"].to_i,part["y"].to_i,part["layer"],part["part_name"],part["part_name"],part["isDirt"])
			if part["isDirt"]
				part["dirtKey"].nil? ? portrait_part.dirtKey="dirt" : portrait_part.dirtKey=part["dirtKey"]
			end
			name_order[part["part_name"]]=part["name_order"]
			if use_custom_root_folder
				portrait_part.root_folder=use_custom_root_folder
			else
				portrait_part.root_folder="Graphics/Portrait/Lona"
			end
			parts.push(portrait_part)
		}
		return [name_order,parts]
	end
  
  
	def self.load_skill_data
		return load_skill_from_rvdata if COMPRESSED
		return load_skill_from_json(target="Data/Effects/Skill/")
	end
  
	def self.load_skill_from_rvdata
		prp "load_skill_from_rvdata"
		load_data("Data/ArpgSkills.rvdata2")
	end
  
	def self.load_skill_from_json(target="Data/Effects/Skill/")
		prp "load_skill_from_json"
		fileList=getFileList("#{target}*.json")
		skills={}
		fileList.each{|filepath|
			prp "loading skill_json : #{filepath}"
			file=File.open(filepath)		
			skillJSON=JSON.decode(remove_json_comments(file.read))
			raise "dup skill=>#{skillJSON["item_name"]} at #{filepath}" unless skills[skillJSON["item_name"]].nil? 
			skills[skillJSON["item_name"]]=SkillData.load_from_json(skillJSON)
		}
		save_data(skills,"Data/ArpgSkills.rvdata2") if WRITING_LIST
		prp "Data/ArpgSkills.rvdata2 written" if WRITING_LIST
		return skills
	end
	def self.load_alchemy_recipes_from_dir(folder_path = "Data/Effects/Alchemy/")
		prp "Loading recipes from folder: #{folder_path}"
		file_list = Dir.glob("#{folder_path}*.json")
		recipes = []

		file_list.each do |filepath|
			prp "Reading recipe file: #{filepath}"
			file = File.open(filepath)
			json = JSON.decode(file.read)
			file.close

			json["recipes"].each do |recipe|
				recipes << recipe
			end
		end

		prp "Total loaded recipes: #{recipes.size}"
		recipes
	end

#	#scanner to check nameorder == bmp
#	def self.scan_name_order_and_parts_json(folder_path = "Data/Pconfig/Pconfig_lona/poses/chcg4/")
#		prp "Scanning JSON parts from folder: #{folder_path}"
#		file_list = Dir.glob("#{folder_path}*.json")
#
#		mismatches = []
#
#		file_list.each do |filepath|
#			prp "Reading part file: #{filepath}"
#			file = File.open(filepath)
#			json = JSON.decode(file.read)
#			file.close
#
#			json.each do |part|
#				# Skip if not a part definition
#				next unless part["name_order"] && part["bmps"]
#
#				expected_order = part["name_order"]
#
#				part["bmps"].each do |bmp_key, _|
#					# Parse bmp key into name_order style array
#					translated_order = bmp_key.split(",").map do |token|
#						token = token.split("#")[0]    # remove after #
#						token.gsub(/\d+$/, "")         # strip trailing numbers
#					end
#
#					unless translated_order == expected_order
#						mismatches << {
#							part_name: part["part_name"],
#							bmp_key: bmp_key,
#							expected: expected_order,
#							got: translated_order
#						}
#					end
#				end
#			end
#		end
#
#		if mismatches.empty?
#			prp "All parts OK!"
#		else
#			prp "Found #{mismatches.size} mismatches:"
#			mismatches.each do |m|
#				prp "Part: #{m[:part_name]} | bmp_key: #{m[:bmp_key]} | expected: #{m[:expected]} | got: #{m[:got]}"
#			end
#		end
#
#		mismatches
#	end

	def self.debug_scan_name_order(folder_path = "Data/Pconfig/Pconfig_lona/poses/chcg4/")
		p "Scanning JSON parts from folder: #{folder_path}"
		file_list = Dir.glob("#{folder_path}*.json")

		mismatches = []

		file_list.each do |filepath|
			p "Reading part file: #{filepath}"
			file = File.open(filepath)
			json = JSON.decode(file.read)
			file.close

			json.each do |part|
				# Skip if not a part definition
				next unless part["name_order"] && part["bmps"]

				expected_order = part["name_order"]

				part["bmps"].each do |bmp_key, _|
					translated_order = bmp_key.split(",").map do |token|
						if token.include?("#")
							token.split("#")[0]  # keep before "#", keep numeric if any
						else
							token.gsub(/\d+$/, "") # strip trailing numbers if no "#"
						end
					end

					unless translated_order == expected_order
						mismatches << {
							part_name: part["part_name"],
							bmp_key: bmp_key,
							expected: expected_order,
							got: translated_order
						}
					end
				end
			end
		end

		if mismatches.empty?
			p "All parts OK!"
		else
			p "Found #{mismatches.size} mismatches:"
			mismatches.each do |m|
				p "Part: #{m[:part_name]} | bmp_key: #{m[:bmp_key]} | expected: #{m[:expected]} | got: #{m[:got]}"
			end
		end

		mismatches
	end
end

