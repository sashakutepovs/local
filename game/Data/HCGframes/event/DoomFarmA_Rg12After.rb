tmpMamaX,tmpMamaY,tmpMamaID = $game_map.get_storypoint("mama")
tmpPapaX,tmpPapaY,tmpPapaID = $game_map.get_storypoint("papa")
tmpSonX,tmpSonY,tmpSonID = $game_map.get_storypoint("son")

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
if tmpTodoCount != 3
	return get_character(0).erase
end
if $story_stats["Captured"] == 1
	tmpAggro = true
	$story_stats["RapeLoopTorture"] = 1
	
elsif $story_stats["RecQuestDoomFarmSpot"] ==1 && $story_stats["RecQuestDoomFarmAWaifu"] == 1
	tmpAggro = true
	$story_stats["RapeLoopTorture"] = 1

else #frist time
	$story_stats["RecQuestDoomFarmSpot"] = 1
	get_character(tmpPapaID).direction = 4
	get_character(tmpMamaID).direction = 4
	call_msg("TagMapDoomFarmA:FristTime/Enter1")
	get_character(tmpMamaID).direction = 6
	call_msg("TagMapDoomFarmA:FristTime/Enter2")
	get_character(tmpPapaID).direction = 2
	get_character(tmpMamaID).direction = 2
	if cocona_in_group?
		call_msg("TagMapDoomFarmA:FristTime/Enter3_cocona")
		tmpAggro = true
		tmpWAR = true
	elsif ["UniqueGrayRat"].include?($game_player.record_companion_name_front)
		call_msg("TagMapDoomFarmA:FristTime/Enter3_grayrat")
		tmpAggro = true
		tmpWAR = true
	end
end

if tmpAggro
	$game_player.call_balloon(19)
	$game_map.npcs.each{
	|event|
	next unless event.summon_data
	next unless event.summon_data[:family]
	next if event.npc.action_state == :death
	next if event.deleted?
	event.trigger = -1
	event.npc.set_fraction(5)
	event.npc.fated_enemy = [0,1,2,3,4,6,7,8,9,10,11,12]
	event.npc.fraction_mode = 4
	if event.summon_data[:mother] || event.summon_data[:son]
	event.npc.fucker_condition={"sex"=>[65535, "="]}
	event.npc.killer_condition={"morality"=>[5000, "<"],"weak"=>[40, "<"]}
	event.npc.assaulter_condition={"morality"=>[5000, "<"],"weak"=>[40, ">"]}
	elsif event.summon_data[:father]
	event.npc.fucker_condition={"sex"=>[65535, "="]}
	event.npc.killer_condition={"morality"=>[5000, "<"],"weak"=>[40, "<"]}
	event.npc.assaulter_condition={"morality"=>[5000, "<"],"weak"=>[40, ">"]}
	end
	event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600) if tmpWAR
	#event.actor.battle_stat.set_stat_m("morality",-100,[0,2,3]) if tmpWAR
	}
end

portrait_hide
cam_center(0)
get_character(0).erase