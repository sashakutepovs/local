#請記得起承轉合理論  世界事件> 陣營事件 > 人物事件> 主角結局
$game_portraits.setLprt("nil")
$game_portraits.setRprt("nil")
SndLib.bgs_stop
SndLib.bgm_stop
$hudForceHide = true
$balloonForceHide = false
#################################################序
chcg_background_color(0,0,0,1,7)
SndLib.bgm_play("Peace in My World_Loop",vol=90,pitch=85)
SndLib.scene_off
call_msg("commonEnding:Common/EndingBegin")
#####################################################6+++


################################################################################################################################ ENDING Orkind
$game_portraits.setLprt("nil")
$game_portraits.setRprt("nil")
chcg_background_color(0,0,0,255)

call_msg("commonEnding:Orkind/Common0")
call_msg("commonEnding:Orkind/OrkindDestroyed1_ClearnNoerOrkindQuest") if $story_stats["GuildCompletedScoutCampOrkind"] >= 3
call_msg("commonEnding:Orkind/OrkindDestroyed2")
$cg.erase
$bg.erase

################################################################################################################################ ENDING FishDudes
if $story_stats["EndUnlockFishTownL"] >= 1
	$game_portraits.setLprt("nil")
	$game_portraits.setRprt("nil")
	chcg_background_color(0,0,0,255)
	call_msg("commonEnding:FishKind/Common0")
	call_msg("commonEnding:FishKind/Common1")
	call_msg("commonEnding:FishKind/Common2")
	if $story_stats["RecQuestElise"] >= 18
		call_msg("commonEnding:FishKind/FishKindFine3")
	else
		call_msg("commonEnding:FishKind/FishKindDestroyed3")
	end
	$cg.erase
	$bg.erase
end

################################################################################################################################ DoomFort
if $story_stats["EndUnlockDoomFortressL"] >= 1
end

################################################################################################################################ PirateBane
if $story_stats["EndUnlockPirateBane"] >= 1
end

################################################################################################################################ SouthFL
if $story_stats["EndUnlockSouthFL"] >= 1
end

################################################################################################################################ ENDING NOER
$game_portraits.setLprt("nil")
$game_portraits.setRprt("nil")
chcg_background_color(0,0,0,255)
call_msg("commonEnding:Noer/Common0")
case $story_stats["Ending_Noer"]
	when "Ending_Noer_DestroyedByNuke"  #destroyed by ded one
		call_msg("commonEnding:Noer/NukeDestroyed")
		
	else ##########################Ending_Noer_DestroyedByOrkind
		call_msg("commonEnding:Noer/OrkindDestroyed1")
		call_msg("commonEnding:Noer/OrkindDestroyed2")
		call_msg("commonEnding:Noer/OrkindDestroyed2_QuProgCataUndeadHunt2_7") if $story_stats["QuProgCataUndeadHunt2"] == 7 #於可可娜墳場任務中堵死地下道
		call_msg("commonEnding:Noer/OrkindDestroyed3")
		call_msg("commonEnding:Noer/OrkindDestroyed4")
end
$cg.erase
$bg.erase


################################################################################################################################ NoerTavern 
if $story_stats["RecQuestCocona"] >= 21 && $story_stats["UniqueCharUniqueTavernWaifu"] != -1 && $story_stats["Ending_Noer"] != "Ending_Noer_DestroyedByNuke"
	call_msg("commonEnding:NoerTavern/Common0")
	if $story_stats["RecQuestCocona"] >= 29
		if $story_stats["RecQuestCoconaDefeatBossMama"] == 1
			call_msg("commonEnding:NoerTavern/BookOfDeath")
		else
			call_msg("commonEnding:NoerTavern/DefenceToDeath")
		end
	else
		call_msg("commonEnding:NoerTavern/FallWithCocona")
	end
	$cg.erase
	$bg.erase
end
################################################################################################################################ ENDING LONA
################################################################################################################################ ENDING LONA
################################################################################################################################ ENDING LONA
################################################################################################################################ ENDING LONA
################################################################################################################################ ENDING LONA
call_msg("commonEnding:Common/EndingLonaBegin")
$cg.erase
$bg.erase


################################################################################################################################ GO TO SHIP OR CREDIT OR GG
################################################################################################################################ GO TO SHIP OR CREDIT OR GG
################################################################################################################################ GO TO SHIP OR CREDIT OR GG
################################################################################################################################ GO TO SHIP OR CREDIT OR GG
################################################################################################################################ GO TO SHIP OR CREDIT OR GG
$game_map.interpreter.chcg_background_color(0,0,0,0)
if $story_stats["Ending_MainCharacter"] == "Ending_MC_ShipSlave"
	$story_stats["GameOverGood"] = 0
	$game_portraits.lprt.hide
	$cg.erase
	$bg.erase
	if !$DEMO
		$game_map.interpreter.chcg_background_color(0,0,0,255)
		map_background_color(0,0,0,255,0)
		change_map_tag_sub("EndingShip","StartPointSlave",2,true,true,false)
	end
elsif $story_stats["Ending_MainCharacter"] == "Ending_MC_ShipTicketBought"
	$story_stats["GameOverGood"] = 1
	DataManager.write_rec_constant("RecEndLeaveNoer",1)
	$game_portraits.lprt.hide
	SndLib.bgs_play("WATER_Sea_Waves_Small_20sec_loop_stereo",90,100)
	call_msg("commonEnding:TicketBought/begin1")
	call_msg("commonEnding:TicketBought/begin2")
	GabeSDK.getAchievement("Ending20G")
	$cg.erase
	$bg.erase
	if !$DEMO
		$game_map.interpreter.chcg_background_color(0,0,0,255)
		map_background_color(0,0,0,255,0)
		change_map_tag_sub("EndingShip","StartPoint",2,true,true,false)
	end
	
elsif $story_stats["Ending_MainCharacter"] !=0 
	$game_player.force_update = true
	SceneManager.goto(Scene_Credits)
	$game_map.interpreter.chcg_background_color(0,0,0,255)
else
	$game_map.interpreter.chcg_background_color_off
	SceneManager.goto(Scene_Gameover)
end
