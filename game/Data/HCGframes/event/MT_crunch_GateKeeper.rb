if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
tmpToGraveX,tmpToGraveY,tmpToGraveID = $game_map.get_storypoint("ToGrave")
tmpMapContX,tmpMapContY,tmpMapContID = $game_map.get_storypoint("MapCont")
if $story_stats["RecQuestMT_UndeadQu"] == 2 && !get_character(tmpToGraveID).summon_data[:Unlocked]
	get_character(tmpToGraveID).summon_data[:Unlocked] = true
	call_msg("TagMapMT_crunch:Pitcher/UndeadGate0")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		SndLib.me_play("ME/Door - Medieval Open 16")
		wait(60)
		set_event_force_page(tmpToGraveID,1,4)
		set_event_force_page(tmpMapContID,4)
		get_character(0).direction = 8
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpToGraveID).call_balloon(28,-1)
	call_msg("TagMapMT_crunch:Pitcher/UndeadGate1")
elsif  $story_stats["RecQuestMT_UndeadQu"] == 2 && get_character(tmpToGraveID).summon_data[:Unlocked]
	call_msg("TagMapMT_crunch:Pitcher/UndeadGate1")
else
	call_msg("TagMapMT_crunch:Pitcher/UndeadGate_b4QU#{rand(3)}")
	
end



eventPlayEnd

return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestMT_UndeadQu"] == 2 && !get_character(tmpToGraveID).summon_data[:Unlocked]