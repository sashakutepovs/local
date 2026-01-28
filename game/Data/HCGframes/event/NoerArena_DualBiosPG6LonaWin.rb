
tmpBiosID = $game_map.get_storypoint("DualBios")[2]
tmpRpX,tmpRpY,tmpRpID=$game_map.get_storypoint("Reporter")
tmpPPLg1X,tmpPPLg1Y,tmpPPLg1ID=$game_map.get_storypoint("PPLg1")
tmpPPLg2X,tmpPPLg2Y,tmpPPLg2ID=$game_map.get_storypoint("PPLg2")
tmpPPLg3X,tmpPPLg3Y,tmpPPLg3ID=$game_map.get_storypoint("PPLg3")
tmpPPLg4X,tmpPPLg4Y,tmpPPLg4ID=$game_map.get_storypoint("PPLg4")
tmpTsX,tmpTsY,tmpTsID=$game_map.get_storypoint("TicketSeller")
tmpStartPointArenaX,tmpStartPointArenaY,tmpStartPointArenaID=$game_map.get_storypoint("StartPointArena")
tmpPlayerMatchOpp = get_character(tmpBiosID).summon_data[:PlayerMatchOpp]


$game_map.events.each{|event|
	next if !event[1].summon_data
	next if event[1].summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
	event[1].npc_story_mode(true)
	event[1].move_type = 0
}

get_character(tmpBiosID).summon_data[:HowMuch] = 0
get_character(tmpBiosID).summon_data[:PlayedOP] = true
get_character(tmpBiosID).summon_data[:PlayerMatch] = false
get_character(tmpBiosID).summon_data[:MatchEnd] = true

call_msg("TagMapNoerArena:PlayerMatch/win0") ; portrait_hide
tmpReward = 2000 - get_character(0).summon_data[:SavedTimer]
if tmpReward >= 1000
	cam_follow(tmpPPLg1ID,0) ; get_character(tmpPPLg1ID).call_balloon(20,1) ; SndLib.ppl_CheerGroup(80) ; wait(40)
	cam_follow(tmpPPLg2ID,0) ; get_character(tmpPPLg2ID).call_balloon(20,1) ; SndLib.ppl_CheerGroup(80) ; wait(40)
	cam_follow(tmpPPLg4ID,0) ; get_character(tmpPPLg4ID).call_balloon(20,1) ; SndLib.ppl_CheerGroup(80) ; wait(40)
	cam_follow(tmpPPLg3ID,0) ; get_character(tmpPPLg3ID).call_balloon(20,1) ; SndLib.ppl_CheerGroup(80) ; wait(40)
	call_msg("TagMapNoerArena:PlayerMatch/win1_InTime") ; portrait_hide
else
	cam_follow(tmpPPLg1ID,0) ; get_character(tmpPPLg1ID).call_balloon(5,1) ; SndLib.ppl_BooGroup(100) ; wait(40)
	cam_follow(tmpPPLg2ID,0) ; get_character(tmpPPLg2ID).call_balloon(7,1) ; SndLib.ppl_BooGroup(100) ; wait(40)
	cam_follow(tmpPPLg4ID,0) ; get_character(tmpPPLg4ID).call_balloon(15,1) ; SndLib.ppl_BooGroup(100) ; wait(40)
	cam_follow(tmpPPLg3ID,0) ; get_character(tmpPPLg3ID).call_balloon(15,1) ; SndLib.ppl_BooGroup(100) ; wait(40)
	call_msg("TagMapNoerArena:PlayerMatch/win1_OutTime") ; portrait_hide
end
tmpReward += 2000
tmpReward = 200 if tmpReward < 200
get_character(tmpBiosID).summon_data[:PlayerScore] = tmpReward


## get ach 
if tmpPlayerMatchOpp == "ArenaSexBeast"
	GabeSDK.getAchievement("ArenaSexBeastKilled")
else
	GabeSDK.getAchievement("ArenaWin")
end

call_timer_off
SndLib.bgm_stop
SndLib.bgs_stop
portrait_hide
$story_stats["RecQuestNoerArenaWinCount"] += 1
#put_map_items_into_box(tmpStorageID=System_Settings::STORAGE_TEMP_MAP)
############################################################################################### 非強暴LOOP 狀態 正常取得回報
if $story_stats["RapeLoop"] == 0
	$game_player.actor.record_lona_title = "Arena/Winner"
	SndLib.sys_StepChangeMap
	chcg_background_color(0,0,0,0,7)
		call_msg("TagMapNoerArena:PlayerMatch/win2")
		portrait_off
		$game_player.moveto(tmpStartPointArenaX,tmpStartPointArenaY)
		$game_player.direction = 2
		get_character(tmpTsID).call_balloon(28,-1)
		$game_map.events.each{|event|
			next if !event[1].summon_data
			next if event[1].summon_data[:ArenaTeamID] != tmpPlayerMatchOpp
			event[1].delete
		}
	chcg_background_color(0,0,0,255,-7)
	SndLib.bgm_play("/D/Arena-Western INSIDE LOOP",60,105)
	SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",50,100)
	############################################################################################### 奴隸狀態
else
	$game_player.actor.record_lona_title = "Arena/SlaveWinner"
	SndLib.bgm_stop
	SndLib.bgs_stop
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	call_msg("TagMapNoerArena:PlayerMatch/win2_slave") ; portrait_hide
	rape_loop_drop_item(tmpEquip=false,tmpSummon=false)
	change_map_enter_tagSub("NoerArenaB1")
	change_map_captured_story_stats_fix
end
