if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
elsif $game_player.actor.stat["SlaveBrand"] == 1
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapNoerArena:FoodSeller/SlaveQmsg#{rand(3)}",get_character(0).id)
	return
end


tmpBiosID = $game_map.get_storypoint("DualBios")[2]
tmpG1X,tmpG1Y,tmpG1ID=$game_map.get_storypoint("Gate1")
tmpG2X,tmpG2Y,tmpG2ID=$game_map.get_storypoint("Gate2")
tmpEnterArenaX,tmpEnterArenaY,tmpEnterArenaID=$game_map.get_storypoint("EnterArena")
tmpTicketSellerX,tmpTicketSellerY,tmpTicketSellerID=$game_map.get_storypoint("TicketSeller")
tmpHowMuch = get_character(tmpBiosID).summon_data[:HowMuch]
tmpPlayedOP = get_character(tmpBiosID).summon_data[:PlayedOP]
tmpMultiple = get_character(tmpBiosID).summon_data[:Multiple]
tmpLosMultiple = get_character(tmpBiosID).summon_data[:LosMultiple]
tmpBetTarget = get_character(tmpBiosID).summon_data[:BetTarget]
tmpMatchEnd = get_character(tmpBiosID).summon_data[:MatchEnd]
tmpWinner = get_character(tmpBiosID).summon_data[:Winner]
tmpPtPayed = get_character(tmpBiosID).summon_data[:PtPayed]
tmpPlayerMatch = get_character(tmpBiosID).summon_data[:PlayerMatch]
tmpPlayerScore = get_character(tmpBiosID).summon_data[:PlayerScore]
open_storage = false


get_character(0).call_balloon(0)
##########################################################################################  MamaDual unique dialog
if $story_stats["RecQuestCocona"] == 26
	call_msg("TagMapNoerArena:TicketSeller/MatchEnd")
elsif $story_stats["RecQuestCocona"] == 25
	call_msg("CompCocona:VandorMan/RecQuestCocona25")
	tmpID=$game_map.get_storypoint("EnterArena")[2]
	get_character(tmpID).call_balloon(28,-1)
########################################################################################## Match ISNT END
elsif tmpPlayedOP == true && tmpHowMuch >= 1 && tmpMatchEnd == false
	call_msg("TagMapNoerArena:TicketSeller/MatchStill")
	get_character(tmpG1ID).call_balloon(28,-1)
	get_character(tmpG2ID).call_balloon(28,-1)

