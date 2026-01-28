if $game_map.threat
 SndLib.sys_buzzer
 $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
 return
end

tmpMamaX,tmpMamaY,tmpMamaID = $game_map.get_storypoint("mama")
tmpPapaX,tmpPapaY,tmpPapaID = $game_map.get_storypoint("papa")
tmpSonX,tmpSonY,tmpSonID = $game_map.get_storypoint("son")
tmpMcX,tmpMcY,tmpMcID = $game_map.get_storypoint("MapCont")
tmp_aggro = false

get_character(0).animation =  nil
get_character(0).call_balloon(0)
#check family count
tmpTodoCount = 0
$game_map.npcs.each{
|event|
	next unless event.summon_data
	next unless event.summon_data[:family]
	next if event.npc.action_state == :death
	next if event.deleted?
	tmpTodoCount +=1
}

#if ne1 dead
if tmpTodoCount < 3
	tmp_aggro = true
end

if tmp_aggro == false && $story_stats["Captured"] == 0
	call_msg("TagMapDoomFarmA:son/begin0")
	SndLib.sound_equip_armor
	$game_player.animation = $game_player.animation_grabbed_qte
	get_character(0).animation = get_character(0).animation_hold_shield
	call_msg("TagMapDoomFarmA:son/begin1")
	SndLib.sound_equip_armor
	$game_player.animation = nil
	get_character(0).animation = nil
	call_msg("TagMapDoomFarmA:son/begin2")

elsif tmp_aggro == false && $story_stats["Captured"] == 1 && $game_date.day?
	call_msg("TagMapDoomFarmA:son/Capture")

elsif tmp_aggro == false && $story_stats["Captured"] == 1 && $game_date.night? && !get_character(tmpMcID).summon_data[:BoboKill]
	# 5 10 15 20 25
	tmpTier = 1
	if tmpTier == 1
		$game_player.actor.wisdom_trait >= 5 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		call_msg("TagMapDoomFarmA:son/Capture_night_t1")
		tmpTier += 1 if $game_temp.choice == 1
	end
	if tmpTier == 2
		$game_player.actor.wisdom_trait >= 10 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		call_msg("TagMapDoomFarmA:son/Capture_night_t2")
		tmpTier += 1 if $game_temp.choice == 1
	end
	if tmpTier == 3
		$game_player.actor.wisdom_trait >= 15 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		call_msg("TagMapDoomFarmA:son/Capture_night_t3")
		tmpTier += 1 if $game_temp.choice == 1
	end
	if tmpTier == 4
		$game_player.actor.wisdom_trait >= 20 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		call_msg("TagMapDoomFarmA:son/Capture_night_t4")
		tmpTier += 1 if $game_temp.choice == 1
	end
	if tmpTier == 5
		call_msg("TagMapDoomFarmA:son/Capture_night_t5")
		get_character(tmpMcID).summon_data[:BoboKill] = true
	end
	
	if [0,-1].include?($game_temp.choice)
		call_msg("TagMapDoomFarmA:son/Capture_night_Failed#{rand(3)}")
	end
	$story_stats["HiddenOPT1"] = "0"
elsif tmp_aggro == false && $story_stats["Captured"] == 1 && $game_date.night? && get_character(tmpMcID).summon_data[:BoboKill]
	call_msg("TagMapDoomFarmA:son/Capture_night_WIN")
end


if tmp_aggro == true
	$game_map.npcs.each{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:family]
		next if event.npc.action_state == :death
		next if event.deleted?
		event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
		event.call_balloon(1)
	}
	portrait_hide
	cam_center(0)
	return
end


portrait_hide
cam_center(0)