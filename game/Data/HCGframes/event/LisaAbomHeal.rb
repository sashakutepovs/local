#return init_jump_page(2) if $story_stats["UniqueCharUniqueLisa"] == -1
#return init_jump_page(2) if $game_player.record_companion_name_ext=="CompExtUniqueLisa"
#return init_jump_page(2) if $story_stats["RecQuestLisa"] != 3
p $story_stats["UniqueCharUniqueLisa"]
p $game_player.record_companion_name_ext
p $story_stats["RecQuestLisa"]
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpX,tmpY,tmpID=$game_map.get_storypoint("QuestCountC130Mining")
tmpLisaX,tmpLisaY,tmpLisaID=$game_map.get_storypoint("UniqueLisa")
if $game_party.has_item?($data_items[31]) || $game_party.item_number($data_items[30]) >=5

	set_comp=false
	if $game_player.record_companion_name_ext == nil
	set_comp=true
	elsif $game_player.record_companion_name_ext != nil
		$game_temp.choice = -1
		call_msg("commonComp:notice/ExtOverWrite")
		call_msg("common:Lona/Decide_optD")
		if $game_temp.choice ==1
		set_comp=true
		end
	end

	if set_comp
		call_msg("CompLisa:Lisa/LisaAbomHev_HealNoItem")
		call_msg("CompLisa:Lisa/LisaAbomHev_WithItem1")
		if $game_party.has_item?($data_items[31])
			optain_lose_item($data_items[31],1)
		elsif $game_party.item_number($data_items[30]) >=5
			optain_lose_item($data_items[30],5)
		end
		wait(30)
		$story_stats["RecQuestLisa"] = 4
			chcg_background_color(0,0,0,0,7)
			tmpEV = get_character(0)
			get_character(0).set_this_event_companion_ext("CompExtUniqueLisa",false,10+$game_date.dateAmt)
			get_character(0).delete
			$game_map.reserve_summon_event("CompExtUniqueLisa",tmpLisaX,tmpLisaY)
			set_event_force_page(tmpID,7)
			$game_player.moveto(tmpLisaX,tmpLisaY+1)
			$game_player.direction = 8
			SndLib.sound_eat
			wait(45)
			SndLib.sound_eat
			wait(45)
			SndLib.sound_eat
			wait(70)
			call_msg("CompLisa:Lisa/LisaAbomHev_WithItem2")
			call_msg("CompLisa:Lisa/LisaAbomHev_WithItem3")
			call_msg("CompLisa:Lisa/LisaAbomHev_WithItem4")
			chcg_background_color(0,0,0,255,-7)
		call_msg("CompLisa:Lisa/LisaAbomHev_WithItem5")
	end
else
	call_msg("CompLisa:Lisa/LisaAbomHev_HealNoItem")
	call_msg("CompLisa:Lisa/LisaAbomHev_Clear3")
end

portrait_hide