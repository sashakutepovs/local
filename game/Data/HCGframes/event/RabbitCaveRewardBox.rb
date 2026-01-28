if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).summon_data = {} if !get_character(0).summon_data
get_character(0).switch1_id = 0 if get_character(0).switch1_id == nil
tmpEvent = nil
tmpMobAlive = $game_map.npcs.any?{|event| 
	next unless event.summon_data
	next unless event.summon_data[:Mercenary]
	next if event.deleted?
	next if event.npc.action_state == :death
	next if event.npc.action_state == :stun
	next if event.npc.action_state == :sex
	tmpEvent = event
	true
}
get_character(0).summon_data[:CanOpen] = true if !tmpMobAlive && !tmpEvent
if (tmpMobAlive && tmpEvent != nil) || !get_character(0).summon_data[:CanOpen]
	get_character(0).switch1_id +=1
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Mercenary]
		next if event.npc.alert_level !=0
		next if [:sex,:death,:stun].include?(event.npc.action_state)
		event.set_manual_move_type(3)
		if get_character(0).switch1_id <= 1
			event.move_type = 3 if event.move_type == 0
			event.call_balloon(1)
		else
			event.call_balloon(15)
			event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],1800)
		end
	}
	if get_character(0).switch1_id <=1
		cam_follow(tmpEvent.id,0)
		tmpEvent.turn_toward_character($game_player)
		tmpEvent.call_balloon(20)
		call_msg("TagMapRabbitCave:Box/MerAnyAlive0")
		cam_follow(tmpEvent.id,0)
		tmpEvent.call_balloon(5)
		call_msg("TagMapRabbitCave:Box/MerAnyAlive1")
		cam_center(0)
	else
		get_character(0).summon_data[:CanOpen] = true
		cam_follow(tmpEvent.id,0)
		tmpEvent.turn_toward_character($game_player)
		tmpEvent.call_balloon(5)
		call_msg("TagMapRabbitCave:Box/MerAnyAlive2")
		cam_follow(tmpEvent.id,0)
		tmpEvent.call_balloon(15)
		call_msg("TagMapRabbitCave:Box/MerAnyAlive3")
		cam_center(0)
		$game_map.npcs.each{
		|event|
			next unless event.summon_data
			next unless event.summon_data[:Mercenary]
			next if event.deleted?
			next if event.npc.action_state == :death
			next if event.npc.action_state == :sex
			event.npc.add_fated_enemy([0,8])
			event.npc.killer_condition={"health"=>[0, ">"]}
			event.npc.fraction_mode = 4
			event.set_manual_move_type(1)
			event.move_type = 1 if event.move_type == 0
			event.set_move_frequency(rand(3)+1)
			event.move_frequency = rand(3)+1
			event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
		}
	end
	portrait_hide
else
	SceneManager.goto(Scene_ItemStorage)
	SceneManager.scene.prepare(System_Settings::STORAGE_TEMP_MAP)
end