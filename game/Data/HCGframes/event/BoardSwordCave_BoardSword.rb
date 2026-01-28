if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $game_player.direction != 8
	SndLib.sys_trigger
	return
end
$story_stats["HiddenOPT0"] = 0
get_character(0).call_balloon(0)
call_msg("TagMapBoardSwordCave:BoardWarning/BRD0")
if $game_player.record_companion_name_back == "UniqueCecily"
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(0)).moveto($game_player.x+1,$game_player.y)
		get_character($game_player.get_followerID(1)).moveto($game_player.x-1,$game_player.y)
		get_character($game_player.get_followerID(0)).direction = 4
		get_character($game_player.get_followerID(1)).direction = 6
		$game_player.moveto($game_player.x,$game_player.y+1)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapBoardSwordCave:BoardSword/Cecily0")
elsif cocona_in_group?
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(0)).moveto($game_player.x-1,$game_player.y)
		get_character($game_player.get_followerID(0)).direction = 6
	chcg_background_color(0,0,0,255,-7)
	$story_stats["HiddenOPT0"] = "1"
end
call_msg("TagMapBoardSwordCave:BoardSword/0to1_0") #[不是,我是,好朋友<r=HiddenOPT0>]
if $game_temp.choice == 1
	$story_stats["OverMapEvent_enemy"] = 1
	$story_stats["OnRegionMapSpawnRace"] = "UndeadWalking"
	$story_stats["OverMapEvent_name"] = "_bad_UndeadWalking"
	$story_stats["OverMapEvent_saw"] = 1
	tmpBoardSwordX,tmpBoardSwordY,tmpBoardSwordID= $game_map.get_storypoint("BoardSword")
	tmpPillarLX,tmpPillarLY,tmpPillarLID= $game_map.get_storypoint("PillarL")
	tmpPillarRX,tmpPillarRY,tmpPillarRID= $game_map.get_storypoint("PillarR")
	tmpBlock1X,tmpBlock1Y,tmpBlock1ID= $game_map.get_storypoint("Block1")
	tmpBlock2X,tmpBlock2Y,tmpBlock2ID= $game_map.get_storypoint("Block2")
	tmpBlock3X,tmpBlock3Y,tmpBlock3ID= $game_map.get_storypoint("Block3")
	tmpUndeadCropseX,tmpUndeadCropseY,tmpUndeadCropseID= $game_map.get_storypoint("UndeadCropse")
	tmpEliteWarriorX,tmpEliteWarriorY,tmpEliteWarriorID= $game_map.get_storypoint("EliteWarrior")
	tmpMapContX,tmpMapContY,tmpMapContID= $game_map.get_storypoint("MapCont")
	get_character(tmpBlock1ID).opacity = 255
	get_character(tmpBlock2ID).opacity = 255
	get_character(tmpBlock3ID).opacity = 255
	get_character(tmpBlock1ID).through = false
	get_character(tmpBlock2ID).through = false
	get_character(tmpBlock3ID).through = false
	call_msg("TagMapBoardSwordCave:BoardSword/0to1_1_yes0") ; portrait_hide
	$game_map.interpreter.screen.start_shake(1,7,60)
	SndLib.sound_FlameCast(60,70)
	wait(60)
	$game_player.direction = 2
	call_msg("TagMapBoardSwordCave:BoardSword/0to1_1_yes1") ; portrait_hide
	$game_map.interpreter.screen.start_shake(5,10,60)
	SndLib.sound_FlameCast(80,70)
	wait(60)
	$game_map.interpreter.screen.start_shake(5,10,60)
	SndLib.sound_FlameCast(100,70)
	wait(60)
	get_character(tmpUndeadCropseID).opacity = 255
	get_character(tmpUndeadCropseID).npc_story_mode(true)
	get_character(tmpUndeadCropseID).animation = get_character(tmpUndeadCropseID).animation_Undead_surprised
	wait(22)
	SndLib.sound_UndeadSurprise
	wait(5)
	get_character(tmpEliteWarriorID).moveto(tmpUndeadCropseX,tmpUndeadCropseY)
	get_character(tmpEliteWarriorID).move_type = 8
	get_character(tmpEliteWarriorID).set_manual_move_type(8)
	get_character(tmpUndeadCropseID).npc_story_mode(false)
	get_character(tmpUndeadCropseID).delete
	wait(22)
	get_character(tmpEliteWarriorID).call_balloon(8)
	$game_player.call_balloon(8)
	wait(60)
	SndLib.bgm_play("CB_-_Zombies_Everywhere",90,100)
	SndLib.bgs_stop
	SndLib.bgs_play("WindMountain",60,200) #"WindMountain",90,200
	call_msg("TagMapBoardSwordCave:BoardSword/0to1_1_yes2") ; portrait_hide
	get_character(0).trigger = -1
	get_character(0).through = true
	get_character(0).effects=["FadeOff",0,false,nil,nil,[true,false].sample]
	
	set_event_force_page(tmpMapContID,9)
elsif $game_temp.choice == 2 ####################### COCONA friend
	tmpBoardSwordX,tmpBoardSwordY,tmpBoardSwordID= $game_map.get_storypoint("BoardSword")
	call_msg("TagMapBoardSwordCave:BoardSword/Cocona0") ; portrait_hide
	get_character($game_player.get_followerID(0)).npc_story_mode(true)
	tmpCOmove_type = get_character($game_player.get_followerID(0)).move_type
	get_character($game_player.get_followerID(0)).move_type = 0
	$game_player.direction = 2 ; $game_player.move_forward_force ; $game_player.move_speed = 3
	$game_player.direction = 8
	get_character($game_player.get_followerID(0)).direction = 6 ; get_character($game_player.get_followerID(0)).move_forward_force ; get_character($game_player.get_followerID(0)).move_speed = 3
	wait(30)
	get_character($game_player.get_followerID(0)).direction = 8
	wait(20)
	get_character($game_player.get_followerID(0)).animation = get_character($game_player.get_followerID(0)).animation_hold_casting_mh
	4.times{
		wait(30)
		SndLib.sound_FlameCast(80)
	}
	get_character($game_player.get_followerID(0)).animation = get_character($game_player.get_followerID(0)).animation_casting_mh
	wait(30)
	EvLib.sum("EffectLifeBuffRev",tmpBoardSwordX,tmpBoardSwordY)
	wait(30)
	get_character($game_map.get_storypoint("BoardSword")[2]).trigger = -1
	get_character($game_map.get_storypoint("BoardSword")[2]).effects=["FadeOutDelete",0,false,nil,nil,[true,false].sample]
	get_character($game_map.get_storypoint("BoardSword")[2]).npc_story_mode(true)
	get_character($game_player.get_followerID(0)).direction = 8
	wait(30)
	get_character($game_player.get_followerID(0)).direction = 2
	call_msg("TagMapBoardSwordCave:BoardSword/Cocona1")
	get_character($game_player.get_followerID(0)).animation = get_character($game_player.get_followerID(0)).animation_atk_sh
	$story_stats["RecQuestBoardSwordCave"] = 1
	optain_item("ItemMhBroadSword",1)
	wait(30)
	optain_exp(5000)
	call_msg("TagMapBoardSwordCave:BoardSword/Cocona2")
	get_character($game_player.get_followerID(0)).move_type = tmpCOmove_type
	get_character($game_player.get_followerID(0)).npc_story_mode(false)
else
	call_msg("TagMapBoardSwordCave:BoardSword/0to1_1_no")
	get_character(0).call_balloon(28,-1) if $story_stats["RecQuestBoardSwordCave"] == 0
end
$story_stats["HiddenOPT0"] = 0
eventPlayEnd