########################################################################################## First time get reward
elsif tmpPlayedOP == true && tmpHowMuch >= 1 && tmpMatchEnd == true && $story_stats["RecQuestNoerArena"] == 1
	$story_stats["RecQuestNoerArena"] = 2
	tmpTgX,tmpTgY,tmpTgID=$game_map.get_storypoint("TricketGiver")
	tmpStX,tmpStY,tmpStID=$game_map.get_storypoint("StartPoint")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).moveto(tmpTicketSellerX,tmpTicketSellerY)
		get_character(0).direction = 2
		$game_player.moveto(tmpTicketSellerX,tmpTicketSellerY+2)
		$game_player.direction = 8
		get_character(tmpTgID).moveto(tmpStX,tmpStY-1)
		get_character(tmpTgID).force_update = true
		get_character(tmpTgID).direction = 8
		get_character(tmpTgID).opacity = 255
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerArena:firstTime/TakeReward1") ; portrait_hide
	5.times{
		get_character(tmpTgID).move_forward_force
		wait(35)
	}
	call_msg("TagMapNoerArena:firstTime/TakeReward2") ; portrait_hide
	$game_player.direction = 2
	tmpBluff = $game_player.actor.wisdom_trait >= 12
	tmpBluff ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
	call_msg("TagMapNoerArena:firstTime/TakeReward3") #[給他,搶劫呀！<r=HiddenOPT1>]
	$story_stats["HiddenOPT1"] = "0"
	if $game_temp.choice == 0
		call_msg("TagMapNoerArena:firstTime/TakeReward4_give0") ; portrait_hide
		optain_lose_item($data_items[123],1) #BetTricket
		get_character(tmpTgID).animation = get_character(tmpTgID).animation_atk_mh
		SndLib.sound_punch_hit(100)
		lona_mood "p5crit_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.force_stun("Stun1")
		call_msg("TagMapNoerArena:firstTime/TakeReward4_give1") ; portrait_hide
		$game_player.actor.mood -=50
	else
		call_msg("TagMapNoerArena:firstTime/TakeReward4_guard0") ; portrait_hide
		get_character(tmpTgID).direction = 2
		call_msg("TagMapNoerArena:firstTime/TakeReward4_guard1") ; portrait_hide
		get_character(tmpTgID).direction = 8
		call_msg("TagMapNoerArena:firstTime/TakeReward4_guard2") ; portrait_hide
		cam_center(0)
		get_character(tmpTgID).direction = 2
		5.times{
			get_character(tmpTgID).move_forward_force
			wait(35)
		}
		call_msg("TagMapNoerArena:firstTime/TakeReward4_guard3") ; portrait_hide
		$game_player.direction = 8
		call_msg("TagMapNoerArena:TicketSeller/MatchReward0")
		tmpReward = (tmpHowMuch*tmpMultiple).to_i
		optain_lose_item($data_items[123],1) #BetTricket
		optain_item_chain(cur_vol = tmpReward ,good=["ItemCoin1","ItemCoin2","ItemCoin3"],summon=false)
		call_msg("TagMapNoerArena:TicketSeller/MatchReward1")
		$game_player.actor.mood += 50
	end
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpTgID).delete
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpBiosID).summon_data[:HowMuch] = 0
	get_character(tmpBiosID).summon_data[:PlayedOP] = false
	get_character(tmpBiosID).summon_data[:Multiple] = 0
	get_character(tmpBiosID).summon_data[:BetTarget] = nil
	get_character(tmpBiosID).summon_data[:MatchEnd] = true

########################################################################################## 玩家下場 勝利 領賞
elsif tmpPlayerScore && tmpPlayerScore > 200
	tmpReward = get_character(tmpBiosID).summon_data[:PlayerScore]
	call_msg("TagMapNoerArena:TicketSeller/MatchReward0")
	optain_item_chain(cur_vol = tmpReward ,good=["ItemCoin1","ItemCoin2","ItemCoin3"],summon=false)
	call_msg("TagMapNoerArena:TicketSeller/MatchReward1")
	get_character(tmpBiosID).summon_data[:PlayerScore] = 0
	
	
	
elsif tmpMatchEnd == true && tmpPlayedOP == false && tmpPlayerMatch == true
	call_msg("TagMapNoerArena:TicketSeller/PlayerMatchStart")
	get_character(tmpEnterArenaID).call_balloon(28,-1)
	
	########################################################################################### 玩家下場 結束
elsif tmpMatchEnd == true && tmpPlayedOP == true && tmpPlayerMatch == true
	call_msg("TagMapNoerArena:TicketSeller/MatchEnd")
	
########################################################################################## Watch Match End get reward or pay bet
elsif tmpPlayedOP == true && tmpHowMuch >= 1 && tmpMatchEnd == true && (tmpWinner == tmpBetTarget) && tmpWinner != "Draw"
	call_msg("TagMapNoerArena:TicketSeller/MatchReward0")
	tmpReward = (tmpHowMuch*tmpMultiple).to_i
	optain_lose_item($data_items[123],1) #BetTricket
	optain_item_chain(cur_vol = tmpReward ,good=["ItemCoin1","ItemCoin2","ItemCoin3"],summon=false)
	call_msg("TagMapNoerArena:TicketSeller/MatchReward1")
	get_character(tmpBiosID).summon_data[:HowMuch] = 0
	get_character(tmpBiosID).summon_data[:PlayedOP] = false
	get_character(tmpBiosID).summon_data[:Multiple] = 0
	get_character(tmpBiosID).summon_data[:BetTarget] = nil
	get_character(tmpBiosID).summon_data[:MatchEnd] = true
	$game_player.actor.mood += 50
	
