
$game_map.npcs.any?{|ev|
	next unless ev.summon_data
	next unless ev.summon_data[:TribeDudes]
	ev.delete if ![:none,nil].include?(ev.npc.action_state)
}
tmpTribeDudeAlive = $game_map.npcs.any?{|ev|
	next unless ev.summon_data
	next unless ev.summon_data[:TribeDudes]
	next unless [:none,nil].include?(ev.npc.action_state)
	true
}
if tmpTribeDudeAlive
	tmpArcherX,tmpArcherY,tmpArcherID = $game_map.get_storypoint("Archer")
	get_character(tmpArcherID).process_npc_DestroyForceRoute
	get_character(tmpArcherID).npc_story_mode(true)
	get_character(tmpArcherID).moveto($game_player.x-2,$game_player.y)
	if !get_character(tmpArcherID).summon_data[:follower]
		get_character(tmpArcherID).opacity = 0
		51.times{
			get_character(tmpArcherID).opacity += 5
			wait(1)
		}
	end
	SndLib.MaleWarriorGruntSpot(100)
	get_character(tmpArcherID).jump_to($game_player.x,$game_player.y)
	get_character(tmpArcherID).turn_toward_character($game_player)
	wait(12)
	get_character(tmpArcherID).item_jump_to
	get_character(tmpArcherID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpArcherID))
	wait(30)
	call_msg("TagMapTribeForest:Archer/end_alive1")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("TagMapTribeForest:Archer/end_cut")
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapTribeForest:Archer/end_alive2")
	get_character(tmpArcherID).set_animation("animation_atk_sh")
	wait(20)
	optain_item($data_items[124],1) #ItemQuestBoarPenis
	wait(20)
	call_msg("TagMapTribeForest:Archer/end_alive3")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpArcherID).delete
	chcg_background_color(0,0,0,255,-7)
else
	
	call_msg("TagMapTribeForest:Archer/end_dead1")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		call_msg("TagMapTribeForest:Archer/end_cut")
	chcg_background_color(0,0,0,255,-7)
	wait(20)
	optain_item($data_items[124],1) #ItemQuestBoarPenis
	call_msg("TagMapTribeForest:Archer/end_dead2")
end
call_msg("TagMapTribeForest:Archer/end_end")
eventPlayEnd
$story_stats["RecQuestPenisTribeHelp"] = 3