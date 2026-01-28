

#Debug 工具，不應該有其他任何檔案相依於此處的方法，若有，則應考慮將該方法移出。
module GIM_ADDON
	#nobody uses it currently 
	
	def command_sheet(is_player)	
		command = []
		command << ["KillIT"			,:dbg_kill_npc]					if !is_player
		command << ["P_BasicData"		,:dbg_list_basic_data]			if !is_player
		command << ["P_NpcData"			,:dbg_print_all_npc_data]		if !is_player
		command << ["P_AllEvent"		,:dbg_print_all_event_data]		if !is_player
		#command << ["啟動事件除錯開關"	,:dbg_debug_this_one_on]		if !is_player
		#command << ["啟動NPC除錯開關"		,:dbg_debug_this_npc_on]		if !is_player
		#command << ["啟動所有除錯開關"	,:dbg_debug_npc_ev_on]			if !is_player
		command << ["MindControl"		,:dbg_set_MindControl]			if !is_player
		command << ["ForceToFollower"	,:dbg_set_follower]				if !is_player
		command << ["SetToChaos"		,:dbg_set_chaos]				if !is_player
		command << ["DeleteThis"		,:dbg_delete_ev]				if !is_player
		command << ["EvToGlobal"		,:dbg_ev_to_global]				if !is_player
		command << ["ShowSexGroup"		,:dbg_show_sex_group]			if !is_player
		command << ["LostTarget"		,:dbg_lost_target]				if !is_player
		command << ["Camera"			,:dbg_set_cam_here]				if !is_player
		command << ["PrintStats"		,:dbg_print_stats]				if is_player
		command << ["RegenMainStat"		,:dbg_regen_mainstat]			if is_player
		command << ["MaxTradePoint"		,:dbg_max_trade_point]			if is_player
		command << ["LV99"				,:dbg_set_lv_99]				if is_player
		command << ["RemoveAllEQ"		,:dbg_RemoveAllEQ]				if is_player
		command << ["SunGlass"			,:dbg_equip_sunglass]			if is_player
		command << ["Armory"			,:dbg_call_armory]				if is_player
		command << ["ToOverMap"			,:dbg_to_overmap]				if is_player
		command << ["Transfer"			,:dbg_Transfer]					if is_player
		command << ["PictureMode"		,:dbg_PictureMode]				if is_player
		command << ["ResetTrait"		,:dbg_ResetTrait]				if is_player
		#command << ["LightsOn"			,:dbg_LightsOn]					if is_player
		command << ["RebirthTest"		,:dbg_RebirthTest]				if is_player
		command << ["_debug_pose_chcg_tester.rb"			,:dbg_debug_pose_chcg_tester]				if is_player
		command << ["asd.rb"			,:dbg_LoadASD]					if is_player
		command
	end
	
	
	def event_debug_tools
		cam_center(0)
		get_character(0).move_type = 3
		ev=get_character(0)
		return unless ev.summon_data["released"] && ev == $game_player.crosshair
		cmd_sheet = command_sheet($game_player.pos?(ev.x,ev.y))
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		$game_message.add("\\optB[#{cmd_text}]") 
		wait_for_message
		$game_temp.choice== -1 ? ev.delete_crosshair : send(cmd_sheet[$game_temp.choice][1],ev)
		$game_temp.choice = -1
		ev.delete_crosshair
	end
	
	
	
	def dbg_print_all_npc_data(cursor)
		$game_map.npcs.each{|npc_ev|
			next unless npc_ev.pos?(cursor.x,cursor.y)
			p npc_ev.npc
			show_npc_info(npc_ev,extra_info=true,"press for next")
		}
	end
	
	def dbg_print_all_event_data(cursor)
		$game_map.events_xy(cursor.x,cursor.y).each{
			|ev|
			prp "########EV.id #{ev.id}#####EV.name #{ev.name}################"
			prp "#########EV.x #{ev.x}###EV.y  #{ev.y}#####"
			p ev
			p "###############################################"
			p "###############################################"
		}
	end
	
	def dbg_debug_this_one_on(cursor)
			$game_map.events_xy(cursor.x,cursor.y).each{
				|ev|
				ev.debug_this_one=true
			}
	end
	
	def dbg_debug_this_npc_on(cursor)
		$game_map.events_xy(cursor.x,cursor.y).each{
			|ev|
			next unless ev.npc?
			ev.npc.debug_this_npc=true
		}
	end
	
	def dbg_debug_npc_ev_on(cursor)
		$game_map.events_xy(cursor.x,cursor.y).each{
			|ev|
			ev.debug_this_one=true
			ev.npc.debug_this_npc=true if ev.npc?
		}
	end
	
	def dbg_kill_npc(cursor)
		$game_map.npcs.each{
			|npc_ev|
			next unless npc_ev.pos?(cursor.x,cursor.y)
			npc_ev.actor.battle_stat.set_stat("health",-100)
			npc_ev.actor.refresh
		}
	end
	
	def dbg_player_friend(cursor)
		$game_map.npcs.each{
			|npc_ev|
			next unless npc_ev.pos?(cursor.x,cursor.y)
			npc_ev.actor.set_fraction($game_player.actor.fraction)
			npc_ev.actor.fraction_mode =2
			npc_ev.actor.master = $game_player	
		}
	end
	
	def dbg_set_chaos(cursor)
		$game_map.npcs.each{
			|npc_ev|
			next unless npc_ev.pos?(cursor.x,cursor.y)
			npc_ev.actor.fraction_mode =3
			npc_ev.actor.set_fraction(rand(100)+10)
		}
	end
	def dbg_set_MindControl(cursor)
		$game_map.npcs.each{|npc_ev|
			next unless npc_ev.pos?(cursor.x,cursor.y)
				data =[
					on_off=true,
					canUseSkill=true,
					withModeCancel=true,
					withTimer=false,
					stunWhenCancel=false,
					aggroWhenCancel=false,
					onHitCancel=true
				]
				npc_ev.npc.player_control_mode(*data)
			break
		}
	end
	def dbg_set_follower(cursor)
		$game_map.npcs.each{|npc_ev|
			next unless npc_ev.pos?(cursor.x,cursor.y)
			npc_ev.set_this_event_companion_back_lite
		}
	end
	
	def dbg_print_stats(cursor)
		$game_player.actor.show_stat
	end
	
	def dbg_regen_mainstat(cursor)
		$game_player.actor.health = 1000 
		$game_player.actor.sta = 1000 
		$game_player.actor.sat = 1000
	end
	
	def dbg_max_trade_point(cursor)
		optain_gold(200000)
	end
	def dbg_debug_pose_chcg_tester(cursor)
		load_script("Data/HCGframes/_debug_pose_chcg_tester.rb")
	end
	def dbg_LoadASD(cursor)
		load_script("asd.rb")
	end
	
	def dbg_set_lv_99(cursor)
		optain_exp(5760000) if $game_player.actor.level !=99
	end
	
	def dbg_equip_sunglass(cursor)
		if $game_player.actor.equips[8].nil? || $game_player.actor.equips[8].id != 34
			 optain_item($data_armors[34],1) 
			 $game_player.actor.change_equip(8, $data_armors[34])
		 end
	end
	
	def dbg_call_armory(cursor)
		good=debug_item_roster
		build_manual_store(good)
	end
	
	def dbg_RemoveAllEQ(cursor)
		$game_player.actor.change_equip(0, nil)
		$game_player.actor.change_equip(1, nil)
		$game_player.actor.change_equip(2, nil)
		$game_player.actor.change_equip(3, nil)
		$game_player.actor.change_equip(4, nil)
		$game_player.actor.change_equip(5, nil)
		$game_player.actor.change_equip(6, nil)
		$game_player.actor.change_equip(7, nil)
	end
	
	def dbg_to_overmap(cursor)
		change_map_leave_tag_map
	end

	def dbg_list_basic_data(cursor)
		$game_map.events_xy(cursor.x,cursor.y).each{
		|ev|
			prp "(#{cursor.x},#{cursor.y}) id:#{ev.id}  name:#{ev.name} npc?:#{ev.npc?}"
		}
	end
	
	
	def dbg_set_cam_here(cursor)
		evs_on_pos=$game_map.events.select{|key,ev|ev.pos?(cursor.x,cursor.y) && ev!=cursor}.values
		ev_name_list= Array.new(evs_on_pos.length){|index|
			evs_on_pos[index].name
		}
		ev_name_list = ["this position"] + ev_name_list 
		$game_message.add("set camera to ? \\optB[#{ev_name_list.join(",")}]")
		wait_for_message
		return if $game_temp.choice == -1 
		return $game_map.reserve_summon_event("-lab-DebugCamera",cursor.x,cursor.y) if $game_temp.choice==0
		return cam_follow(evs_on_pos[$game_temp.choice-1].id,0)
	end
	
	def dbg_ev_to_global(cursor)
		evs_on_pos=$game_map.events.select{|key,ev|ev.pos?(cursor.x,cursor.y) && ev!=cursor}.values
		ev_name_list= Array.new(evs_on_pos.length){|index|
			evs_on_pos[index].name
			}
		$game_message.add("set which event to $dbg ? \\optD[#{ev_name_list.join(",")}]")
		wait_for_message
		$dbg=evs_on_pos[$game_temp.choice] if $game_temp.choice!=-1
	end
	
	def dbg_delete_ev(cursor)
		evs_on_pos=$game_map.events.select{
			|key,ev|
			next if ev==cursor
			ev.pos?(cursor.x,cursor.y) ||
			(ev.moving? && ev.x==cursor.x && (ev.real_y-cursor.y).abs<=1) ||
			(ev.moving? && ev.y==cursor.y && (ev.real_x-cursor.x).abs<=1)
			}.values
		return if evs_on_pos.length == 1
		ev_name_list=["delete all"]+Array.new(evs_on_pos.length){
			|index|
			next if evs_on_pos[index]==cursor
			evs_on_pos[index].name}
		$game_message.add("\\optB[#{ev_name_list.join(",")}]")
		wait_for_message
		evs_on_pos.each{|ev|ev.delete} if $game_temp.choice==0
		evs_on_pos[$game_temp.choice-1].delete if $game_temp.choice>0
	end
	
	
	def dbg_show_sex_group(cursor)
		npcs_on_pos=$game_map.npcs.select{|npc_ev| npc_ev.pos?(cursor.x,cursor.y)}
		return prp"no npc is having sex on this position " if npcs_on_pos.length==0
		ev_name_list=Array.new(npcs_on_pos.length){
			|index|
		npcs_on_pos[index].name}
		$game_message.add("\\optB[#{ev_name_list.join(",")}]")
		wait_for_message
		if $game_temp.choice>=0
			target_ev=npcs_on_pos[$game_temp.choice]
			target_ev.fuckers.each{|fker|fker.call_balloon(18)}
			target_ev.fappers.each{|fper|fper.call_balloon(19)}
		end
		
	end
	
	def dbg_lost_target(cursor)
		npcs_on_pos=$game_map.npcs.select{|npc_ev| npc_ev.pos?(cursor.x,cursor.y)}
		return msgbox "no events on position " if npcs_on_pos.length==0
		ev_name_list=Array.new(npcs_on_pos.length){
			|index|
		npcs_on_pos[index].name}
		$game_message.add("\\optB[unit only,include actor.target]")
		wait_for_message
		npcs_on_pos.each{
			|npc_ev|
			npc_ev.actor.target.actor.process_target_lost if $game_temp.choice==1 && npc_ev.actor.target && npc_ev.actor.target!=$game_player
			npc_ev.actor.process_target_lost
		}
	end
	
	def dbg_PictureMode(cursor)
		if $hudForceHide || $game_player.transparent
			$game_player.transparent = false
			$hudForceHide = false
			$balloonForceHide = false
		else
			$game_player.transparent = true
			$hudForceHide = true
			$balloonForceHide = true
		end
	end
	
	def dbg_ResetTrait(cursor)
		$data_states.each{|state|
			next if state.nil?
			next unless state.addData
			next unless state.type_tag == "trait"
			next unless $game_player.actor.state_stack(state.id) >= 1
			$game_player.actor.remove_state(state.id)
			$game_player.actor.trait_point += 1
		}
		
		$game_player.actor.actor_ForceUpdate
		[[64,"combat_trait"],
		[63,"scoutcraft_trait"],
		[62,"wisdom_trait"],
		[61,"survival_trait"],
		[60,"constitution_trait"]].each { |itr|
			points = $game_player.actor.attr_dimensions[itr[1]][0].round
			$game_player.actor.trait_point += points
			$game_player.actor.attr_dimensions[itr[1]][0] = 0
			$data_items[itr[0]].lona_effect.each{ |le|
					next if le.attr.include? "_trait"
					$game_player.actor.attr_dimensions[le.attr][le.attr_type] -= le.adjust * points if le.type == "+"
			} #very french sounding code
		}
		#	
		$game_player.actor.attr_dimensions["health"][3] = 200
		$game_player.actor.attr_dimensions["sta"][3] = 100
		$game_player.actor.attr_dimensions["sat"][3] = 100
		$game_player.actor.actor_ForceUpdate
		#call_msg("debug only. may cause bugs")
	end
	def dbg_RebirthTest(cursor)
		$game_player.actor.health = -100
		$story_stats["Rebirth_Lost_PlayerHumanBaby"] = 100
		$story_stats["Rebirth_Lost_PlayerMootBaby"] = 100
		$story_stats["Rebirth_Lost_PlayerDeeponeBaby"] = 100
		$story_stats["RecQuestEliseAbomBabySale"] = 100
		$story_stats["RecQuestEliseAbomBabySale"] = 100
	end
	def dbg_LightsOn(cursor)
			$game_map.shadows.set_opacity(0)
	end
	def dbg_Transfer(cursor)
		tmpTarList = []
		tmpTarList << "NoerRelay"
		tmpTarList << "DoomFortressR"
		tmpTarList << "NoerRelay"
		tmpTarList << "PirateBane"
		tmpTarList << "FishTownR"
		tmpTarList << "SouthFL"
		tmpTarList << "NorthFL_INN"
		tmpTarList << "FishTownL"
		cmd_sheet = tmpTarList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i]+",")
		end
		
		call_msg("\\optB[#{cmd_text}]")
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice]
		return if !tmpPicked
		$story_stats["OverMapForceTransStay"] = 1
		$story_stats["OverMapForceTrans"] = tmpPicked
		change_map_leave_tag_map
	end
	
	



end #module