##########################################################################################  Watch Match End and its a draw
elsif tmpPlayedOP == true && tmpHowMuch >= 1 && tmpMatchEnd == true && tmpWinner == "Draw"
	#get_character(tmpBiosID).summon_data[:PtPayed] = (tmpHowMuch*tmpMultiple).to_i if tmpPtPayed == 0
	#$story_stats["HiddenOPT4"] = get_character(tmpBiosID).summon_data[:PtPayed]
	
	call_msg("TagMapNoerArena:TicketSeller/ItsDraw")
	get_character(tmpBiosID).summon_data[:HowMuch] = 0
	get_character(tmpBiosID).summon_data[:PlayedOP] = false
	get_character(tmpBiosID).summon_data[:Multiple] = 0
	get_character(tmpBiosID).summon_data[:BetTarget] = nil
	get_character(tmpBiosID).summon_data[:MatchEnd] = true
	optain_lose_item($data_items[123],1) #BetTricket
	
	#call_msg("TagMapNoerArena:TicketSeller/WannaLeave")
	#open_storage = true

########################################################################################## Watch Match End  Player Lost
elsif tmpPlayedOP == true && tmpHowMuch >= 1 && tmpMatchEnd == true && (tmpWinner != tmpBetTarget) && tmpWinner != "Draw"
	get_character(tmpBiosID).summon_data[:PtPayed] = (tmpHowMuch*tmpLosMultiple).to_i if tmpPtPayed == 0
	$story_stats["HiddenOPT4"] = get_character(tmpBiosID).summon_data[:PtPayed]
	call_msg("TagMapNoerArena:TicketSeller/YouLose")
	call_msg("TagMapNoerArena:TicketSeller/WannaLeave")
	open_storage = true


############################################# ############################################# Match Is Gonna Started
elsif tmpPlayedOP == false && tmpHowMuch >= 1 && tmpMatchEnd == false
	get_character(tmpBiosID).summon_data[:PtPayed] = (tmpHowMuch*tmpLosMultiple).to_i if tmpPtPayed == 0
	$story_stats["HiddenOPT0"] = get_character(tmpBiosID).summon_data[:LosMultiple]
	$story_stats["HiddenOPT1"] = $game_text["TagMapNoerArena:name/#{tmpBetTarget}"]
	$story_stats["HiddenOPT2"] = tmpHowMuch
	$story_stats["HiddenOPT3"] = tmpMultiple
	$story_stats["HiddenOPT4"] = get_character(tmpBiosID).summon_data[:PtPayed]
	call_msg("TagMapNoerArena:TicketSeller/Started")
	call_msg("TagMapNoerArena:TicketSeller/WannaLeave")
	open_storage = true
	
############################################# ############################################# Match End comback tomorrow
elsif $story_stats["RecQuestNoerArenaAmt"] > $game_date.dateAmt
	call_msg("TagMapNoerArena:TicketSeller/MatchEnd")
	
