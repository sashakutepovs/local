
1+rand(3).times{$game_player.actor.add_state("DoormatUp20")}
get_character(0).summon_data[:SexTradeble] = false
$game_player.animation = $game_player.animation_prayer
call_msg("commonNPC:Begging/check")
$game_player.actor.sta -= 3
temp_tar = 200+rand(100) ##############   Begging Diff
tmpWeak = $game_player.actor.weak + $game_player.actor.wisdom*rand(10)
call_msg("\\narr #{tmpWeak.round} VS #{temp_tar.round}")
checkPassed = tmpWeak >=  temp_tar
to_Result = false
if checkPassed
	evList = [
		"Nothing",
		"Nothing",
		"Nothing",
		"DeepThroat",
		"BlowJob",
		"BlowJob"
		]
	evList << "DrinkPee" if $story_stats["Setup_UrineEffect"] >= 1
	evList = evList.sample
	call_msg("TagMapNoerBackStreet:CommonGangMember/begging_success") if evList != "Nothing"
	portrait_hide
	wait(20)
	portrait_off
	case evList
		when "BlowJob"
			call_msg("commonNPC:BeggingBandit/BlowJob")
			$game_player.actor.stat["EventMouthRace"] = "Human"
			load_script("Data/HCGframes/UniqueEvent_SuckDick.rb")
			if $game_temp.choice == "Success"
				to_Result = true
				whole_event_end
			end
		when "DeepThroat"
			call_msg("commonNPC:BeggingBandit/Kneel")
			call_msg("common:Lona/Decide_optB")
			if $game_temp.choice == 1
				to_Result = true
				call_msg("commonNPC:BeggingBandit/DeepThroat")
				$game_player.actor.stat["EventMouthRace"] = "Human"
				load_script("Data/HCGframes/UniqueEvent_DeepThroat.rb")
				whole_event_end
			end
		when "DrinkPee"
			call_msg("commonNPC:BeggingBandit/Kneel")
			call_msg("common:Lona/Decide_optB")
			if $game_temp.choice == 1
				to_Result = true
				call_msg("commonNPC:BeggingBandit/DrinkPee")
				$game_player.actor.stat["EventMouthRace"] = "Human"
				load_script("Data/HCGframes/UniqueEvent_PeeonHeadNoOPT.rb")
				whole_event_end
			end
		else
			call_msg("TagMapNoerBackStreet:CommonGangMember/begging_success_nothing")
			call_msg("commonNPC:Begging/Win_End")
			to_Result = true
	end
end

if to_Result #### WIN
	call_msg("TagMapNoerBackStreet:CommonGangMember/begging_success_offerItem")
	$game_player.actor.mood += 10
	get_character(0).animation = get_character(0).animation_atk_sh
	$game_map.popup(0,"1",$data_items[24].icon_index,-1)
	$game_player.actor.itemUseBatch("ItemHiPotionLV2")
	SndLib.sound_drink(100)
	wait(60)
	#end
else #failed
	$game_player.actor.mood -= 10
		call_msg("commonNPC:Begging/Aggro0")
		get_character(0).animation = get_character(0).animation_atk_mh
		get_character(0).call_balloon([15,7,5].sample)
		$game_player.actor.stat["EventVagRace"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		$game_player.actor.force_stun("Stun1")
		wait(60)
		return eventPlayEnd
	#end
end
$game_player.animation = nil
