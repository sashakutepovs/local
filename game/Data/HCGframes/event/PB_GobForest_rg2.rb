return get_character(0).erase if $story_stats["QuProgPB_GobForest"] >= 1
$story_stats["QuProgPB_GobForest"] = 1
tmpStoryFishX,tmpStoryFishY,tmpStoryFishID = $game_map.get_storypoint("StoryFish")
tmpGobPtX,tmpGobPtY,tmpGobPtID = $game_map.get_storypoint("GobPt")
tmpSawPT1X,tmpSawPT1Y,tmpSawPT1ID = $game_map.get_storypoint("SawPT1")
get_character(tmpStoryFishID).npc_story_mode(true)


chcg_background_color(0,0,0,0,7)
	get_character(tmpStoryFishID).moveto(tmpGobPtX,tmpGobPtY)
	get_character(tmpStoryFishID).call_balloon(6,-1)
	$game_player.moveto(tmpSawPT1X,tmpSawPT1Y)
	$game_player.direction = 6
chcg_background_color(0,0,0,255,-7)

$game_player.call_balloon(8)
$game_player.direction = 4
wait(60)
$game_player.call_balloon(8)
$game_player.direction = 2
wait(60)
$game_player.call_balloon(8)
$game_player.direction = 8
call_msg("TagMapPB_GobForest:rg2/Begin_0") ; portrait_hide

SndLib.stepBush(100)
wait(5)
SndLib.stepBush(100)
wait(5)
$game_player.direction = 6
$game_player.call_balloon(1)
call_msg("TagMapPB_GobForest:rg2/Begin_2") ; portrait_hide
sndVol = 0
8.times{
	sndVol += 10
	get_character(tmpStoryFishID).direction = 4
	get_character(tmpStoryFishID).move_forward_force
	wait(15)
	SndLib.stepBush(sndVol)
}
SndLib.FishkindSmSkill
get_character(tmpStoryFishID).call_balloon(0)
get_character(tmpStoryFishID).jump_to(get_character(tmpStoryFishID).x,get_character(tmpStoryFishID).y)
wait(60)
call_msg("TagMapPB_GobForest:rg2/Begin_3") ; portrait_hide
sndVol = 90
8.times{
	sndVol -= 10
	get_character(tmpStoryFishID).move_speed = 4.5
	get_character(tmpStoryFishID).direction = 6
	get_character(tmpStoryFishID).move_forward_force
	wait(7)
	SndLib.stepBush(sndVol)
}
$game_player.call_balloon(8)
wait(60)
call_msg("TagMapPB_GobForest:rg2/Begin_4") ; portrait_hide


get_character(tmpStoryFishID).delete
eventPlayEnd
get_character(0).erase