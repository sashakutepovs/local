tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
get_character(tmpWakeUpID).switch2_id = 1 #1 how many days, 2 do rape?

######################################## begin event ###############################################################
if $story_stats["Captured"] == 1 #$story_stats["ReRollHalfEvents"] ==1
tmpFucker1X,tmpFucker1Y,tmpFucker1ID = $game_map.get_storypoint("Raper1")
get_character(tmpFucker1ID).moveto($game_player.x,$game_player.y+3)
######################################## Food event ###############################################################
	if $game_date.day?
		call_msg("TagMapSaintMonasteryB1:belever/PlaceFood0")
		call_msg("TagMapNoerMobHouse:Rogue/PlaceFood1")
		$game_map.reserve_summon_event("ItemBread",tmpWakeUpX,tmpWakeUpY+1) 
		$game_map.reserve_summon_event("ItemBread",tmpWakeUpX,tmpWakeUpY+1)
	end
$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
get_character(tmpFucker1ID).call_balloon(5)
call_msg("TagMapSaintMonasteryB1:beginEvent/begin")
$game_map.interpreter.chcg_background_color(0,0,0,0,7)
get_character(tmpFucker1ID).moveto(tmpFucker1X,tmpFucker1Y)
return portrait_hide
end