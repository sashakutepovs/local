#==============================================================================
# This script is created by Kslander
#==============================================================================
#這個模組主要用來處理物品的文字讀取，被引用到Game_BaseItem中。

module ItemConfigs
	#從指定的格式去取得資料
	#格式 KEY=VALUE (CRLF)
	AFFECT_INCREASE = "+"
	AFFECT_DECREASE = "-"
	AFFECT_MULTIPLY = "*"
	AFFECT_DIVISION = "/"

	EQUIP_TYPES = FileGetter.load_system_term_configs["equip_type"]
	EQUIP_TYPES = EQUIP_TYPES.transform_keys(&:to_i)



	def load_common_event_data(data)
		@list = []
		if data["name"]
			@name = data["name"].to_sym
		end
		if data["trigger"]
			case data["trigger"]
			when 0,"none"		; @trigger = 0
			when 1,"auto"		; @trigger = 1
			when 2,"parallel"	; @trigger = 2
			end
		end
		if data["switch_id"]
			@switch_id = data["switch_id"]
			if @switch_id.is_a?(String)
				@switch_id = @switch_id.to_sym
			else
				@switch_id = @switch_id.to_i
			end
		end
		if data["script"]
			newCommand = RPG::EventCommand.new(355,0,[data["script"]])
			@list << newCommand
			newCommand = RPG::EventCommand.new(0,0,[])
			@list << newCommand
		end
	end

	def set_item_name(tar)
		@item_name = tar
	end
	def load_additional_data(customFile=nil)
		load_notetags_aee
		@addData=Note.get_data(self.note)
		@configured=configured_item?(addData)
		@configured = true if customFile
		load_misc_settings(addData)
		@item_name=@name if !@item_name
		#load_custom_texts(get_category,addData["flag"]) unless addData["flag"].nil?
		load_custom_texts(get_category,addData["flag"]) if addData["flag"]
		if !customFile
			return unless @configured
			load_lona_effect_from_json(addData["eff_cfg"]) if !addData["eff_cfg"].nil?
		else
			addData["eff_cfg"] = customFile
			load_lona_effect_custom(customFile)
		end
	end

	def get_sell_price(importPrice=@price)
		case type_tag
			when "Money"
				temp_wisdom_fix = $game_player.actor.wisdom*0.001
				temp_final_price = (importPrice * [0.9+temp_wisdom_fix,0.95].min).round
				temp_final_price
			else
				temp_wisdom_fix = $game_player.actor.wisdom*0.005
				temp_final_price = (importPrice * [0.5+temp_wisdom_fix,0.95].min).round
				temp_final_price
		end
		temp_final_price
	end

	def load_misc_settings(addData)
		@type_tag = addData["tag"]
		@type = addData["type"]
	end

	def load_custom_texts(category,flag)
		return if category.nil? || flag.nil? || flag.eql?("")
		@description="#{category}:#{flag}/description"
		item_name="#{category}:#{flag}/item_name"
		#@description=$game_text["#{category}:#{flag}/description"].to_s
		#item_name=$game_text["#{category}:#{flag}/item_name"].to_s
		@name=item_name unless item_name.nil?
	end

	def load_lona_effect_from_json(filename)
		#if FileGetter::COMPRESSED
		#	effectData= $data_itemconfigs["#{base_folder}/#{filename}"]
		#	effectData={} if effectData.nil?
		#else
			effectData=JSON.decode(open("#{base_folder}/#{filename}").read)
			$data_itemconfigs["#{base_folder}/#{filename}"]=effectData
		#end
		@item_data = {} if !@item_data
		@item_data = @item_data.merge(effectData)
		load_lona_effect_from_hash(@item_data)
	end
	def load_lona_effect_custom(filename)
		effectData=JSON.decode(open(filename).read)
		@item_data = {} if !@item_data
		@item_data = @item_data.merge(effectData)
		load_lona_effect_from_hash(@item_data)
	end
	def load_lona_effect_from_hash(data)
		p "load_lona_effect_from_hash - name=#{data["item_name"]} id=#{@id} self.class=#{self.class}---0"
		@lona_effect = Array.new if data["attribute_change"]
		@use_item_effect = Array.new if  data["use_item_effect"]
		register_item_name(data["item_name"])										if data["item_name"]
		@price=data["price"]														if data["price"]
		@lonaStat_json_hash = data["lonaStat_json_hash"] 							if data["lonaStat_json_hash"] #check 2MhBareHand.json
		if data["tag_main_settings"]
			@type_tag=data["tag_main_settings"]["tag"] 								if !data["tag_main_settings"]["tag"].nil?
			@type=data["tag_main_settings"]["type"] 								if !data["tag_main_settings"]["type"].nil?
			@key_item=data["tag_main_settings"]["key_item"] 						if !data["tag_main_settings"]["key_item"].nil?
			@consumable=data["tag_main_settings"]["consumable"] 					if !data["tag_main_settings"]["consumable"].nil?
		end
		if data["ext_slot_skill"]
			@item_ext_SkillName = data["ext_slot_skill"]["SkillName"]
			@item_ext_CostAfterLaunch = data["ext_slot_skill"]["CostAfterLaunch"]
			@item_ext_DirectUsage = data["ext_slot_skill"]["DirectUsage"]
		end
		@common_tags = data["common_tags"] 											if data["common_tags"]
		@player_item_usage_event_summon=data["player_item_usage_event_summon"]		if data["player_item_usage_event_summon"]
		@player_item_usage_eval=data["player_item_usage_eval"]			if data["player_item_usage_eval"]
		@dmg_multiplier=data["dmg_multiplier"].to_f 								if data["dmg_multiplier"]
		@weight=data["weight"].to_f 												if data["weight"]
		@player_nap_state_control = data["player_nap_state_control"]				if data["player_nap_state_control"]
		@player_add_state_SndLib = data["player_add_state_SndLib"]					if data["player_add_state_SndLib"]
		@player_nap_get_state_when = data["player_nap_get_state_when"]				if data["player_nap_get_state_when"]
		@menu_hide_lvl = data["menu_hide_lvl"]										if data["menu_hide_lvl"] #hide item IN HEALTH MENU when lvl.  array


		@icon_index = data["icon_index"]											if data["icon_index"]
		@is_combat_state = data["is_combat_state"]									if data["is_combat_state"]
		@is_daily_state = data["is_daily_state"]									if data["is_daily_state"]
		@pot_data = data["pot_data"]												if data["pot_data"]
		@raw_date = data["raw_date"]												if data["raw_date"]
		@rot_progress = data["rot_progress"]										if data["rot_progress"]
		@equip_part_covered = data["equip_part_covered"]							if data["equip_part_covered"]
		@player_item_usage_manage_state = data["player_item_usage_manage_state"]	if data["player_item_usage_manage_state"]
		@player_item_remove_equip = data["player_item_remove_equip"]				if data["player_item_remove_equip"]
		@max_stacks = data["max_stacks"]											if data["max_stacks"]
		@spread_when_sex = data["spread_when_sex"]									if data["spread_when_sex"]
		@part_key_blacklist = data["part_key_blacklist"]							if data["part_key_blacklist"]
		@banned_receiver_holes = data["banned_receiver_holes"]						if data["banned_receiver_holes"]
		@hud_trace_icon = data["hud_trace_icon"]									if data["hud_trace_icon"]
		@chs_configured = data["chs_config"]										if data["chs_config"] #player.actor only(lona) outdated. probably dont needed
		if data["textFlag"]
			#textFlag = TextLightMode.new("#{data["textFlag"]["folder"]}/#{$lang}")
			@name = data["textFlag"]["name"]
			@description = data["textFlag"]["description"]
			#textFlag = TextLightMode.new("#{data["textFlag"]["folder"]}/#{$lang}")
			#@name = textFlag[data["textFlag"]["name"]]
			#@description = textFlag[data["textFlag"]["description"]]
		end

		if data["etype_id"]
			search_key = nil
			EQUIP_TYPES.each { |key, value|
				search_key = key if value[0] == data["etype_id"]
			}
			@etype_id = search_key if search_key
		end
		if data["remove_by_walking"]
			@remove_by_walking = true
			@steps_to_remove = data["remove_by_walking"].to_i
		end
		if data["skill_sealed"]
			data["skill_sealed"].each_index {|i,name=data["skill_sealed"][i]|
				tgt = $data_SkillName[name]
				msgbox "skill_sealed => #{name} not found" if !tgt
				@skill_sealed[i] = tgt.id
			}
		end
		if data["added_skills"]
			data["added_skills"].each_index {|i,name=data["added_skills"][i]|
				tgt = $data_SkillName[name]
				msgbox "added_skills => #{name} not found" if !tgt
				@added_skills[i] = tgt.id if tgt
			}
		end

		if data["atype_id"]
			mapping_hash = Hash[$data_system.armor_types.map.with_index { |value, index| [value, index] }]
			tgt = mapping_hash[data["atype_id"]]
			msgbox "atype_id => #{ data["atype_id"]} not found" if !tgt
			@atype_id = mapping_hash[data["atype_id"]] if tgt
		end
		if data["wtype_id"]
			mapping_hash = Hash[$data_system.weapon_types.map.with_index { |value, index| [value, index] }]
			tgt = mapping_hash[data["wtype_id"]]
			msgbox "wtype_id => #{ data["wtype_id"]} not found" if !tgt
			@wtype_id = mapping_hash[data["wtype_id"]] if tgt
		end

		if data["stype_id"]
			mapping_hash = Hash[$data_system.skill_types.map.with_index { |value, index| [value, index] }]
			tgt = mapping_hash[data["stype_id"]]
			msgbox "stype_id => #{ data["stype_id"]} not found" if !tgt
			@stype_id = mapping_hash[data["stype_id"]] if tgt
		end

		if data["atype_ok"]
			exportARY = []
			mapping_hash = Hash[$data_system.armor_types.map.with_index { |value, index| [value, index] }]
			exportARY = data["atype_ok"].map { |item| mapping_hash[item] }
			@atype_ok = exportARY.uniq
		end
		if data["wtype_ok"]
			exportARY = []
			mapping_hash = Hash[$data_system.weapon_types.map.with_index { |value, index| [value, index] }]
			exportARY = data["wtype_ok"].map { |item| mapping_hash[item] }
			@wtype_ok = exportARY.uniq
		end
		if data["atype_seal"]
			exportARY = []
			mapping_hash = Hash[$data_system.armor_types.map.with_index { |value, index| [value, index] }]
			exportARY = data["atype_seal"].map { |item| mapping_hash[item] }
			@atype_seal = exportARY.uniq
		end
		if data["wtype_seal"]
			exportARY = []
			mapping_hash = Hash[$data_system.weapon_types.map.with_index { |value, index| [value, index] }]
			exportARY = data["wtype_seal"].map { |item| mapping_hash[item] }
			@wtype_seal = exportARY.uniq
		end
		if data["sealed_equip_type"]
			exportARY = []
			data["sealed_equip_type"].each{|tgtSlot|
				EQUIP_TYPES.each{|slotID,slotInfo|
					next unless tgtSlot == slotInfo[0]
					exportARY << slotID
					break
				}
			}
			@sealed_equip_type = exportARY.uniq
		end
		if data["fixed_equip_type"]
			exportARY = []
			data["fixed_equip_type"].each{|tgtSlot|
				EQUIP_TYPES.each{|slotID,slotInfo|
					next unless tgtSlot == slotInfo[0]
					exportARY << slotID
					break
				}
			}
			@fixed_equip_type = exportARY.uniq
		end
		if data["fixed_hard_equip_type"]
			exportARY = []
			data["fixed_hard_equip_type"].each{|tgtSlot|
				EQUIP_TYPES.each{|slotID,slotInfo|
					next unless tgtSlot == slotInfo[0]
					exportARY << slotID
					break
				}
			}
			@fixed_hard_equip_type = exportARY.uniq
			@fixed_equip_type = exportARY.uniq
		end
		if data["attribute_change"]
			data["attribute_change"].each{|effectUnit|
				next if acceptable_types.index(effectUnit["attribute_type"]).nil?
				attr_type=ActorStat::CURRENT_STAT
				case effectUnit["attribute_type"]
					when "BTmin";		attr_type=ActorStat::BUFF_TMIN
					when "BTmax";		attr_type=ActorStat::BUFF_TMAX
					when "max";		attr_type=ActorStat::MAX_STAT
					when "Tmax";    attr_type=ActorStat::MAX_TRUE
					when "Tmin";    attr_type=ActorStat::MIN_TRUE
					when "min";     attr_type=ActorStat::MIN_STAT
					when "current"; attr_type=ActorStat::CURRENT_STAT
				end
				@lona_effect.push(ItemEffect.new(
					effectUnit["attribute_name"],
					attr_type,
					effectUnit["adjustor"],
					effectUnit["adjustment"].to_f,
					effectUnit["stats_key"],
					effectUnit["stats_value"],
					effectUnit["stats_filter"],
					effectUnit["block_by_part_cover"]
				))
			}
		end
		if data["use_item_effect"]
			data["use_item_effect"].each{|effectUnit|
				next if acceptable_types.index(effectUnit["attribute_type"]).nil?
				attr_type=ActorStat::CURRENT_STAT
				case effectUnit["attribute_type"]
					when "max";		attr_type=ActorStat::MAX_STAT
					when "Tmax";    attr_type=ActorStat::MAX_TRUE
					when "Tmin";    attr_type=ActorStat::MIN_TRUE
					when "min";     attr_type=ActorStat::MIN_STAT
					when "current"; attr_type=ActorStat::CURRENT_STAT
				end
				@use_item_effect.push(ItemEffect.new(
					effectUnit["attribute_name"],
					attr_type,
					effectUnit["adjustor"],
					effectUnit["adjustment"].to_f,
					effectUnit["stats_key"],
					effectUnit["stats_value"],
					effectUnit["stats_filter"],
					effectUnit["block_by_part_cover"]
				))
			}
		end
	end
	def get_type_and_id
		return [0,self.id] if self.is_a?(RPG::Item)
		return [1,self.id] if self.is_a?(RPG::Weapon)
		return [2,self.id] if self.is_a?(RPG::Armor)
	end
	def configured_item?(addData)
		return false if addData.nil? || addData=={}
		return true if !addData["eff_cfg"].nil?
		return false if addData["flag"].nil? || (addData["tag"].nil? && addData["type"].nil? )
		return true
	end

	def register_item_name(tarName)
		$data_ItemName[tarName]=self if self.is_a?(RPG::Item)
		$data_ItemName[tarName]=self if self.is_a?(RPG::Weapon)
		$data_ItemName[tarName]=self if self.is_a?(RPG::Armor)
		$data_StateName[tarName]=self if self.is_a?(RPG::State)
		$data_SkillName[tarName]=self if self.is_a?(RPG::Skill)
		@item_name=tarName
	end
	#=================================================================================================
	#外部連接器
	#=================================================================================================

	#def lona_effect
	#	addData=Note.get_data(self.note)
	#	@configured=configured_item?(addData) if @configured.nil?
	#	return [] if !@configured
	#	load_additional_data if @lona_effect.nil?
	#	@lona_effect
	#end
	def lona_effect
		addData = Note.get_data(self.note)
		@configured = configured_item?(addData) if @configured.nil?
		return [] if !@configured
		load_additional_data if @lona_effect.nil? #now if no attr_change after this in some cases lona_effect still can be nil.
		@lona_effect = [] if @lona_effect.nil?
		@lona_effect
	end
	#=================================================================================================
	#內部複寫用
	#=================================================================================================
	#取得文字檔所在的資料夾
	def get_text_folder
		raise "方法 ItemConfigs::get_text_folder 未被覆寫，無法運作。"
	end

	#取得文字檔的類型(檔名)
	def get_category
		raise "方法 ItemConfigs::get_category 未被覆寫，無法運作。"
	end

	#取得這個物件的base_folder
	def base_folder
		raise "方法 ItemConfigs::base_folder 未被覆寫，無法運作。"
	end


	#這種物件接受變更哪些類型的屬性
	def acceptable_types
		["max","min","Tmax","Tmin","current","BTmax","BTmin"]
	end

	def not_acceptable_type_msg(result,type)
		if result.nil?
			return "#{get_category} ： #{@name} unknown ATTRIBUTE TYPE : #{type}"
		else
			return "#{get_category} ： #{@name} CAN NOT CHANGE ATTRIBUTE  TYPE: #{type}"
		end
	end


	class ItemEffect
		attr_reader :attr
		attr_reader :attr_type
		attr_reader :type
		attr_reader :adjust
		attr_reader :stats_key
		attr_reader :stats_value
		attr_reader :stats_filter
		attr_reader :block_by_part_cover
		def initialize(attr,attr_type,type,adjust,stats_key,stats_value,stats_filter,block_by_part_cover)
			@attr					=	attr
			@attr_type				=	attr_type
			@type					=	type
			@adjust					=	adjust
			@stats_key				=	stats_key
			@stats_value			=	stats_value
			@stats_filter			=	stats_filter
			@block_by_part_cover	=	block_by_part_cover
		end
	end

	class SkillEffect < ItemEffect
	end

end
