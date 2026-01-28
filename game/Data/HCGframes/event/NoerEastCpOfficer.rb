if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpAnyFishAlive = $game_map.npcs.any?{
|event| 
next unless event.summon_data
next unless event.summon_data[:tarFish]
next if event.npc.action_state == :death
true
}



tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("Cannon")
tmpNbX,tmpNbY,tmpNbID=$game_map.get_storypoint("Noob")
tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("KillCount")
tmpOfX,tmpOfY,tmpOfID=$game_map.get_storypoint("officer")
########################################################################################## C130第一階段完成
if $story_stats["RecQuestC130"] ==2
	optain_exp(4000*2)
	$story_stats["RecQuestC130"] = 3
	get_character(0).call_balloon(0)
	call_msg("TagMapNoerEastCp:officer/c130_done1")
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$game_player.moveto(tmpCoX-1,tmpCoY-2)
		$game_player.direction = 2
		get_character(tmpNbID).animation=nil
		get_character(tmpNbID).force_update=true
		get_character(tmpNbID).priority_type = 1
		get_character(tmpNbID).mirror = false
		get_character(tmpNbID).moveto(tmpCoX-1,tmpCoY)
		get_character(tmpNbID).direction = 6
		cam_center(0)
	chcg_background_color(0,0,0,255,-7)
	
	call_msg("TagMapNoerEastCp:officer/c130_done2")
	$game_map.reserve_summon_event("EfxKaBom3",tmpCoX,tmpCoY)
	set_event_force_page(tmpCoID,4)
	wait(3)
	SndLib.sound_MaleWarriorDed(95)
	get_character(tmpNbID).animation = get_character(tmpNbID).animation_overkill_melee_reciver
	get_character(tmpNbID).setup_cropse_graphics(2)
	get_character(tmpNbID).priority_type = 1
	wait(20)
	get_character(tmpNbID).priority_type = 0
	wait(20)
	call_msg("TagMapNoerEastCp:officer/c130_done3")
	wait(20)
	$game_player.direction = 4
	get_character(tmpOfID).direction = 6
	call_msg("TagMapNoerEastCp:officer/c130_done4")
	get_character(tmpOfID).direction = 2
	get_character(tmpNbID).force_update=false
	GabeSDK.getAchievement("RecQuestC130_2")


