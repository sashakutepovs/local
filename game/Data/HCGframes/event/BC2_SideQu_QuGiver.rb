if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpLguard1X,tmpLguard1Y,tmpLguard1ID = $game_map.get_storypoint("Lguard1")
tmpLguard2X,tmpLguard2Y,tmpLguard2ID = $game_map.get_storypoint("Lguard2")
tmpRguard1X,tmpRguard1Y,tmpRguard1ID = $game_map.get_storypoint("Rguard1")
tmpRguard2X,tmpRguard2Y,tmpRguard2ID = $game_map.get_storypoint("Rguard2")
tmpArrowLtX,tmpArrowLtY,tmpArrowLtD = $game_map.get_storypoint("ArrowLt")
tmpTreeLBX,tmpTreeLBY,tmpTreeLBD = $game_map.get_storypoint("TreeLB")
tmpTreeRBX,tmpTreeRBY,tmpTreeRBD = $game_map.get_storypoint("TreeRB")
tmpArrowRtX,tmpArrowRtY,tmpArrowRtID = $game_map.get_storypoint("ArrowRt")
tmpQuGiverX,tmpQuGiverY,tmpQuGiverID = $game_map.get_storypoint("QuGiver")
tmpQcID = $game_map.get_storypoint("QuestCount")[2]
set_comp = false
set_delete = false
get_character(0).animation =  nil
if $story_stats["RecQuestBC2_SideQu"] == 0
	$story_stats["RecQuestBC2_SideQu"] = 1
	set_event_force_page(tmpQcID,4)
	
	get_character(0).animation = get_character(0).animation_stun
	call_msg("TagMapBC2_SideQu:QuGiver/Begin0") ; portrait_hide
	get_character(0).animation =  nil
	call_msg("TagMapBC2_SideQu:QuGiver/Begin0_1")
	call_msg("TagMapBC2_SideQu:QuGiver/Begin1") ; portrait_hide
	if $game_player.record_companion_name_back == "UniqueCecily"
		call_msg("TagMapBC2_SideQu:QuGiver/Begin1Cecily") ; portrait_hide
	elsif cocona_in_group?
		call_msg("TagMapBC2_SideQu:QuGiver/Begin1Cocona") ; portrait_hide
	end
	cam_center(0)
	get_character(tmpLguard1ID).npc_story_mode(true)
	get_character(tmpLguard2ID).npc_story_mode(true)
	get_character(tmpRguard1ID).npc_story_mode(true)
	get_character(tmpRguard2ID).npc_story_mode(true)
	get_character(tmpLguard1ID).move_type = 0
	get_character(tmpLguard2ID).move_type = 0
	get_character(tmpRguard1ID).move_type = 0
	get_character(tmpRguard2ID).move_type = 0
	
	
	get_character(tmpLguard1ID).opacity = 255
	get_character(tmpLguard1ID).moveto(tmpArrowLtX-2,tmpArrowLtY)
	get_character(tmpLguard1ID).jump_to(tmpArrowLtX,tmpArrowLtY) ; get_character(tmpLguard1ID).direction = 6
	SndLib.stepBush ; wait(10)
	get_character(tmpLguard2ID).opacity = 255
	get_character(tmpLguard2ID).moveto(tmpTreeLBX-3,tmpTreeLBY-1)
	get_character(tmpLguard2ID).jump_to(tmpTreeLBX-1,tmpTreeLBY-1) ; get_character(tmpLguard2ID).direction = 6
	SndLib.stepBush ; wait(10)
	get_character(tmpRguard1ID).opacity = 255
	get_character(tmpRguard1ID).moveto(tmpTreeRBX+2,tmpTreeRBY-2)
	get_character(tmpRguard1ID).jump_to(tmpTreeRBX,tmpTreeRBY-2) ; get_character(tmpRguard1ID).direction = 4
	SndLib.stepBush ; wait(10)
	get_character(tmpRguard2ID).opacity = 255
	get_character(tmpRguard2ID).moveto(tmpArrowRtX+2,tmpArrowRtY)
	get_character(tmpRguard2ID).jump_to(tmpArrowRtX,tmpArrowRtY) ; get_character(tmpRguard2ID).direction = 4
	SndLib.stepBush ; wait(10)
	$game_player.direction = 4 ; $game_player.call_balloon(8) ; wait(40)
	$game_player.direction = 2 ; $game_player.call_balloon(8) ; wait(40)
	$game_player.direction = 6 ; $game_player.call_balloon(8) ; wait(40)
	$game_player.direction = 2 ; $game_player.call_balloon(8) ; wait(40)
	SndLib.bgm_play("CB_Combat LOOP",70)
	$game_player.direction = 4
	call_msg("TagMapBC2_SideQu:QuGiver/Begin2") ; portrait_hide
	$game_player.direction = 6
	call_msg("TagMapBC2_SideQu:QuGiver/Begin3")
	call_msg("TagMapBC2_SideQu:QuGiver/Begin4")
	if $game_player.record_companion_name_back == "UniqueCecily"
		call_msg("TagMapBC2_SideQu:QuGiver/Begin4Cecily")
	elsif cocona_in_group?
		call_msg("TagMapBC2_SideQu:QuGiver/Begin4Cocona")
	end
	cam_center(0)
	call_msg("TagMapBC2_SideQu:QuGiver/Begin5") ; portrait_hide
	
	
	get_character(tmpLguard1ID).npc_story_mode(false)
	get_character(tmpLguard2ID).npc_story_mode(false)
	get_character(tmpRguard1ID).npc_story_mode(false)
	get_character(tmpRguard2ID).npc_story_mode(false)
	get_character(tmpLguard1ID).set_manual_move_type(8)
	get_character(tmpLguard2ID).set_manual_move_type(8)
	get_character(tmpRguard1ID).set_manual_move_type(8)
	get_character(tmpRguard2ID).set_manual_move_type(8)
	get_character(tmpLguard1ID).move_type = 8
	get_character(tmpLguard2ID).move_type = 8
	get_character(tmpRguard1ID).move_type = 8
	get_character(tmpRguard2ID).move_type = 8
	
