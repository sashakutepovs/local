

get_character(0).set_summon_data({}) if !get_character(0).summon_data
get_character(0).summon_data[:staCosted] = 0 if !get_character(0).summon_data[:staCosted]
get_character(0).summon_data[:staNeed] = 200 if !get_character(0).summon_data[:staNeed]
if get_character(0).summon_data[:staCosted] >= get_character(0).summon_data[:staNeed]
	change_map_tag_map_exit
else
	if get_character(0).summon_data[:staCosted] ==0
		call_msg("TagMapNoerPrison:Toilet/frist_time")
	end
	
	$story_stats["HiddenOPT1"] = "0"
	$story_stats["HiddenOPT1"] = "1" if $game_player.actor.sta > 0
	call_msg("TagMapNoerPrison:Toilet/MainOpt")
	
	
	if $game_temp.choice == 1
		$game_player.actor.sta >= 20		? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		$game_player.actor.sta >= 40		? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		$game_player.actor.sta >= 80		? $story_stats["HiddenOPT3"] = "1" : $story_stats["HiddenOPT3"] = "0"
		$game_player.actor.sta >= 160		? $story_stats["HiddenOPT4"] = "1" : $story_stats["HiddenOPT4"] = "0"
		$game_player.actor.sta >= 240		? $story_stats["HiddenOPT5"] = "1" : $story_stats["HiddenOPT5"] = "0"
		call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Windcave_Opt_dig")
		case $game_temp.choice
			when 1 ;temp_cost = 10
			when 2 ;temp_cost = 40
			when 3 ;temp_cost = 60
			when 4 ;temp_cost = 80
			when 5 ;temp_cost = 160
			when 6 ;temp_cost = 240
		end
	if $game_temp.choice >= 1
		$cg.erase
		portrait_off
		chcg_background_color(0,0,0,1,7)
			portrait_hide
			
			tmpCanCollectWaste = ($game_player.actor.survival_trait + $game_player.actor.scoutcraft_trait >= 10) || $game_player.actor.stat["Mod_Taste"] == 1 || $game_player.actor.stat["Omnivore"] == 1
			tmpCanDigPoo = tmpCanCollectWaste && $story_stats["Setup_ScatEffect"] !=0
			tmpCanDigPee = tmpCanCollectWaste && $story_stats["Setup_UrineEffect"] !=0
			EvLib.sum("WastePee",$game_player.x,$game_player.y)
			EvLib.sum("WastePoo1",$game_player.x,$game_player.y)
			wait(35)
			SndLib.sys_MeatGain(80+rand(10),50+rand(40))
			wait(35)
			SndLib.sys_MeatGain(80+rand(10),50+rand(40))
			wait(35)
			SndLib.sys_MeatGain(80+rand(10),50+rand(40))
			wait(35)
			SndLib.sys_MeatGain(80+rand(10),50+rand(40))
			get_character(0).summon_data[:staCosted] += temp_cost
			$game_player.actor.sta -= 1+temp_cost
			$game_player.actor.dirt = 255
			
			tmpEVid = nil
			tmpEVoX = nil
			tmpEVoY = nil
			tmp_on_sight = false
			$game_map.npcs.each do |event| 
				next if event.npc.fraction !=7
				next if event.actor.action_state != nil && event.actor.action_state !=:none
				next if !event.near_the_target?($game_player,5)
				next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
				tmpEVid = event.id
				tmpEVoX = event.x
				tmpEVoY = event.y
				tmp_on_sight = true
			end
			get_character(tmpEVid).moveto($game_player.x,$game_player.y+1) if tmpEVid != nil && tmp_on_sight == true
		
		chcg_background_color(0,0,0,255,-7)
			if get_character(0).summon_data[:staCosted] >= 200
				call_msg("TagMapNoerPrison:Toilet/Opt_diged_open")
			else
				call_msg("TagMapHumanPrisonCave:HumanPrisonCave/Windcave_Opt_diged")
			end
	end
		
	#被發現了
	if tmpEVid != nil && tmp_on_sight == true
		$story_stats["RapeLoopTorture"] = 1
		get_character(tmpEVid).direction = 8
		get_character(tmpEVid).call_balloon(8)
		wait(120)
		chcg_background_color(0,0,0,0,7)
			get_character(tmpEVid).moveto(tmpEVoX,tmpEVoY)
		chcg_background_color(0,0,0,255,-7)
	end
	optain_item("WastePoo0",1) if tmpCanDigPoo #40
	wait(30) if tmpCanDigPee
	optain_item("ItemBottledPee",1) if tmpCanDigPee #58
end
end
	
	
	
	$story_stats["HiddenOPT1"] = "0" 
	$story_stats["HiddenOPT2"] = "0" 
	$story_stats["HiddenOPT3"] = "0" 
	$story_stats["HiddenOPT4"] = "0" 
	$story_stats["HiddenOPT5"] = "0" 
	$game_temp.choice = -1
	
	