########################################################################################## 其他
else
	
		opt_moveCannon = $story_stats["RecQuestLisa"] == 6 && $game_player.record_companion_name_ext == "CompExtUniqueLisa" && $story_stats["UniqueCharUniqueLisa"] != -1 && !tmpAnyFishAlive
		opt_whore = $game_player.actor.stat["Prostitute"] ==1 && !opt_moveCannon
		opt_work = [0,1].include?($story_stats["RecQuestC130"]) && !opt_moveCannon
		opt_replayCannon = $story_stats["RecQuestC130"] >= 4 && !tmpAnyFishAlive && !opt_moveCannon#等LISA線完成後寫入定職
		opt_about = $story_stats["RecQuestC130"] >= 2 && !opt_moveCannon
		opt_aboutCannon = $story_stats["RecQuestC130"] >= 2 && !opt_moveCannon
		#Lisa C130 Quest
		tmpQ1 = $story_stats["RecQuestC130"] == 3
		tmpQ2 = [4].include?($story_stats["RecQuestLisa"])
		tmpQ3 = $game_player.record_companion_name_ext == "CompExtUniqueLisa"
		tmpQ4 = $game_party.item_number("ItemQuestVespeneMineral") >= 10
		tmpQ5 = $story_stats["UniqueCharUniqueLisa"] != -1
		
		opt_repair = tmpQ1 && tmpQ2 && tmpQ3 && tmpQ4 && tmpQ5 && !opt_moveCannon
		notYetSouthFL = $story_stats["RecQuestLisa"] < 7
	
	

		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["TagMapNoerEastCp:officer/opt_nope"]			,"opt_nope"]
		tmpQuestList << [$game_text["TagMapNoerEastCp:officer/opt_moveCannon"]		,"opt_moveCannon"] if opt_moveCannon && notYetSouthFL
		tmpQuestList << [$game_text["TagMapNoerEastCp:officer/opt_whore"]			,"opt_whore"] if opt_whore
		tmpQuestList << [$game_text["TagMapNoerEastCp:officer/opt_work"]			,"opt_work"] if opt_work
		tmpQuestList << [$game_text["TagMapNoerEastCp:officer/opt_replayCannon"]	,"opt_replayCannon"] if opt_replayCannon && notYetSouthFL
		tmpQuestList << [$game_text["TagMapNoerEastCp:officer/opt_about"]			,"opt_about"] if opt_about && notYetSouthFL
		tmpQuestList << [$game_text["TagMapNoerEastCp:officer/opt_aboutCannon"]		,"opt_aboutCannon"] if opt_aboutCannon && notYetSouthFL
		tmpQuestList << [$game_text["TagMapNoerEastCp:officer/opt_repair"]			,"opt_repair"] if opt_repair && notYetSouthFL
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
			p cmd_text
		end
		
		if $story_stats["RecQuestC130"] >= 2
			call_msg("TagMapNoerEastCp:officer/start_opt_known",0,2,0)
		else
			call_msg("TagMapNoerEastCp:officer/start_opt",0,2,0)
		end
		call_msg("\\optB[#{cmd_text}]")
		
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
		
	case tmpPicked
		when "opt_whore"
			call_msg("TagMapNoerEastCp:officer/opt_whore_Lona")
			
		when "opt_work"
			get_character(0).call_balloon(0)
			call_msg("TagMapNoerEastCp:officer/opt_cannon")
			get_character(tmpCoID).call_balloon(19,-1)
			set_event_force_page(tmpCurID,4)
			
		when "opt_replayCannon"
			call_msg("TagMapNoerEastCp:officer/opt_cannon_replay")
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindCommonerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindCommonerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindSpearC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindSpearC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindSpearC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindCommonerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindFatC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindFatC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
			posi1=$game_map.region_map[14].sample
			$game_map.reserve_summon_event("FishkindChargerC130",posi1[0],posi1[1],-1)
		
		when "opt_about"
			call_msg("TagMapNoerEastCp:officer/opt_monster")
		
		when "opt_aboutCannon"
			call_msg("TagMapNoerEastCp:officer/opt_FireControlSys")
			
		when "opt_repair"
			get_character(0).call_balloon(0)
			$story_stats["RecQuestC130"] = 4
			$story_stats["RecQuestLisa"] = 5
			$story_stats["RecQuestLisaAmt"]= 6 + $game_date.dateAmt
			call_msg("CompLisa:Lisa/QuestLisa_3_CP0")
			portrait_hide
				chcg_background_color(0,0,0,0,7)
				tmpLisa = $game_player.get_companion_id("ext")
				get_character(tmpLisa).moveto(tmpCoX-1,tmpCoY)
				get_character(tmpLisa).direction = 6
				$game_player.moveto(tmpCoX-1,tmpCoY-1)
				$game_player.direction = 2
				chcg_background_color(0,0,0,255,-7)
			
			call_msg("CompLisa:Lisa/QuestLisa_3_CP1")
			optain_lose_item("ItemQuestVespeneMineral",10)
			call_msg("CompLisa:Lisa/QuestLisa_3_CP2")
			portrait_hide
				chcg_background_color(0,0,0,0,7)
				set_event_force_page(tmpCoID,2)
				get_character(tmpLisa).moveto(tmpCoX-1,tmpCoY+1)
				get_character(tmpLisa).direction = 8
				wait(60)
				SndLib.WoodenBuild
				wait(60)
				SndLib.WoodenBuild
				wait(60)
				SndLib.WoodenBuild
				wait(60)
				chcg_background_color(0,0,0,255,-7)
			call_msg("CompLisa:Lisa/QuestLisa_3_CP3_end")
				get_character(tmpOfID).npc_story_mode(true)
				portrait_off
				get_character(tmpOfID).move_goto_xy(get_character(tmpLisa).x-1,get_character(tmpLisa).y)
				wait(30)
				get_character(tmpOfID).move_goto_xy(get_character(tmpLisa).x-1,get_character(tmpLisa).y)
				wait(30)
				get_character(tmpOfID).move_goto_xy(get_character(tmpLisa).x-1,get_character(tmpLisa).y)
				wait(30)
				get_character(tmpOfID).move_goto_xy(get_character(tmpLisa).x-1,get_character(tmpLisa).y)
				wait(30)
				get_character(tmpOfID).direction = 6
				get_character(tmpOfID).animation = get_character(tmpOfID).animation_atk_sh
				get_character(tmpLisa).direction = 4
				wait(30)
				get_character(tmpOfID).npc_story_mode(false)
			call_msg("CompLisa:Lisa/QuestLisa_3_CP3_end1")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(tmpOfID).moveto(tmpOfX,tmpOfY)
				get_character(tmpOfID).direction = 2
			chcg_background_color(0,0,0,255,-7)
			get_character(tmpLisa).move_type = 1
			get_character(tmpLisa).trigger = -1
			get_character(tmpLisa).move_frequency = 0
			get_character(tmpLisa).set_this_companion_disband(false)
			optain_exp(8000*2)
			GabeSDK.getAchievement("RecQuestLisa_5")
			
			
		when "opt_moveCannon"
			$story_stats["RecQuestLisa"] = 7
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(0).moveto(tmpOfX,tmpOfY)
				get_character(0).direction = 2
				get_character($game_player.get_followerID(-1)).moveto(tmpOfX,tmpOfY+1)
				get_character($game_player.get_followerID(-1)).direction = 8
				get_character($game_player.get_followerID(-1)).forced_x = 16
				get_character($game_player.get_followerID(-1)).npc_story_mode(true)
				get_character($game_player.get_followerID(-1)).move_type = 0
				$game_player.moveto(tmpOfX-1,tmpOfY+1)
				$game_player.direction = 8
				$game_player.forced_x = 16
			chcg_background_color(0,0,0,255,-7)
			call_msg("CompLisa:Lisa7/begin0") #TalkWithOfficer
			call_msg("CompLisa:Lisa7/begin1") ; portrait_hide
			get_character($game_player.get_followerID(-1)).direction = 4
			$game_player.direction = 6
			call_msg("CompLisa:Lisa7/begin2") ; portrait_hide
			get_character($game_player.get_followerID(-1)).direction = 8
			$game_player.direction = 8
			call_msg("CompLisa:Lisa7/begin3") ; portrait_hide
			get_character($game_player.get_followerID(-1)).forced_x = 0
			get_character($game_player.get_followerID(-1)).direction = 6 ; get_character($game_player.get_followerID(-1)).move_forward_force ; wait(35) ; $game_player.turn_toward_character(get_character($game_player.get_followerID(-1)))
			get_character($game_player.get_followerID(-1)).direction = 6 ; get_character($game_player.get_followerID(-1)).move_forward_force ; wait(35) ; $game_player.turn_toward_character(get_character($game_player.get_followerID(-1)))
			get_character($game_player.get_followerID(-1)).direction = 2 ; get_character($game_player.get_followerID(-1)).move_forward_force ; wait(35) ; $game_player.turn_toward_character(get_character($game_player.get_followerID(-1)))
			get_character($game_player.get_followerID(-1)).direction = 6
			#todo remove fire control system
			3.times{
				get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_atk_sh
				wait(3)
				SndLib.sound_combat_sword_hit_sword
				wait(40)
			}
			set_event_force_page(tmpCoID,6)
			get_character(tmpCoID).set_manual_trigger(-1)
			get_character($game_player.get_followerID(-1)).direction = 4
			$game_player.direction = 6
			call_msg("CompLisa:Lisa7/begin4") ; portrait_hide #todo remove fire control system2
			cam_center(0)
			$game_player.forced_x = 0
			$game_player.direction = 6 ; $game_player.move_forward_force ; wait(15)
			$game_player.direction = 6 ; $game_player.move_forward_force ; wait(15)
			get_character($game_player.get_followerID(-1)).direction = 8
			$game_player.direction = 6 ; $game_player.move_forward_force ; wait(15)
			$game_player.direction = 2
			get_character($game_player.get_followerID(-1)).direction = 8
			get_character($game_player.get_followerID(-1)).animation = get_character($game_player.get_followerID(-1)).animation_atk_sh
			wait(10)
			SndLib.sound_equip_armor(100)
			optain_item("ItemQuestC130Part",1) ########################################### ItemQuestC130Part
			wait(10)
			call_msg("CompLisa:Lisa7/begin5") ; portrait_hide #before leave
			get_character(0).direction = 6
			get_character($game_player.get_followerID(-1)).direction = 4
			$game_player.direction = 4
			call_msg("CompLisa:Lisa7/begin6") ; portrait_hide #before leave
			get_character($game_player.get_followerID(-1)).direction = 8
			$game_player.direction = 2
			call_msg("CompLisa:Lisa7/begin7") ; portrait_hide #before leave
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(0).direction = 2
				get_character($game_player.get_followerID(-1)).npc_story_mode(false)
			chcg_background_color(0,0,0,255,-7)
			$story_stats["HiddenOPT1"] = ($game_player.record_companion_ext_date-$game_date.dateAmt)/2
			call_msg("CompLisa:Lisa7/begin5_board") ; portrait_hide #before leave
			$story_stats["HiddenOPT1"] = "0"
			optain_exp(5000)
			wait(30)
			optain_morality(1)
	end
end



eventPlayEnd



#Lisa C130 Quest
tmpQ1 = $story_stats["RecQuestC130"] == 3
tmpQ2 = [4].include?($story_stats["RecQuestLisa"])
tmpQ3 = $game_player.record_companion_name_ext == "CompExtUniqueLisa"
tmpQ4 = $game_party.item_number("ItemQuestVespeneMineral") >= 10
tmpQ5 = $story_stats["UniqueCharUniqueLisa"] != -1
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3 && tmpQ4 && tmpQ5
#Lisa SouthFL Quest
tmpQ2 = $story_stats["RecQuestLisa"] == 6
return get_character(0).call_balloon(28,-1) if tmpQ2 && tmpQ3 && tmpQ5