########################################################################################## Basic OPT
else
	$game_temp.choice = -1

	cecilyShow_cond = $story_stats["UniqueCharUniqueGrayRat"] == -1 && $story_stats["UniqueCharUniqueCecily"] == -1 && $story_stats["RecQuestMilo"] >= 12 && !get_character(tmpBiosID).summon_data[:CecilyShow_Gang_cancel]
	cecilyShow_cond = cecilyShow_cond && $game_date.dateAmt % 7 == 0
	tmpSpecEventDialogPlayed = get_character(tmpBiosID).summon_data[:SpecEventDialogPlayed]

	#cecilyShow_cond = true  #debug and test

	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]						,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/About"]						,"opt_about"]
	tmpTarList << [$game_text["TagMapNoerArena:TicketSeller/BasicOpt_bet"]		,"Bet"] if !cecilyShow_cond && !tmpSpecEventDialogPlayed
	tmpTarList << [$game_text["commonNPC:commonNPC/Work"]						,"Work"] if !cecilyShow_cond
	tmpTarList << [$game_text["TagMapNoerArena:TicketSeller/CecilyShow_Gang"]	,"CecilyShow_Gang"] if cecilyShow_cond
	#tmpTarList << ["asdasdasdasd"												,"BattleTest"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	if !cecilyShow_cond && !tmpSpecEventDialogPlayed
		call_msg("TagMapNoerArena:TicketSeller/BasicOpt",0,2,0)
	elsif get_character(tmpBiosID).summon_data[:SpecEvent] && !get_character(tmpBiosID).summon_data[:PlayedOP]
		call_msg("TagMapNoerArena:TicketSeller/CecilyShow_Gang_begin_talked")
	elsif get_character(tmpBiosID).summon_data[:SpecEvent] && get_character(tmpBiosID).summon_data[:PlayedOP]
		call_msg("TagMapNoerArena:TicketSeller/CecilyShow_Gang_end")
	else
		call_msg("TagMapNoerArena:TicketSeller/CecilyShow_Gang_begin#{rand(3)}",0,2,0)
	end
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	case tmpPicked
		when "opt_about"
			call_msg("TagMapNoerArena:TicketSeller/BasicOpt_about0")
		when "CecilyShow_Gang"
			#call_msg("TagMapNoerArena:TicketSeller/CecilyShow_Gang_begin#{rand(3)}")
			call_msg("TagMapNoerArena:TicketSeller/CecilyShow_Gang_About1#{talk_persona}") #特別演出？
			call_msg("TagMapNoerArena:TicketSeller/CecilyShow_Gang_About2")
			call_msg("common:Lona/Decide_optB") #[算了,決定]
			if $game_temp.choice == 1
				call_msg("TagMapNoerArena:TicketSeller/CecilyShow_Gang_agree")
				$story_stats["RecQuestNoerArenaAmt"] = $game_date.dateAmt + 2
				tmpFighter =[
					["ArenaWildDog",		1.2,	6],
					["ArenaSwine",			1.25,	5],
					["ArenaApes",			2.5,	1.5],
					["ArenaOrkindBro",		2.5,	1.5],
					["ArenaHoboDudes",		1.9,	4],
				]
				get_character(tmpBiosID).summon_data[:SpecEvent] = "CecilyShow_Gang"
				get_character(tmpBiosID).summon_data[:SpecEventUnit] = tmpFighter.sample[0]
				get_character(tmpG1ID).call_balloon(28,-1)
				get_character(tmpG2ID).call_balloon(28,-1)
			else
				get_character(tmpBiosID).summon_data[:CecilyShow_Gang_cancel] = true
				call_msg("TagMapNoerArena:TicketSeller/CecilyShow_Gang_cancel")
			end
		when "Bet"
			if get_character(tmpBiosID).summon_data[:FighterPick] == nil		#################### setup
				tmpFighter =[
					["ArenaWildDog",		1.2,	6],
					["ArenaSwine",			1.25,	5],
					["ArenaApes",			2.5,	1.5],
					["ArenaEastColossus",	1.4,	6],
					["ArenaFemdom",			1.2,	7],
					["ArenaOrkindBro",		2.5,	1.5],
					["ArenaDeepTerror",		1.6,	5],
					["ArenaFailedAdv",		2.3,	3],
					["ArenaTeamRBQ",		3,		1],
					["ArenaHoboDudes",		1.9,	4]
				]
				tmpFighter << ["ArenaSexBeast",		1.1,	10] if rand(100) > 80
				if $game_date.dateAmt >= $story_stats["RecQuestNoerArenaListAmt"] || $story_stats["RecQuestNoerArenaList"] == 0
					$story_stats["RecQuestNoerArenaListAmt"] = 2+$game_date.dateAmt
					get_character(tmpBiosID).summon_data[:FighterPick] = []
					4.times{
						tmpPick = tmpFighter.sample
						get_character(tmpBiosID).summon_data[:FighterPick] << tmpPick
						tmpFighter.delete(tmpPick)
					}
					$story_stats["RecQuestNoerArenaList"] = get_character(tmpBiosID).summon_data[:FighterPick]
				else
					get_character(tmpBiosID).summon_data[:FighterPick] = $story_stats["RecQuestNoerArenaList"]
				end
			end
			tmpMin = 200
			tmpMix = 3000
			
			tmpFighterPick = get_character(tmpBiosID).summon_data[:FighterPick]
			$story_stats["HiddenOPT0"] = [$game_text["TagMapNoerArena:name/#{tmpFighterPick[0][0]}"],tmpFighterPick[0][1],tmpFighterPick[0][2]]
			$story_stats["HiddenOPT1"] = [$game_text["TagMapNoerArena:name/#{tmpFighterPick[1][0]}"],tmpFighterPick[1][1],tmpFighterPick[1][2]]
			$story_stats["HiddenOPT2"] = [$game_text["TagMapNoerArena:name/#{tmpFighterPick[2][0]}"],tmpFighterPick[2][1],tmpFighterPick[2][2]]
			$story_stats["HiddenOPT3"] = [$game_text["TagMapNoerArena:name/#{tmpFighterPick[3][0]}"],tmpFighterPick[3][1],tmpFighterPick[3][2]]
			call_msg("TagMapNoerArena:TicketSeller/BasicOpt_FighterList")
			
			call_msg("TagMapNoerArena:TicketSeller/BasicOpt_bet0")
			tmpGotoTar = ""
			tmpTarList = []
			tmpTarList << [$game_text["TagMapNoerArena:name/#{tmpFighterPick[0][0]}"]				,tmpFighterPick[0][0],tmpFighterPick[0][1],tmpFighterPick[0][2]]
			tmpTarList << [$game_text["TagMapNoerArena:name/#{tmpFighterPick[1][0]}"]				,tmpFighterPick[1][0],tmpFighterPick[1][1],tmpFighterPick[1][2]]
			tmpTarList << [$game_text["TagMapNoerArena:name/#{tmpFighterPick[2][0]}"]				,tmpFighterPick[2][0],tmpFighterPick[2][1],tmpFighterPick[2][2]]
			tmpTarList << [$game_text["TagMapNoerArena:name/#{tmpFighterPick[3][0]}"]				,tmpFighterPick[3][0],tmpFighterPick[3][1],tmpFighterPick[3][2]]
			cmd_sheet = tmpTarList
			cmd_text =""
			for i in 0...cmd_sheet.length
				cmd_text.concat(cmd_sheet[i].first+",")
			end
			call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
			call_msg("\\optB[#{cmd_text}]")
			if $game_temp.choice == -1
				tmpPicked = false
				return eventPlayEnd
			else				
				tmpPicked = cmd_sheet[$game_temp.choice][1]
				tmpMulti = cmd_sheet[$game_temp.choice][2]
				tmpLosMultiple = cmd_sheet[$game_temp.choice][3]
				$game_temp.choice = -1
				$story_stats["HiddenOPT1"] = tmpMin
				$story_stats["HiddenOPT2"] = tmpMix
				call_msg("TagMapNoerArena:TicketSeller/BasicOpt_bet1")
			end
			$game_boxes.box(System_Settings::STORAGE_TEMP).clear
			SceneManager.goto(Scene_ItemStorage)
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
			wait(2)
			tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
			$game_boxes.box(System_Settings::STORAGE_TEMP).clear
			if tmpPP > tmpMin
				tmpPP = tmpMix if tmpPP > tmpMix
				get_character(tmpBiosID).summon_data[:BetTarget]		= tmpPicked
				get_character(tmpBiosID).summon_data[:HowMuch]			= tmpPP
				get_character(tmpBiosID).summon_data[:Multiple]			= tmpMulti
				get_character(tmpBiosID).summon_data[:LosMultiple]		= tmpLosMultiple
				get_character(tmpBiosID).summon_data[:MatchEnd]			= false
				$story_stats["HiddenOPT1"] = $game_text["TagMapNoerArena:name/#{tmpPicked}"]
				$story_stats["HiddenOPT2"] = tmpPP
				$story_stats["HiddenOPT3"] = tmpMulti
				$story_stats["HiddenOPT4"] = tmpLosMultiple
				get_character(tmpG1ID).call_balloon(28,-1)
				get_character(tmpG2ID).call_balloon(28,-1)
				call_msg("TagMapNoerArena:TicketSeller/BasicOpt_bet2")
				optain_item($data_items[123]) #BetTricket
			end
			$game_boxes.box(System_Settings::STORAGE_TEMP).clear
			
		when "Work"
			call_msg("TagMapNoerArena:TicketSeller/BasicOpt_work0")
			call_msg("TagMapNoerArena:TicketSeller/BasicOpt_work1")
			call_msg("TagMapNoerArena:TicketSeller/BasicOpt_work2")
			if $game_player.with_companion
				call_msg("TagMapNoerArena:notice/DisbandWarning")
			end
			call_msg("common:Lona/Decide_optB") #[算了,決定]
			if $game_temp.choice == 1
				call_msg("TagMapNoerArena:TicketSeller/BasicOpt_workAccept")
				get_character(tmpBiosID).summon_data[:PlayedOP] = false
				get_character(tmpBiosID).summon_data[:PlayerMatch] = true
				get_character(tmpBiosID).summon_data[:MatchEnd] = true
				get_character(tmpBiosID).summon_data[:PlayerScore] = 0
				get_character(tmpBiosID).summon_data[:HowMuch] = 100
				get_character(tmpEnterArenaID).call_balloon(28,-1)
			end
		when "BattleTest"
				$story_stats["record_killcount"].each{|name,count|
					p name
				}
	end #case
	
	
