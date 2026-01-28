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

if tmp_aggro == false && $story_stats["Captured"] == 0 && $story_stats["RapeLoop"] == 0
	call_msg("TagMapDoomFarmA:papa/begin1")
	get_character(tmpMamaID).turn_toward_character($game_player)
	call_msg("TagMapDoomFarmA:papa/begin2") #[算了吧,好,關於]
	get_character(tmpMamaID).direction = 2
	if $game_temp.choice == 1
		load_script("Data/HCGframes/event/DoomFarmA_Dinner.rb")
	elsif $game_temp.choice == 2
		call_msg("TagMapDoomFarmA:papa/about_1")
	else
		call_msg("TagMapDoomFarmA:papa/begin_nope1")
		SndLib.sound_equip_armor
		$game_player.animation = $game_player.animation_grabbed_qte
		get_character(0).animation = get_character(0).animation_hold_shield
		call_msg("TagMapDoomFarmA:papa/begin_nope2")
		get_character(tmpMamaID).turn_toward_character($game_player)
		call_msg("TagMapDoomFarmA:papa/begin_nope3")
		SndLib.sound_equip_armor
		$game_player.animation = nil
		get_character(0).animation = nil
		get_character(0).turn_toward_character(get_character(tmpMamaID))
		call_msg("TagMapDoomFarmA:papa/begin_nope4")
		get_character(0).direction = 2
		get_character(tmpMamaID).direction = 2
	end
	
elsif tmp_aggro == false && $story_stats["Captured"] == 1 && get_character(0).summon_data[:suck_job] == false
	get_character(0).call_balloon(0)
	call_msg("TagMapDoomFarmA:JobSuck/Papa_start")
	get_character(0).npc_story_mode(true)
	get_character(0).animation = get_character(0).animation_peeing
	wait(1)
	get_character(0).npc_story_mode(false)
	load_script("Data/HCGframes/event/DoomFarmA_SuckPapa.rb")
	whole_event_end
	get_character(0).summon_data[:suck_job] = true
	call_msg("TagMapDoomFarmA:JobSuck/Papa_Done")
	get_character(0).animation = nil
	if get_character(tmpPapaID).summon_data[:suck_job] == true && get_character(tmpMamaID).summon_data[:suck_job] == true
		get_character(tmpMamaID).call_balloon(28,-1)
	end
	
elsif tmp_aggro == false && $story_stats["Captured"] == 1
	get_character(tmpMcID).summon_data[:PapaRaped] = true
	SndLib.sound_equip_armor
	$game_player.animation = $game_player.animation_grabbed_qte
	get_character(0).animation = get_character(0).animation_hold_shield
	get_character(0).call_balloon(0)
	$game_player.actor.stat["EventExt1Race"] = "Human"
	load_script("Data/HCGframes/Grab_EventExt1_Grab.rb")
	call_msg("TagMapDoomFarmA:papa/Capture")
	get_character(0).moveto($game_player.x,$game_player.y)
	portrait_hide
	play_sex_service_menu(get_character(0),0,nil,true)
	
	cam_center(0)
	portrait_hide
	$game_temp.choice = -1 
	whole_event_end
	
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