###################################################################################################################
elsif [2,5].include?($story_stats["RecQuestBC2_SideQu"])
	call_msg("TagMapBC2_SideQu:QuGiver2/Begin0")
	
	until false
		$story_stats["RecQuestBC2_SideQu"] == 2 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		$story_stats["RecQuestBC2_SideQu"] >= 5 && $game_player.actor.wisdom_trait >= 10 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		$story_stats["RecQuestBC2_SideQu"] >= 5 ? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		call_msg("TagMapBC2_SideQu:QuGiver2/Begin0_opt") #[算了,發生什麼事<r=HiddenOPT0>,勸他離開<r=HiddenOPT1>,幫助他<r=HiddenOPT2>]
		case $game_temp.choice
			when -1
				break
			when 0
				break
			when 1 #發生什麼事？
				call_msg("TagMapBC2_SideQu:QuGiver2/Begin0_about0")
				get_character(0).npc_story_mode(true)
				get_character(0).jump_to(get_character(0).x,get_character(0).y)
				call_msg("TagMapBC2_SideQu:QuGiver2/Begin0_about1")
				call_msg("TagMapBC2_SideQu:QuGiver2/Begin0_about0_cecily") if $game_player.record_companion_name_back == "UniqueCecily"
				call_msg("TagMapBC2_SideQu:QuGiver2/Begin0_about0_cocona") if cocona_in_group?
				get_character(0).npc_story_mode(false)
				$story_stats["RecQuestBC2_SideQu"] = 5
			
			when 2 #勸他離開
				call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_leave0")
				call_msg("common:Lona/Decide_optD")
				portrait_hide
				if $game_temp.choice == 1
					call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_leave1")
					if $game_player.record_companion_name_back == "UniqueCecily"
						call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_leave2_end_cecily")
						$story_stats["RecQuestBC2_SideQu"] = 7
					elsif cocona_in_group?
						call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_leave2_end_cocona")
						call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_leave2_end")
						$story_stats["RecQuestBC2_SideQu"] = 6
					else
						call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_leave2_end")
						$story_stats["RecQuestBC2_SideQu"] = 6
					end
					set_delete = true
					break
				end
				
			when 3 #野盜山寨
				call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_help0")
				call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_help1")
				call_msg("common:Lona/Decide_optD")
				portrait_hide
				if $game_temp.choice == 1
					call_msg("TagMapBC2_SideQu:QuGiver3/Begin0_help2")
					$story_stats["RecQuestBC2_SideQu"] = 7
					set_delete = true
					break
				end
		end
	
	end
	$game_temp.choice = -1
	$story_stats["HiddenOPT0"] = "0"
	$story_stats["HiddenOPT1"] = "0"
end

	
	if $story_stats["RecQuestBC2_SideQu"] == 7
		set_comp=false
		if $game_player.record_companion_name_ext == nil
			set_comp=true
		elsif $game_player.record_companion_name_ext != nil
			$game_temp.choice = -1
			call_msg("commonComp:notice/ExtOverWrite")
			call_msg("common:Lona/Decide_optD")
			if $game_temp.choice ==1
				set_comp=true
			end
		else
			get_character(0).call_balloon(28,-1)
		end

		if set_comp
			portrait_hide
			call_msg("TagMapBC2_SideQu:QuGiver5/Begin0")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				$story_stats["RecQuestConvoyTarget"] = []
				tmpX = get_character(0).x
				tmpY = get_character(0).y
				get_character(0).set_this_event_companion_ext("BC2_SideQu_Qobj",false,8+$game_date.dateAmt)
				EvLib.sum("BC2_SideQu_Qobj",tmpX,tmpY)
				get_character(0).set_this_event_follower_remove
				get_character(0).delete
			chcg_background_color(0,0,0,255,-7)
			call_msg("TagMapBC2_SideQu:QuGiver5/Begin1") #board
			optain_exp(6500)
		end
	elsif $story_stats["RecQuestBC2_SideQu"] == 6
		portrait_hide
		call_msg("TagMapBC2_SideQu:QuGiver4/Begin0_end")
		portrait_hide
		get_character(0).npc_story_mode(true)
		3.times{
			get_character(0).direction = 2 ; get_character(0).move_forward_force ; $game_player.turn_toward_character(get_character(0))
			wait(70)
		}
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character(0).npc_story_mode(false)
			get_character(0).delete
		chcg_background_color(0,0,0,255,-7)
		optain_exp(6500)
	else
		get_character(0).call_balloon(28,-1)
	end

################################### add ext follower chk
eventPlayEnd