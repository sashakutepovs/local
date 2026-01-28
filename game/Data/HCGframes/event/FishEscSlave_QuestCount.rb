tmpMcID = $game_map.get_storypoint("MapCont")[2]
totalSlave = 0
doEnemy = false
cam_id = -1
$game_map.npcs.each{|event|
	next unless event.summon_data
	next unless event.summon_data[:slave]
	next if event.deleted?
	next if event.npc.action_state == :death
	totalSlave += 1
}
if totalSlave >= 10 && get_character(tmpMcID).summon_data[:talked] == false
	get_character(tmpMcID).summon_data[:talked] = true
	get_character(tmpMcID).switch1_id = 0
	$game_temp.choice = -1
	
	
	$game_map.npcs.any?{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:slave]
		next if event.deleted?
		next if event.npc.action_state == :death
		next if event.npc.target == nil
		cam_id = event.id
	}
	cam_follow(cam_id,0)
	get_character(cam_id).call_balloon(1)
	$game_player.actor.wisdom_trait >=10	? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	tmpFishDudeInGroup = $game_player.record_companion_name_back == "CompFishShaman" || $game_player.record_companion_name_front == "CompFishGuard"
	call_msg("TagMapFishEscSlave:alert/MainGuard") #[路過,唬爛<r=HiddenOPT0>]
	case $game_temp.choice
		when 0
			call_msg("TagMapFishEscSlave:alert/MainGuard_passByAns")
			if tmpFishDudeInGroup
				cam_follow(cam_id,0)
				get_character(cam_id).call_balloon(2)
				call_msg("TagMapFishEscSlave:alert/MainGuard_passByLose_follower")
				cam_follow(cam_id,0)
				get_character(cam_id).call_balloon(20)
				call_msg("TagMapFishEscSlave:alert/MainGuard_passByLose")
				doEnemy = true
			
			elsif $game_player.player_slave? || $game_player.actor.weak > 50
				cam_follow(cam_id,0)
				get_character(cam_id).call_balloon(8)
				call_msg("TagMapFishEscSlave:alert/MainGuard_passByWin")
				doEnemy = false
				
			else
				cam_follow(cam_id,0)
				get_character(cam_id).call_balloon(20)
				call_msg("TagMapFishEscSlave:alert/MainGuard_passByLose")
				doEnemy = true
			end
		when 1
			call_msg("TagMapFishEscSlave:alert/MainGuard_BluffAns")
			if tmpFishDudeInGroup
				cam_follow(cam_id,0)
				get_character(cam_id).call_balloon(2)
				call_msg("TagMapFishEscSlave:alert/MainGuard_passByLose_follower")
				cam_follow(cam_id,0)
				get_character(cam_id).call_balloon(20)
				call_msg("TagMapFishEscSlave:alert/MainGuard_passByLose")
				doEnemy = true
			else
				cam_follow(cam_id,0)
				get_character(cam_id).call_balloon(4)
				call_msg("TagMapFishEscSlave:alert/MainGuard_BluffWin")
				doEnemy = false
			end
	end
	
else
	get_character(tmpMcID).summon_data[:talked] = true
	doEnemy = true
end

if doEnemy == false
	get_character(tmpMcID).summon_data[:enemy] = false
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:slave]
		next if event.deleted?
		next if event.npc.action_state == :death
		event.npc.fucker_condition={"sex"=>[65535, "="]}
		event.npc.killer_condition={"sex"=>[65535, "="]}
		event.npc.assaulter_condition={"sex"=>[65535, "="]}
		event.npc.process_target_lost
	}
elsif doEnemy == true
	get_character(tmpMcID).summon_data[:enemy] = true
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:slave]
		next if event.deleted?
		next if event.npc.action_state == :death
		event.npc.fucker_condition={"sex"=>[65535, "="]}
		event.npc.killer_condition={"weak"=>[11, "<"]}
		event.npc.assaulter_condition={"weak"=>[10, ">"]}
	}
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:guard]
		next if event.deleted?
		next if event.npc.action_state == :death
		event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],60)
	}
end
$story_stats["HiddenOPT0"] = "0"
eventPlayEnd
