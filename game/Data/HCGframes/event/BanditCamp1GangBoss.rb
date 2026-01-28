if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


if $game_date.night?

	case get_character(0).switch1_id

		################################### WHORE ######################################################
		when 0
			call_msg("TagMapBanditCamp1:GangBoss/JOB_Start_Whore")
			if $game_temp.choice == 1
				portrait_hide
				call_msg("TagMapBanditCamp1:HevWhore/begin1")
				tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
				get_character(tmpWakeUpID).switch2_id[2] = 1
				$game_map.npcs.each do |event|
					next if event.summon_data == nil
					next if !event.summon_data[:customer] && !event.summon_data[:NapFucker]
					next if event.actor.action_state == :death
					event.call_balloon(28,-1)
				end
				call_msg("TagMapBanditCamp1:HevWhore/begin2")
			end

		################################### GangRape ######################################################
		when 1
			call_msg("TagMapBanditCamp1:GangBoss/JOB_Start_GangRape")
			portrait_off
			return load_script("Data/HCGframes/event/BanditCamp1_Hev_Gang.rb") if $game_temp.choice == 1

		################################### Doggy ######################################################
		when 2
			call_msg("TagMapBanditCamp1:GangBoss/JOB_Start_Doggy")
			portrait_off
			return load_script("Data/HCGframes/event/BanditCamp1_Hev_Doggy.rb") if $game_temp.choice == 1

	end #case
elsif $game_date.day?
	call_msg("TagMapBanditCamp1:GangBoss/Day_dialog")
end


portrait_hide
$story_stats["HiddenOPT1"] = "0" 
$game_temp.choice = -1
