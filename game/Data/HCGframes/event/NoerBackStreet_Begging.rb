
1+rand(3).times{$game_player.actor.add_state("DoormatUp20")}
get_character(0).summon_data[:SexTradeble] = false
$game_player.animation = $game_player.animation_prayer
call_msg("commonNPC:Begging/check")
$game_player.actor.sta -= 3
temp_tar = 200+rand(400) ##############   Begging Diff
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
		"BlowJob"]
	evList << "DrinkPee" if $story_stats["Setup_UrineEffect"] >= 1
	evList = evList.sample
	case evList
		when "BellyPunch"
			to_Result = true
			call_msg("commonNPC:BeggingBandit/Beaten")
			get_character(0).animation = get_character(0).animation_atk_mh
			get_character(0).call_balloon([15,7,5].sample)
			$game_player.actor.stat["EventVagRace"] = "Human"
			load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
			$game_player.actor.force_stun("Stun1")
			wait(60)
			whole_event_end
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
			call_msg("commonNPC:Begging/Win")
			call_msg("commonNPC:Begging/Win_End")
			to_Result = true
	end
end

if to_Result #### WIN
	$game_player.actor.mood += 10
	temp_food_list= [
		"ItemApple","ItemFish",
		"ItemBread","ItemCarrot",
		"ItemBread","AnimalRattus",
		"ItemMushroom","ItemTomato",
		"ItemSausage","ItemCherry",
		"ItemGrapes","ItemMilk",
		"ItemOrange","ItemPotato",
		"ItemNuts","ItemSmokedMeat",
		"ItemOnion","ItemDryFood",
		"ItemPepper","ItemSopGood",
		"ItemBlueBerry"
		]
	optain_item($data_ItemName[temp_food_list.sample],1)
	get_character(0).animation = get_character(0).animation_atk_sh
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
