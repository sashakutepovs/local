
tmpBiosID = $game_map.get_storypoint("DualBios")[2]
tmpPlayerMatch = get_character(tmpBiosID).summon_data[:PlayerMatch]
coconaQuest = [25,26].include?($story_stats["RecQuestCocona"])
if coconaQuest
	if $story_stats["RecQuestCocona"] == 25
		change_map_tag_sub("BossMamaDual","StartPoint",8)
		return
	else
		SndLib.sys_DoorLock
		call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
		return
	end
elsif !tmpPlayerMatch
	SndLib.sys_DoorLock
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
	return
end

tmpCpX,tmpCpY,tmpCpID = $game_map.get_storypoint("CenterPillar")
tmpTsX,tmpTsY,tmpTsID=$game_map.get_storypoint("TicketSeller")
tmpRpX,tmpRpY,tmpRpID=$game_map.get_storypoint("Reporter")
tmpFireTx,tmpFireTy,tmpFireTid = $game_map.get_storypoint("FireT")
tmpFireBx,tmpFireBy,tmpFireBid = $game_map.get_storypoint("FireB")
tmpFireLx,tmpFireLy,tmpFireLid = $game_map.get_storypoint("FireL")
tmpFireRx,tmpFireRy,tmpFireRid = $game_map.get_storypoint("FireR")
tmpHowMuch = get_character(tmpBiosID).summon_data[:HowMuch]
tmpPlayedOP = get_character(tmpBiosID).summon_data[:PlayedOP]
tmpMultiple = get_character(tmpBiosID).summon_data[:Multiple]
tmpLosMultiple = get_character(tmpBiosID).summon_data[:LosMultiple]
tmpBetTarget = get_character(tmpBiosID).summon_data[:BetTarget]
tmpMatchEnd = get_character(tmpBiosID).summon_data[:MatchEnd]
tmpWinner = get_character(tmpBiosID).summon_data[:Winner]
if $game_player.record_companion_name_ext != nil
	call_msg("commonComp:notice/ExtOverWrite")
end
if $story_stats["RapeLoop"] == 0
	call_msg("common:Lona/EnterSub") #[算了,進入]
	if $game_temp.choice != 1
		get_character(0).call_balloon(28,-1)
		return eventPlayEnd
	end
end

SndLib.sys_StepChangeMap if $story_stats["RapeLoop"] == 0
get_character(0).call_balloon(0)
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	SndLib.bgs_stop
	SndLib.bgm_stop
	#$story_stats["LimitedNapSkill"] =1
	if !$game_player.get_followerID(-1).nil? || !$game_player.get_followerID(0).nil? || !$game_player.get_followerID(1).nil?
		$game_player.reset_companion_and_delete
		call_msg("common:Lona/Follower_disbanded")
	end
	
	get_character(tmpBiosID).summon_data[:PlayerScore] = 0
	get_character(tmpBiosID).summon_data[:HowMuch] = 100
	get_character(tmpBiosID).summon_data[:PlayedOP] = true
	get_character(tmpBiosID).summon_data[:PlayerMatch] = true
	get_character(tmpBiosID).summon_data[:MatchEnd] = false
	$story_stats["RecQuestNoerArenaAmt"] = $game_date.dateAmt + 2
	$story_stats["RecQuestNoerArenaList"] = 0
	call_timer(40,60)
	set_event_force_page(tmpBiosID,5)
	
	
	$game_player.moveto(tmpFireLx+1,tmpFireLy)
	$game_player.direction = 6
	get_character(tmpRpID).opacity = 255
	get_character(tmpRpID).moveto(tmpRpX,tmpRpY+2)
	
	################# TO DO gen fighter list
	tmpFighter =[
		["ArenaOrkindBro",			"Orkind",			"Batch/common_MCtorture_FunBeaten_event.rb","HCGframes/event/OrkindCave_NapGangRape.rb"],
		["ArenaTeamRBQ",			"Human",			"Batch/common_MCtorture_FunBeaten_event.rb","HCGframes/UniqueEvent_Peeon.rb"],
		["ArenaHoboDudes",			"Human",			"HCGframes/UniqueEvent_DeepThroat.rb","Batch/common_MCtorture_FunEnd_event.rb"]
	]
	tmpSummonTarget = tmpFighter.sample
	tmpSummonTarget = ["ArenaSexBeast",			"Human",			"Batch/common_MCtorture_ForcedMiscarriage.rb","HCGframes/UniqueEvent_DeepThroat.rb"] if $story_stats["RecQuestNoerArenaWinCount"] % 6 == 5
	tmpPlayerMatchOpp = tmpSummonTarget[0]
	tmpPlayerMatchRace = tmpSummonTarget[1]
	tmpPlayerMatchRaceRapeEV = tmpSummonTarget[2]
	get_character(tmpBiosID).summon_data[:PlayerMatchOpp] = tmpSummonTarget[0]
	get_character(tmpBiosID).summon_data[:PlayerMatchRace] = tmpSummonTarget[1]
	get_character(tmpBiosID).summon_data[:PlayerMatchRaceRapeBeginEV] = tmpSummonTarget[2]
	get_character(tmpBiosID).summon_data[:PlayerMatchRaceRapeEndEV] = tmpSummonTarget[3]
	get_character(tmpBiosID).summon_data[:PlayerMatchLosPlayedOP] = false
	EvLib.sum(tmpPlayerMatchOpp,tmpFireRx-1,tmpFireRy)
	
	$game_map.events.each{|event|
			next if !event[1].summon_data
			next if !event[1].summon_data[:viewers]
		event[1].opacity =  255
	}
	get_character(tmpCpID).opacity = 255
	get_character(tmpCpID).set_event_terrain_tag(3)
	get_character(tmpCpID).through = false
	get_character(tmpRpID).opacity = 255
	posi = Array.new
	posi += $game_map.region_map[8]
	until posi.empty?
		tmpGoto = posi.shift
		EvLib.sum("Hp3WoodBarrier",tmpGoto[0],tmpGoto[1])
	end
	cam_follow(tmpRpID,0)
chcg_background_color(0,0,0,255,-7)
##################### TODO make a OP
$story_stats["HiddenOPT0"] = $game_text["TagMapNoerArena:name/#{tmpPlayerMatchOpp}"]

	call_msg("TagMapNoerArena:PlayerMatch/begin")
	call_msg("TagMapNoerArena:PlayerMatch/begin_IfSlave") if $story_stats["RapeLoop"] == 1
	
	call_msg("TagMapNoerArena:NewMatch/begin2") ; portrait_hide

SndLib.bgm_play("/D/Arena-Industrial Combat LAYER12",80,100,RPG::BGM.last.pos)
SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",40,100,RPG::BGS.last.pos)
eventPlayEnd
