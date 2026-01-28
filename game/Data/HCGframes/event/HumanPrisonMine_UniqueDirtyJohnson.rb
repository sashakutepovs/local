if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
#if get_character(0).summon_data == nil
#	get_character(0).set_summon_data({:SexTradeble => true})
#elsif get_character(0).summon_data[:SexTradeble] == nil
#	get_character(0).summon_data[:SexTradeble] = true
#end


return call_msg("DEV")


get_character(0).unset_chs_sex
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]


# first time talk.
if $story_stats["RecQuDirtyJohnsonFirstTimeTalked"] == 0
	$story_stats["RecQuDirtyJohnsonFirstTimeTalked"] = 1
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstTime")
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]									,"Cancel"]
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_DigPeePoo"]				,"Blowjob"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/Lona_EH",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	get_character(0).summon_data[:suckDickAggro] = true
	case tmpPicked
		when "Blowjob"
			$cg.erase
			load_script("Data/HCGframes/event/HumanPrisonMine_UniqueDirtyJohnson_suckDick.rb")
			if get_character(0).summon_data[:suckDickAggro] == false
				portrait_off
				call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstTime_blowjob_done")
				portrait_hide
				wait(10)
				portrait_off
				whole_event_end
				return eventPlayEnd
			end
	end

	if get_character(0).summon_data[:suckDickAggro]
		call_msg("TagMapHumanPrisonCave:DirtyJohnson/FirstTime_blowjob_refuse")
		get_character(tmpDualBiosID).summon_data[:DirtyJohnsonFirstTimeAggro] = true
		get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
		get_character(0).turn_toward_character($game_player)
		get_character(0).prelock_direction = get_character(0).direction
		get_character(0).npc.launch_skill($data_arpgskills["Npc1000Sta_sap"],true)
	end
	return eventPlayEnd
end

# second time but non captured. and not merry/captured
if !($story_stats["Captured"] >= 1 || $story_stats["RapeLoop"] >= 1)
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/else_fapping")
	get_character(0).turn_toward_character($game_player)
	get_character(0).prelock_direction = get_character(0).direction
	get_character(tmpDualBiosID).summon_data[:DirtyJohnsonSecondTimeAggro] = true
	if [true,false].sample && get_character(0).npc.sta >= 100
		get_character(0).npc.launch_skill($data_arpgskills["Npc1000Sta_sap"],true)
	else
		get_character(0).npc.launch_skill($data_arpgskills["NpcMasturbationMale"],true)
	end
	return eventPlayEnd
#common started dialogs
#meet again
elsif $story_stats["RecQuDirtyJohnsonFirstTimeTalked"] == 1 && $story_stats["RecQuDirtyJohnsonMerryed"] >= 1 && !get_character(tmpDualBiosID).summon_data[:DirtyJohnsonMeetedAgain]
	get_character(tmpDualBiosID).summon_data[:DirtyJohnsonMeetedAgain] = true
	get_character(tmpDualBiosID).summon_data[:DirtyJohnsonCurrentSeasonWife] = true
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/begin_BackToCave") #you r back!!!.  you missed my penis this much?
#if he is blocked the door
elsif get_character(0).summon_data[:DoorBlockMode] == true
	#get_character(0).summon_data[:DoorBlockMode] = false
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/begin_DoorBlockMode")
else
	call_msg("TagMapHumanPrisonCave:DirtyJohnson/begin#{rand(3)}")
end

