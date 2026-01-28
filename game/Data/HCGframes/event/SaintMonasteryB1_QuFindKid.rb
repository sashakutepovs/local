if $story_stats["RecQuestSMRefugeeCampFindChild"].between?(1,6) || $story_stats["RecQuestSMRefugeeCampFindChild"] == 8
	call_msg("TagMapSaintMonasteryB1:MIAchildMAMA/prog8") if $story_stats["RecQuestSMRefugeeCampFindChild"] != 8
	set_comp = false

	if $game_player.record_companion_name_ext != nil
		call_msg("commonComp:notice/ExtOverWrite")
		call_msg("common:Lona/Decide_optD")
		return eventPlayEnd if $game_temp.choice == 1
	end
	
	$game_temp.choice = -1
	$story_stats["RecQuestSMRefugeeCampFindChild"] = 8
	$story_stats["HiddenOPT1"] = "1" if $game_player.actor.wisdom_trait >= 10
	$story_stats["HiddenOPT2"] = "1" if $game_player.actor.sta >= 1
	call_msg("TagMapSaintMonasteryB1:MIAchildMAMA/prog8_opt") # [算了,欺騙<r=HiddenOPT1>,強行<r=HiddenOPT2>]
	case $game_temp.choice
		when 1 #欺騙
			call_msg("TagMapSaintMonasteryB1:MIAchildMAMA/prog8_opt_WIS")
			set_comp = true
			
		
		when 2 #強行
			$game_player.actor.sta -= 10
			$game_player.animation = $game_player.animation_atk_sh
			wait(8)
			SndLib.sound_punch_hit(100)
			get_character(0).npc_story_mode(true)
			get_character(0).move_type = 0
			get_character(0).animation = get_character(0).animation_stun
			call_msg("TagMapSaintMonasteryB1:MIAchildMAMA/prog8_opt_STA0")
			optain_morality(-1)
			get_character(0).animation = nil
			call_msg("TagMapSaintMonasteryB1:MIAchildMAMA/prog8_opt_STA1")
			set_comp = true
	end
	
	if set_comp
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$story_stats["RecQuestConvoyTarget"] = [] #Inside Noer
			tmpX = get_character(0).x
			tmpY = get_character(0).y
			get_character(0).set_this_event_companion_ext("MonasteryFindChild_Qobj",false,4+$game_date.dateAmt)
			EvLib.sum("MonasteryFindChild_Qobj",tmpX,tmpY)
			get_character(0).set_this_event_follower_remove
			get_character(0).delete
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapSaintMonasteryB1:MIAchildMAMA/prog9_board")
	else
		get_character(0).call_balloon(28,-1)
	end
	
	$story_stats["HiddenOPT1"] = "0"
	$story_stats["HiddenOPT2"] = "0"
	eventPlayEnd
end