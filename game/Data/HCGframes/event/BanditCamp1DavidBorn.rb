if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

#David kenny首次對話
if $story_stats["RecQuestDavidBorn"] == 0
	$story_stats["RecQuestDavidBorn"] = 1
	call_msg("CompDavidBorn:DavidBorn/Unknow")
	call_msg("TagMapBanditCamp1:DavidBorn/Unknow")
	cam_center(0)
end
tmpMcX,tmpMcY,tmpMcID =  $game_map.get_storypoint("MapCont")
if get_character(0).summon_data[:QuestAccept]
	call_msg("TagMapBanditCamp1:DavidBorn/Day_dialog")
	return eventPlayEnd
elsif $game_date.night?
	case get_character(0).switch1_id

		################################### WHORE ######################################################
		when 0
			call_msg("TagMapBanditCamp1:DavidBorn/JOB_Start_Whore")
			if $game_temp.choice == 1
				get_character(tmpMcID).summon_data[:Whore] = true
				get_character($game_map.get_storypoint("Out1")[2]).call_balloon(28,-1)
				get_character($game_map.get_storypoint("Out2")[2]).call_balloon(28,-1)
				get_character($game_map.get_storypoint("Out3")[2]).call_balloon(28,-1)
				get_character(0).summon_data[:QuestAccept] = true
				portrait_hide
				call_msg("TagMapBanditCamp1:HevWhore/begin1")
				tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
				get_character(tmpWakeUpID).switch2_id[2] = 1
				$game_map.npcs.each do |event|
					next if event.summon_data == nil
					next if !event.summon_data[:customer] && !event.summon_data[:NapFucker]
					next if event.actor.action_state == :death
					event.summon_data[:NapFucker] = true
					event.summon_data[:SexTradeble] = true
					event.call_balloon(28,-1)
				end
				call_msg("TagMapBanditCamp1:HevWhore/begin2")
			end

		################################### GangRape ######################################################
		when 1
			call_msg("TagMapBanditCamp1:DavidBorn/JOB_Start_GangRape")
			cam_center(0)
			portrait_off
			if $game_temp.choice == 1
				get_character(tmpMcID).summon_data[:GangRape] = true
				get_character(0).summon_data[:QuestAccept] = true
				eventPlayEnd
				return load_script("Data/HCGframes/event/BanditCamp1_Hev_Gang.rb")
			end

		################################### Doggy ######################################################
		when 2
			call_msg("TagMapBanditCamp1:DavidBorn/JOB_Start_Doggy")
			cam_center(0)
			if $game_temp.choice == 1
				get_character(0).summon_data[:QuestAccept] = true
				eventPlayEnd
				return load_script("Data/HCGframes/event/BanditCamp1_Hev_Doggy.rb")
			end
	end #case
	get_character(0).call_balloon(28,-1) if !get_character(0).summon_data[:QuestAccept]
elsif $game_date.day?
	call_msg("TagMapBanditCamp1:DavidBorn/Day_dialog")
end


eventPlayEnd
