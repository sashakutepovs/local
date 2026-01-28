if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmp_moveType =  get_character(0).move_type
get_character(0).npc_story_mode(true)
	get_character(0).move_type = 0
	call_msg("TagMapNoerRelayOut:Fapper/begin0") ; portrait_hide
	get_character(0).animation = nil
	get_character(0).animation = get_character(0).animation_masturbation
	get_character(0).call_balloon(8) ; wait(60)
	$game_player.call_balloon(8) ; wait(60)
	call_msg("TagMapNoerRelayOut:Fapper/begin1") ; portrait_hide
	SndLib.sound_punch_hit(80)
	get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
	$game_player.animation = $game_player.animation_grabbed_qte
	wait(8)
	call_msg("TagMapNoerRelayOut:Fapper/begin2") ; portrait_hide
	$game_player.actor.stat["EventVagRace"] =  "Human"
	$game_player.actor.stat["EventAnalRace"] = "Human"
	$game_player.actor.stat["EventExt1Race"] = "Human"
		load_script("Data/HCGframes/Grab_EventVag_VagTouch.rb")
		call_msg("commonH:Lona/MilkSpray#{rand(5)}")
		call_msg("TagMapNoerRelayOut:Fapper/begin3")
		half_event_key_cleaner
		
		load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
		call_msg("commonH:Lona/MilkSpray#{rand(5)}")
		call_msg("TagMapNoerRelayOut:Fapper/begin4")
		half_event_key_cleaner
	check_half_over_event
	whole_event_end
	
	$game_player.animation = $game_player.animation_atk_mh
	get_character(0).animation = nil
	$game_player.call_balloon(5)
	wait(5)
	SndLib.sound_combat_whoosh
	wait(10)
	SndLib.sound_punch_hit
	get_character(0).jump_to(get_character(0).x,get_character(0).y)
	call_msg("TagMapNoerRelayOut:Fapper/begin5")
	call_msg("TagMapNoerRelayOut:Fapper/begin6")
	$game_player.direction = 2 ; $game_player.move_forward_force ; $game_player.direction = 8 ; $game_player.call_balloon(6)
	call_msg("TagMapNoerRelayOut:Fapper/begin7")
	get_character(0).npc.fucker_condition={"sex"=>[0, "="]}
	get_character(0).npc.remove_skill("killer","NpcMarkMoralityDown")
	get_character(0).npc.remove_skill("assaulter","NpcMarkMoralityDown")
get_character(0).npc_story_mode(false)
get_character(0).move_type = tmp_moveType


eventPlayEnd
