return if $story_stats["RecQuestMilo"] >= 6
$story_stats["RecQuestMilo"] = 5
tmpGrX,tmpGrY,tmpGrID=$game_map.get_storypoint("GrayRat")
tmpTp1X,tmpTp1Y,tmpTp1ID=$game_map.get_storypoint("TmpPoint1")
tmpTp2X,tmpTp2Y,tmpTp2ID=$game_map.get_storypoint("TmpPoint2")
tmpAdX,tmpAdY,tmpAdID=$game_map.get_storypoint("Adam")
portrait_off

if $story_stats["UniqueCharUniqueCecily"] != -1
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
		if $game_player.with_companion && $game_player.getComB_Name == "UniqueCecily"
			$game_map.events[$game_player.get_companion_id(1)].delete if ![0,nil].include?($game_player.get_companion_id(1))
			$game_map.events[$game_player.get_companion_id(0)].delete if ![0,nil].include?($game_player.get_companion_id(0))
			call_msg("common:Lona/Group_disbanded")
		end
		get_character(tmpGrID).opacity = 255
		get_character(tmpGrID).direction = 2
		get_character(tmpGrID).moveto(tmpTp1X,tmpTp1Y)
		call_msg("TagMapAbanHouse1:GrayRat/QuestBG1")
	chcg_background_color(0,0,0,255,-7)
	portrait_hide
	get_character(tmpGrID).npc_story_mode(true)
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpAdID).direction = 4
	call_msg("TagMapAbanHouse1:GrayRat/QuestBG2")
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpGrID).direction = 6
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpAdID).direction = 8
	call_msg("TagMapAbanHouse1:GrayRat/QuestBG3")
	$game_map.popup(tmpGrID,1,235,1)
	call_msg("TagMapAbanHouse1:GrayRat/QuestBG3_1")
	$game_portraits.lprt.hide
	get_character(tmpGrID).direction = 2
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpGrID).move_forward
	wait(35)
	get_character(tmpGrID).delete
	wait(35)
	call_msg("TagMapAbanHouse1:GrayRat/QuestBG4")
	cam_center(0)
end

call_msg("TagMapAbanHouse1:GrayRat/QuestBG5")
get_character(tmpAdID).call_balloon(28)
portrait_hide
cam_center(0)