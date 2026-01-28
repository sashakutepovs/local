$game_timer.off


if $game_player.actor.action_state == :sex || IsChcg?
	get_character(0).erase
	return
end

tmp_fucker_id = nil
$game_map.npcs.each do |event| 
	next if event.summon_data == nil
	next if event.summon_data[:BarGuard] == nil
	next if !event.summon_data[:BarGuard]
	next if event.actor.action_state != nil && event.actor.action_state !=:none
	next if !event.actor.target.nil?
	event.summon_data[:BarGuard] = false
	play_sex = true
	tmp_fucker_id = event.id
end

#no need? because only mama let you work
if tmp_fucker_id == nil
	call_msg("common:Lona/NarrDriveAway")
	change_map_leave_tag_map
	portrait_hide
	get_character(0).erase
	return
end




wid = tmp_fucker_id
res1 = get_character(wid) != nil && get_character(wid).npc.action_state == :none
res2 = get_character(wid) != nil && get_character(wid).npc.action_state == nil
if res1 || res2
	user=get_character(wid)
	tgt=$game_player
	get_character(wid).force_update =true
	get_character(wid).combat_jump_to_target(user,tgt)
	get_character(wid).turn_toward_character(tgt)
	$game_player.turn_toward_character(get_character(wid))
	wait(30)
	$game_player.actor.stat["EventVagRace"] = "Human"
	get_character(wid).animation = get_character(wid).animation_atk_sh
	load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
	call_msg("TagMapNoerGoldenBar:Guard/Failed0")
	$game_player.actor.stat["EventVagRace"] = "Human"
	get_character(wid).animation = get_character(wid).animation_atk_mh
	load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
	call_msg("TagMapNoerGoldenBar:Guard/Failed1")
	$game_player.actor.stat["EventVagRace"] = "Human"
	get_character(wid).animation = get_character(wid).animation_atk_sh
	load_script("Data/HCGframes/Grab_EventVag_Punch.rb")
	call_msg("TagMapNoerGoldenBar:Guard/Failed2")
	whole_event_end
end
portrait_hide
get_character(0).erase
change_map_leave_tag_map