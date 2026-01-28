
return if $story_stats["Captured"] == 0
tmpMcX,tmpMcY,tmpMcID = $game_map.get_storypoint("MapCont")
tmpMamaX,tmpMamaY,tmpMamaID = $game_map.get_storypoint("mama")
tmpPapaX,tmpPapaY,tmpPapaID = $game_map.get_storypoint("papa")
tmpSonX,tmpSonY,tmpSonID = $game_map.get_storypoint("son")
tmpMcX,tmpMcY,tmpMcID = $game_map.get_storypoint("MapCont")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUpSexBed")
tmpMaBedX,tmpMaBedY,tmpMaBedID = $game_map.get_storypoint("MamaBed")
tmpTorX,tmpTorY,tmpTorID = $game_map.get_storypoint("torturePT")
tmpMtX,tmpMtY,tmpMtID = $game_map.get_storypoint("MainTable")
tmpHtcX,tmpHtcY,tmpHtcID = $game_map.get_storypoint("HouseToOutC")

tmpPapaRaped	=	get_character(tmpMcID).summon_data[:PapaRaped]
tmpBreakfast	=	get_character(tmpMcID).summon_data[:Breakfast]
tmpWorked		=	get_character(tmpMcID).summon_data[:Worked]
tmpWorkType		=	get_character(tmpMcID).summon_data[:WorkType]
tmpNeedWork		=	get_character(tmpMcID).summon_data[:NeedWork]
p tmpNeedWork
p tmpBreakfast
p tmpWorked
p tmpWorkType

if get_character(tmpMcID).summon_data[:CarryFood] == false && tmpWorkType == "feed"
 $game_player.animation = $game_player.animation_mc_pick_up
 $game_player.actor.sta -= 3
 SndLib.sound_equip_armor
 get_character(tmpMcID).summon_data[:CarryFood] = true
 $game_map.events.each{|event|
  next if !event[1].summon_data
  next unless event[1].summon_data[:food] == true
  next if event[1].deleted?
  event[1].call_balloon(0)
 }
 $game_map.events.each{|event|
  next if !event[1].summon_data
  next if event[1].summon_data[:chicken] != true
  next unless event[1].summon_data[:feeded] == false
  next if event[1].deleted?
  event[1].call_balloon(28,-1)
 }
return get_character(0).delete
end


tmp_aggro = false
get_character(tmpMtID).call_balloon(0)

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
if tmp_aggro == false && $story_stats["Captured"] == 1 && tmpNeedWork && tmpBreakfast && tmpWorked && tmpWorkType == nil
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_map.set_fog(nil)
		weather_stop
		$game_player.moveto(tmpMtX+1,tmpMtY)
		get_character(tmpSonID).moveto(tmpMtX+1,tmpMtY-1)
		get_character(tmpPapaID).moveto(tmpMtX-1,tmpMtY-1)
		get_character(tmpMamaID).moveto(tmpMtX-1,tmpMtY)
		$game_player.direction = 4
		get_character(tmpSonID).direction = 4
		get_character(tmpPapaID).direction = 6
		get_character(tmpMamaID).direction = 6
		move_type_tmpMamaID = get_character(tmpMamaID).move_type
		move_type_tmpPapaID = get_character(tmpPapaID).move_type
		move_type_tmpSonID = get_character(tmpSonID).move_type
		
		SndLib.sound_eat(90)
		wait(50+rand(20))
		SndLib.sound_eat(85)
		wait(50+rand(20))
		SndLib.sound_eat(90)
		wait(50+rand(20))
		
		$game_player.actor.itemUseBatch("ItemSopGood")
		$game_player.actor.itemUseBatch("ItemApple")
		$game_player.actor.itemUseBatch("ItemApple")
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapDoomFarmA:breakFast/begin_1")
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		get_character(tmpMamaID).animation = nil
		get_character(tmpMamaID).moveto(tmpMamaX,tmpMamaY)
		get_character(tmpPapaID).moveto(tmpPapaX,tmpPapaY)
		get_character(tmpSonID).moveto(tmpSonX,tmpSonY)
		get_character(tmpMamaID).npc_story_mode(false)
		get_character(tmpPapaID).npc_story_mode(false)
		get_character(tmpSonID).npc_story_mode(false)
		get_character(tmpMamaID).move_type = move_type_tmpMamaID
		get_character(tmpPapaID).move_type = move_type_tmpPapaID
		get_character(tmpSonID).move_type = move_type_tmpSonID
		get_character(tmpMamaID).direction = 2
		get_character(tmpPapaID).direction = 2
		get_character(tmpSonID).direction = 2
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpMcID).summon_data[:Breakfast] = false
	get_character(tmpMamaID).call_balloon(28,-1)
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