end

if open_storage
	$game_boxes.box(System_Settings::STORAGE_TEMP).clear
	SceneManager.goto(Scene_ItemStorage)
	SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
	wait(2)
	tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
	$game_boxes.box(System_Settings::STORAGE_TEMP).clear
	if tmpPP >0
		call_msg("TagMapNoerArena:TicketSeller/StartedPayIdle")
		get_character(tmpBiosID).summon_data[:PtPayed] -= tmpPP
	end
	if get_character(tmpBiosID).summon_data[:PtPayed] <= 0 && tmpPP >0
		call_msg("TagMapNoerArena:TicketSeller/StartedEnough")
		$story_stats["RecQuestNoerArenaAmt"] = $game_date.dateAmt + 2
		get_character(tmpBiosID).summon_data[:HowMuch] = 0
		get_character(tmpBiosID).summon_data[:PlayedOP] = false
		get_character(tmpBiosID).summon_data[:Multiple] = 0
		get_character(tmpBiosID).summon_data[:LosMultiple] = 0
		get_character(tmpBiosID).summon_data[:BetTarget] = nil
		get_character(tmpBiosID).summon_data[:MatchEnd] = true
		get_character(tmpG1ID).call_balloon(0)
		get_character(tmpG2ID).call_balloon(0)
		$story_stats["RecQuestNoerArena"] = 2 if $story_stats["RecQuestNoerArena"] == 1
		optain_lose_item($data_items[123],1) #BetTricket
	elsif tmpPP >0
		$story_stats["HiddenOPT4"] = get_character(tmpBiosID).summon_data[:PtPayed]
		call_msg("TagMapNoerArena:TicketSeller/StartedNotEnough")
		get_character(tmpG1ID).call_balloon(28,-1) if !tmpMatchEnd
		get_character(tmpG2ID).call_balloon(28,-1) if !tmpMatchEnd
	end
end


$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT3"] = "0"
$story_stats["HiddenOPT4"] = "0"
eventPlayEnd