######### todo.  change this to his unique sex event
#tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
tmpPicked = nil
until ["opt_merry","Cancel","opt_sex_with",false,-1,].include?(tmpPicked)
	tmpTarList = []
	tmpTarList << [$game_text["TagMapHumanPrisonCave:DirtyJohnson/opt_who_are_you"]			,"opt_who_are_you"] if $story_stats["RecQuDirtyJohnsonMerryed"] == 0
	tmpTarList << [$game_text["TagMapHumanPrisonCave:DirtyJohnson/opt_what_happen_to_me"]	,"opt_what_happen_to_me"] if $story_stats["RecQuDirtyJohnsonMerryed"] == 0 && get_character(0).summon_data[:DoorBlockMode] == true
	tmpTarList << [$game_text["TagMapHumanPrisonCave:DirtyJohnson/opt_merry"]				,"opt_merry"] if $story_stats["RecQuDirtyJohnsonMerryed"] == 0 && get_character(tmpDualBiosID).summon_data[:DirtyJohnsonTalkedAbout] == true
	#tmpTarList << [$game_text["TagMapHumanPrisonCave:DirtyJohnson/opt_sex_with"]			,"opt_sex_with"]# if possible after merryed
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	#tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if tmp_Prostitution
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1

	case tmpPicked
		when "Barter"
			manual_barters("HumanPrisonMineMTrader")
		when "opt_who_are_you"
			call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_who_are_you_ans0")
			$story_stats["RecQuDirtyJohnson"] = 1 if $story_stats["RecQuDirtyJohnson"] == 0
			get_character(tmpDualBiosID).summon_data[:DirtyJohnsonTalkedAbout] = true
		when "opt_what_happen_to_me"
			call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_what_happen_to_me_ans0")
			$story_stats["RecQuDirtyJohnson"] = 1 if $story_stats["RecQuDirtyJohnson"] == 0
			get_character(tmpDualBiosID).summon_data[:DirtyJohnsonTalkedAbout] = true
		when "opt_merry"
			call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_merry_ans0")
			call_msg("common:Lona/Decide_optB")
			if $game_temp.choice == 1
				call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_merry_ans_yes")
				portrait_off
				chcg_background_color(0,0,0,0,7)
					portrait_hide
					get_character(tmpDualBiosID).summon_data[:DirtyJohnsonCurrentSeasonWife] = true
					$story_stats["RecQuDirtyJohnsonMerryed"] = 1
					tmpDirtyJohnsonX,tmpDirtyJohnsonY = $game_map.get_storypoint("DirtyJohnson")
					tmpStoryFucker1X,tmpStoryFucker1Y,tmpStoryFucker1ID = $game_map.get_storypoint("StoryFucker1")
					tmpStoryFucker2X,tmpStoryFucker2Y,tmpStoryFucker2ID = $game_map.get_storypoint("StoryFucker2")
					tmpStoryFucker3X,tmpStoryFucker3Y,tmpStoryFucker3ID = $game_map.get_storypoint("StoryFucker3")
					tmpStoryFucker4X,tmpStoryFucker4Y,tmpStoryFucker4ID = $game_map.get_storypoint("StoryFucker4")
					tmpStoryFucker5X,tmpStoryFucker5Y,tmpStoryFucker5ID = $game_map.get_storypoint("StoryFucker5")
					tmpStoryFucker6X,tmpStoryFucker6Y,tmpStoryFucker6ID = $game_map.get_storypoint("StoryFucker6")
					tmpStoryFucker7X,tmpStoryFucker7Y,tmpStoryFucker7ID = $game_map.get_storypoint("StoryFucker7")
					tmpStoryFucker8X,tmpStoryFucker8Y,tmpStoryFucker8ID = $game_map.get_storypoint("StoryFucker8")
					tmpStoryFucker9X,tmpStoryFucker9Y,tmpStoryFucker9ID = $game_map.get_storypoint("StoryFucker9")
					tmpStoryFucker1D = get_character(tmpStoryFucker1ID).direction
					tmpStoryFucker2D = get_character(tmpStoryFucker2ID).direction
					tmpStoryFucker3D = get_character(tmpStoryFucker3ID).direction
					tmpStoryFucker4D = get_character(tmpStoryFucker4ID).direction
					tmpStoryFucker5D = get_character(tmpStoryFucker5ID).direction
					tmpStoryFucker6D = get_character(tmpStoryFucker6ID).direction
					tmpStoryFucker7D = get_character(tmpStoryFucker7ID).direction
					tmpStoryFucker8D = get_character(tmpStoryFucker8ID).direction
					tmpStoryFucker9D = get_character(tmpStoryFucker9ID).direction
					$game_player.direction = 4
					$game_player.moveto(tmpDirtyJohnsonX,tmpDirtyJohnsonY)
					$game_player.forced_y = 16
					get_character(0).direction = 4
					get_character(0).moveto(tmpDirtyJohnsonX,tmpDirtyJohnsonY)
					get_character(0).forced_y = 0
					tmpJohnsonMoveType = get_character(0).move_type
					get_character(0).npc_story_mode(true)
					get_character(0).move_type = 0
					get_character(tmpStoryFucker1ID).moveto(tmpDirtyJohnsonX-1,tmpDirtyJohnsonY-1)
					get_character(tmpStoryFucker2ID).moveto(tmpDirtyJohnsonX-1,tmpDirtyJohnsonY+1)
					get_character(tmpStoryFucker3ID).moveto(tmpDirtyJohnsonX-1,tmpDirtyJohnsonY)
					get_character(tmpStoryFucker4ID).moveto(tmpDirtyJohnsonX-2,tmpDirtyJohnsonY)
					get_character(tmpStoryFucker5ID).moveto(tmpDirtyJohnsonX-2,tmpDirtyJohnsonY+1)
					get_character(tmpStoryFucker6ID).moveto(tmpDirtyJohnsonX,tmpDirtyJohnsonY-1)
					get_character(tmpStoryFucker1ID).turn_toward_character(get_character(0))
					get_character(tmpStoryFucker2ID).direction = 6
					get_character(tmpStoryFucker3ID).turn_toward_character(get_character(0))
					get_character(tmpStoryFucker4ID).turn_toward_character(get_character(0))
					get_character(tmpStoryFucker5ID).turn_toward_character(get_character(0))
					get_character(tmpStoryFucker6ID).turn_toward_character(get_character(0))
					call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_merry_ans_narr")
				chcg_background_color(0,0,0,255,-7)
				call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_merry_ans_progress1")
				portrait_hide
				call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_merry_ans_progress2")
				get_character(0).direction = 2 #turn_toward_character($game_player)
				call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_merry_ans_progress3")
				$cg.erase
				$game_player.actor.stat["EventMouthRace"] = "Human"
				load_script("Data/HCGframes/Grab_EventMouth_kissed.rb")
				call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_merry_ans_progress4")
				whole_event_end
				SndLib.sound_equip_armor(80,50)
				get_character(0).forced_x = get_character(0).forced_y= get_character(0).forced_z = 0
				$game_player.forced_x = $game_player.forced_y= $game_player.forced_z = 0
				get_character(0).animation = get_character(0).animation_grabber_qte($game_player)
				$game_player.animation = $game_player.animation_grabbed_qte
				wait(30)
				SndLib.sys_PaperTear
				call_msg("can we leave now?")
				call_msg("this women is fucked ")
				call_msg("i will just leave")
				portrait_off
				chcg_background_color(0,0,0,0,7)
					portrait_hide
					get_character(0).moveto(tmpDirtyJohnsonX,tmpDirtyJohnsonY)
					get_character(0).direction = 4
					get_character(0).forced_y = 0
					get_character(0).npc_story_mode(false)
					get_character(0).move_type = tmpJohnsonMoveType
					$game_player.forced_y = 0
					get_character(tmpStoryFucker1ID).moveto(tmpStoryFucker1X,tmpStoryFucker1Y)
					get_character(tmpStoryFucker2ID).moveto(tmpStoryFucker2X,tmpStoryFucker2Y)
					get_character(tmpStoryFucker3ID).moveto(tmpStoryFucker3X,tmpStoryFucker3Y)
					get_character(tmpStoryFucker4ID).moveto(tmpStoryFucker4X,tmpStoryFucker4Y)
					get_character(tmpStoryFucker5ID).moveto(tmpStoryFucker5X,tmpStoryFucker5Y)
					get_character(tmpStoryFucker6ID).moveto(tmpStoryFucker6X,tmpStoryFucker6Y)
					get_character(tmpStoryFucker7ID).moveto(tmpStoryFucker7X,tmpStoryFucker7Y)
					get_character(tmpStoryFucker8ID).moveto(tmpStoryFucker8X,tmpStoryFucker8Y)
					get_character(tmpStoryFucker9ID).moveto(tmpStoryFucker9X,tmpStoryFucker9Y)
					get_character(tmpStoryFucker1ID).direction = tmpStoryFucker1D
					get_character(tmpStoryFucker2ID).direction = tmpStoryFucker2D
					get_character(tmpStoryFucker3ID).direction = tmpStoryFucker3D
					get_character(tmpStoryFucker4ID).direction = tmpStoryFucker4D
					get_character(tmpStoryFucker5ID).direction = tmpStoryFucker5D
					get_character(tmpStoryFucker6ID).direction = tmpStoryFucker6D
					get_character(tmpStoryFucker7ID).direction = tmpStoryFucker7D
					get_character(tmpStoryFucker8ID).direction = tmpStoryFucker8D
					get_character(tmpStoryFucker9ID).direction = tmpStoryFucker9D
				chcg_background_color(0,0,0,255,-7)
			else
				call_msg("TagMapHumanPrisonCave:DirtyJohnson/opt_merry_ans_no")
				return eventPlayEnd
			end
		when "opt_sex_with"
			#get_character(0).summon_data[:SexTradeble] = false
			#$game_temp.choice == 0
			#call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
			#call_msg("commonNPC:RandomNpc/choosed")
			#$game_player.actor.sta -=1 #WhoreWorkCost
			#temp_vs1=5+rand(10) #性交易難度
			#if $game_player.actor.weak > temp_vs1
			#	$game_player.actor.mood += 10
			#	$story_stats["sex_record_whore_job"] +=1
			#	call_msg("TagMapHumanPrisonCave:DirtyJohnson/WhoreWork_win_new") if $story_stats["RecordMinerTraderWhorework"] ==0
			#	call_msg("TagMapHumanPrisonCave:DirtyJohnson/WhoreWork_win_old") if $story_stats["RecordMinerTraderWhorework"] ==1
			#	$story_stats["RecordMinerTraderWhorework"] =1
			#	play_sex_service_menu(get_character(0),0.5)
			#else
			#	$game_player.actor.mood -= 3
			#	call_msg("TagMapHumanPrisonCave:DirtyJohnson/WhoreWork_failed")
			#end
		else
			call_msg("TagMapHumanPrisonCave:DirtyJohnson/else_fapping")
			get_character(0).turn_toward_character($game_player)
			get_character(0).prelock_direction = get_character(0).direction
			get_character(0).npc.launch_skill($data_arpgskills["NpcMasturbationMale"],true)
	end
end #until
eventPlayEnd
