$game_timer.off


if $game_player.actor.action_state == :sex || IsChcg?
	get_character(0).erase
	return
end

#no need? because only mama let you work
if $story_stats["UniqueCharUniqueTavernWaifu"] == -1
	call_msg("common:Lona/NarrDriveAway")
	eventPlayEnd
	return change_map_leave_tag_map
end

wid = -1
tmpMamaThere = $game_map.npcs.any?{|ev|
	next if !ev.summon_data
	next if !ev.summon_data[:TavernWaifu]
	next if ev.npc.action_state == :death
	next if ev.deleted? || ev.erased
	wid = ev.id
	true
}
res1 = get_character(wid) != nil && get_character(wid).npc.action_state == :none
res2 = get_character(wid) != nil && get_character(wid).npc.action_state == nil
if tmpMamaThere && (res1 || res2)
	user=get_character(wid)
	tgt=$game_player
	get_character(wid).npc_story_mode(true)
		get_character(wid).move_type = 0
		get_character(wid).animation = nil
		get_character(wid).combat_jump_to_target(user,tgt)
		get_character(wid).turn_toward_character(tgt)
		$game_player.turn_toward_character(get_character(wid))
		call_msg("TagMapNoerTavern:Waifu/WorkFailed0")
		$game_player.actor.stat["EventVagRace"] = "Human"
		get_character(wid).animation = get_character(wid).animation_atk_sh
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		call_msg("TagMapNoerTavern:Waifu/WorkFailed1")
		$game_player.actor.stat["EventVagRace"] = "Human"
		get_character(wid).animation = get_character(wid).animation_atk_mh
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		call_msg("TagMapNoerTavern:Waifu/WorkFailed2")
		$game_player.actor.stat["EventVagRace"] = "Human"
		get_character(wid).animation = get_character(wid).animation_atk_sh
		load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
		call_msg("TagMapNoerTavern:Waifu/WorkFailed3")
	get_character(wid).npc_story_mode(false)
	whole_event_end
end
portrait_off
change_map_leave_tag_map
return eventPlayEnd