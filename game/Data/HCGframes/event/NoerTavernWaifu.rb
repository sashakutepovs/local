if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
get_character(0).animation = nil
############################################################## 可可娜任務串 ##############################################################
if $story_stats["RecQuestCocona"] == 3 && $story_stats["UniqueCharUniqueCocona"] != -1
	get_character(0).call_balloon(0)
	$story_stats["RecQuestCocona"] = 4
	
	call_msg("CompCocona:Waifu/RecQuestCocona_2_1")
	call_msg("CompCocona:Waifu/RecQuestCocona_2_2")
	chcg_background_color(0,0,0,0,7)
	call_msg("CompCocona:Waifu/RecQuestCocona_2_3")
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompCocona:Waifu/RecQuestCocona_2_4")
	optain_item($data_items[106],1)
	chcg_background_color(0,0,0,0,7)
	get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	portrait_hide
	call_msg("CompCocona:Waifu/RecQuestCocona_2_5")
	portrait_hide
	$game_temp.choice = -1
	return eventPlayEnd

	############################################### 可可娜 FOOD #####################################################
elsif $story_stats["RecQuestCocona"] == 5 && $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"] && $story_stats["UniqueCharUniqueCocona"] != -1
	get_character(0).call_balloon(0)
	$story_stats["RecQuestCocona"] = 6
	call_msg("CompCocona:Waifu/RecQuestCocona_6_1")
	call_msg("CompCocona:Waifu/RecQuestCocona_6_2")
	get_character($game_map.get_storypoint("UniqueCocona")[2]).call_balloon(28,-1)
	
############################################### 可可娜 Bath #####################################################
elsif $story_stats["RecQuestCocona"] == 7 && $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"] && $story_stats["UniqueCharUniqueCocona"] != -1
	get_character(0).call_balloon(0)
	$story_stats["RecQuestCocona"] = 8
	call_msg("CompCocona:Waifu/RecQuestCocona_7_1")
	optain_item($data_items[112], 1)
	call_msg("CompCocona:Waifu/RecQuestCocona_7_2")
	get_character($game_map.get_storypoint("UniqueCocona")[2]).call_balloon(28,-1)
	
	if !$game_player.getComB_Name.nil? && $game_player.getComB_Name.include?("Cocona") #if cocona is in party,  force leave
		$game_player.record_companion_name_back = nil
		$game_player.record_companion_back_date= nil
		call_msg("common:Lona/Follower_disbanded")
	end
############################################### 可可娜 出遊 #####################################################
elsif $story_stats["RecQuestCocona"] == 10 && $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"] && $story_stats["UniqueCharUniqueCocona"] != -1
	tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("UniqueCocona")
	call_msg("CompCocona:Cocona/RecQuestCocona_10_1")
	get_character(0).npc_story_mode(true)
	get_character(0).animation = get_character(0).animation_atk_sh
	optain_item($data_items[122],1) #ItemQuestMamaFood
	wait(30)
	get_character(0).npc_story_mode(false)
	call_msg("CompCocona:Cocona/RecQuestCocona_10_2")
	get_character(tmpCoID).call_balloon(28,-1) if $game_date.day?
	$story_stats["RecQuestCocona"] = 11
	
############################################### 可可娜 失蹤 #####################################################
elsif $story_stats["RecQuestCocona"] == 13 && $story_stats["UniqueCharUniqueCocona"] != -1
	$story_stats["RecQuestCocona"] = 14
	tmpWx,tmpWy,tmpWid=$game_map.get_storypoint("TavernWaifu")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).moveto(tmpWx,tmpWy)
		get_character(0).direction = 2
		get_character(0).move_type = 0
		get_character(0).npc_story_mode(true)
		$game_player.moveto(tmpWx,tmpWy+2)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompCocona:Mama/RecQuestCocona_13_1")
	portrait_hide
	get_character(0).jump_to(tmpWx,tmpWy+2)
	$game_player.jump_to(tmpWx,tmpWy+3) ; $game_player.direction = 8
	wait(10)
	call_msg("CompCocona:Mama/RecQuestCocona_13_3")
	portrait_hide
	2.times{
		get_character(0).move_forward_force
		$game_player.direction = 2 ; $game_player.move_forward_force ; $game_player.direction = 8
		wait(35)
	}
	call_msg("CompCocona:Mama/RecQuestCocona_13_4")
	portrait_hide
	1.times{
		get_character(0).move_forward_force
		$game_player.direction = 2 ; $game_player.move_forward_force ; $game_player.direction = 8
		wait(35)
	}
	get_character(0).call_balloon(8)
	wait(60)
	get_character(0).animation = get_character(0).animation_atk_sh
	SndLib.sound_punch_hit(100)
	wait(20)
	case rand(3)
		when 0;get_character(0).call_balloon(15)
		when 1;get_character(0).call_balloon(7)
		when 2;get_character(0).call_balloon(5)
	end
	SndLib.sound_punch_hit(100)
	lona_mood "p5crit_damage"
	$game_player.actor.portrait.shake
	$game_player.actor.force_stun("Stun1")
	wait(30)
	call_msg("CompCocona:Mama/RecQuestCocona_13_5")
	portrait_off
	call_msg("common:Lona/NarrDriveAway")
	change_map_leave_tag_map
	portrait_hide
	
	###################################################### 教會任務結束 #################################
elsif $story_stats["RecQuestCocona"] == 21 && $story_stats["UniqueCharUniqueCocona"] != -1
	tmpUCx,tmpUCy,tmpUCid=$game_map.get_storypoint("UniqueCocona")
	tmpTWx,tmpTWy,tmpTWid=$game_map.get_storypoint("TavernWaifu")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpCOCO_OX = get_character(tmpUCid).x
		tmpCOCO_OY = get_character(tmpUCid).y
		$game_player.moveto(tmpTWx,tmpTWy+3)
		get_character(tmpUCid).moveto(tmpTWx+1,tmpTWy)
		get_character(tmpUCid).direction = 2
		get_character(tmpTWid).moveto(tmpTWx,tmpTWy)
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompCocona:cocona/RecQuestCocona_21_1")
	portrait_hide
	$game_player.move_forward_force
	wait(30)
	call_msg("CompCocona:cocona/RecQuestCocona_21_2")
	get_character(tmpUCid).direction = 4
	get_character(0).direction = 6
	call_msg("CompCocona:cocona/RecQuestCocona_21_3")
	get_character(0).direction = 2
	call_msg("CompCocona:cocona/RecQuestCocona_21_4")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		get_character(tmpUCid).moveto(tmpCOCO_OX,tmpCOCO_OY)
	chcg_background_color(0,0,0,255,-7)
	optain_exp(40000)
	wait(30)
	optain_item($data_items[106],2)
	$story_stats["RecQuestCoconaAmt"] = $game_date.dateAmt + 6
	$story_stats["RecQuestCocona"] = 22
	
##############################################################################姐姐不要走 begin1
elsif $story_stats["RecQuestCocona"] == 22 && $story_stats["UniqueCharUniqueCocona"] != -1 && $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
	call_msg("CompCocona:cocona/RecQuestCocona_22to23_1OPT") #[並沒有,是的]
	if $game_temp.choice == 1 #yes
		call_msg("CompCocona:cocona/RecQuestCocona_22to23_yes0")
		call_msg("CompCocona:cocona/RecQuestCocona_22to23_yes1")
		$story_stats["RecQuestCocona"] = 23
		tmpUCx,tmpUCy,tmpUCid=$game_map.get_storypoint("UniqueCocona")
		get_character(tmpUCid).call_balloon(28,-1)
		portrait_hide
		2.times{
			$game_player.direction = 2
			$game_player.call_balloon(8)
			wait(60)
		}
		call_msg("CompCocona:cocona/RecQuestCocona_22to23_yes2")
	else
		$story_stats["RecQuestCoconaAmt"] = $game_date.dateAmt + 6
		call_msg("CompCocona:cocona/RecQuestCocona_22to23_no")
	end
else
	########################################################## 正常對話 ##########################################  
	temp_work = 0
	tmpCanWork = $story_stats["#{map_id}DailyWorkAmt"] != $game_date.dateAmt
	tmpQ1 = $story_stats["RecQuestCocona"] == 24
	tmpQ2 = $story_stats["UniqueCharUniqueCocona"] != -1
	tmpQ3 = $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
	tmpGOLD = $game_party.item_number("ItemCoin3") >= 20
	tmpCocona20G = tmpQ1 && tmpQ2 && tmpQ3 && tmpGOLD
	if $story_stats["RecQuestCocona"] >= 26 && $story_stats["RecQuestCoconaDefeatBossMama"] >= 1 && tmpQ2 && $game_player.player_slave?
		if $story_stats["RecQuestCocona"] >= 28
			tmpPick = [true,false]
			call_msg("TagMapNoerTavern:Waifu/begin1_RecQuestCocona_28_#{rand(2)}") if tmpPick
			call_msg("TagMapNoerTavern:Waifu/begin1_RecQuestCocona_win") if !tmpPick
		else
			call_msg("TagMapNoerTavern:Waifu/begin1_RecQuestCocona_win")
		end
	elsif $story_stats["RecQuestCocona"] >= 26 && $story_stats["RecQuestCoconaDefeatBossMama"] <= 0 && tmpQ2 && $game_player.player_slave?
		if $story_stats["RecQuestCocona"] >= 28
			tmpPick = [true,false]
			call_msg("TagMapNoerTavern:Waifu/begin1_RecQuestCocona_28_#{rand(2)}") if tmpPick
			call_msg("TagMapNoerTavern:Waifu/begin1_RecQuestCocona_loser") if !tmpPick
		else
			call_msg("TagMapNoerTavern:Waifu/begin1_RecQuestCocona_loser")
		end
	else
		call_msg("TagMapNoerTavern:Waifu/begin1#{npc_talk_style}")
	end
		tmpPicked = ""
		tmpQuestList = []
		tmpQuestList << [$game_text["commonNPC:commonNPC/Cancel"]										,"Cancel"]
		tmpQuestList << [$game_text["DataItem:QuestMhKatana/item_name"]									,"QuestMhKatana"]	if $game_party.has_item?("ItemQuestMhKatana")
		tmpQuestList << [$game_text["CompCocona:Cocona/OPT_20g"]										,"OPT_20g"]			if tmpCocona20G
		tmpQuestList << [$game_text["commonNPC:commonNPC/Barter"]										,"Barter"]
		tmpQuestList << [$game_text["commonNPC:commonNPC/Work"]											,"Work"]			if tmpCanWork
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("TagMapNoerTavern:Waifu/Opt",0,2,0)
		call_msg("\\optB[#{cmd_text}]")
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1
	case tmpPicked
		when "QuestMhKatana"
			get_character(0).npc_story_mode(true)
			call_msg("CompCocona:getKatana/0") ; portrait_hide
			$game_player.animation = $game_player.animation_atk_sh
			wait(10)
			optain_lose_item("ItemQuestMhKatana",1)
			wait(50)
			call_msg("CompCocona:getKatana/1")
			get_character(0).direction = 8
			call_msg("CompCocona:getKatana/2")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				get_character(0).turn_toward_character($game_player)
				portrait_off
				wait(35)
				SndLib.sound_combat_sword_hit_sword(90,90+rand(20))
				wait(35)
				SndLib.sound_combat_sword_hit_sword(90,90+rand(20))
				wait(35)
				SndLib.WoodenBuild(100)
				wait(60)
				SndLib.sound_combat_sword_hit_sword(90,90+rand(20))
			chcg_background_color(0,0,0,255,-7)
			get_character(0).animation = get_character(0).animation_atk_sh
			wait(10)
			optain_item("ItemMhKatana",1)
			wait(50)
			call_msg("CompCocona:getKatana/3")
			call_msg("CompCocona:getKatana/4") ; portrait_hide
			get_character(0).animation = get_character(0).animation_atk_sh
			wait(10)
			optain_item("ItemCoin3",20)
			wait(50)
			call_msg("CompCocona:getKatana/5")
			get_character(0).npc_story_mode(false)
		when "OPT_20g"
			$story_stats["RecQuestCocona"] = 25
			$game_player.record_companion_name_back = nil if cocona_in_group?
			tmpTwX,tmpTwY,tmpTwID=$game_map.get_storypoint("TavernWaifu")
			tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("UniqueCocona")
			tmpCo_Ox,tmpCo_Oy = [get_character(tmpCoID).x,get_character(tmpCoID).y]
			tmpHazubendoX,tmpHazubendoY,tmpHazubendoID=$game_map.get_storypoint("Hazubendo")
			
			call_msg("CompCocona:Cocona/RecQuestCocona24to25_0")
			$game_player.animation = $game_player.animation_atk_sh
			optain_lose_item("ItemCoin3",20)
			call_msg("CompCocona:Cocona/RecQuestCocona24to25_1")
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(0).moveto(tmpTwX,tmpTwY+3)
				get_character(0).direction = 8
				get_character(0).forced_x = 16
				get_character(0).npc_story_mode(true)
				$game_player.moveto(tmpTwX,tmpTwY+2)
				$game_player.direction = 2
				get_character(tmpCoID).animation = nil
				get_character(tmpCoID).npc_story_mode(true)
				get_character(tmpCoID).move_type = 0
				get_character(tmpCoID).moveto(tmpTwX+1,tmpTwY+2)
				get_character(tmpCoID).direction = 2
			chcg_background_color(0,0,0,255,-7)
			call_msg("CompCocona:Cocona/RecQuestCocona24to25_2")
			get_character(0).direction = 4
			$game_player.direction = 4
			get_character(tmpCoID).direction = 4
			call_msg("CompCocona:Cocona/RecQuestCocona24to25_2_1")
			get_character(0).direction = 6
			$game_player.direction = 6
			get_character(tmpCoID).direction = 6
			call_msg("CompCocona:Cocona/RecQuestCocona24to25_2_2")
			get_character(0).direction = 2
			$game_player.direction = 2
			get_character(tmpCoID).direction = 2
			call_msg("CompCocona:Cocona/RecQuestCocona24to25_2_3")
			get_character(0).direction = 8
			$game_player.direction = 2
			get_character(tmpCoID).direction = 2
			call_msg("CompCocona:Cocona/RecQuestCocona24to25_2_4")
			portrait_hide
			cam_center(0)
			optain_exp(20000)
			3.times{
				get_character(0).direction = 2 ; get_character(0).move_forward_force
				get_character(0).move_speed = 2.8
				get_character(tmpCoID).direction = 2 ; get_character(tmpCoID).move_forward_force
				get_character(tmpCoID).move_speed = 2.8
				until !get_character(tmpCoID).moving? ; wait(1) end
			}
			until get_character(tmpCoID).opacity <= 0
				get_character(0).opacity -= 5
				get_character(tmpCoID).opacity -= 5
				wait(1)
			end
			get_character(0).delete
			get_character(tmpCoID).delete
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(tmpHazubendoID).moveto(tmpTwX,tmpTwY)
				get_character(tmpHazubendoID).move_type = 0
				get_character(tmpHazubendoID).set_manual_move_type(0)
				get_character(tmpHazubendoID).direction = 2
			chcg_background_color(0,0,0,255,-7)
			call_msg("CompCocona:Cocona/RecQuestCocona24to25_3_brd")
			eventPlayEnd
		when "Barter"
			manual_barters("NoerTavernWaifu")
		when "Work"
			$game_temp.choice = -1
			if $story_stats["RecQuestCocona"] >= 26 && $game_player.player_slave?
				call_msg("TagMapNoerTavern:Waifu/work_begin_RecQuestCocona_28")
			else
				call_msg("TagMapNoerTavern:Waifu/Opt_work") #[算了,送酒,舞孃]
			end
			case $game_temp.choice
				when 0,-1
				when 1
					call_msg("TagMapNoerTavern:Waifu/Opt_work_waiter_board")
					$game_temp.choice = -1
					call_msg("common:Lona/Decide_optB")
						case $game_temp.choice
							when 0,-1
							when 1
								temp_work = 1
								call_msg("TagMapNoerTavern:Waifu/Opt_work_waiter2_decide")
								$story_stats["#{map_id}DailyWorkAmt"] = $game_date.dateAmt
						end
				when 2
					call_msg("TagMapNoerTavern:Waifu/Opt_work_dancer_board")
					$game_temp.choice = -1
					call_msg("common:Lona/Decide_optB")
						case $game_temp.choice
							when 0,-1
							when 1
								temp_work = 2
								call_msg("TagMapNoerTavern:Waifu/Opt_work_dance")
								$story_stats["#{map_id}DailyWorkAmt"] = $game_date.dateAmt
						end
			end
			
	end
	
	if temp_work == 1 #服務員
		get_character($game_map.get_storypoint("WaiterCount")[2]).start
	elsif temp_work ==2 #舞孃
		get_character($game_map.get_storypoint("DanceCount")[2]).start
	end
end
$story_stats["HiddenOPT0"] = "0" 
eventPlayEnd


#check balloons
#可可娜
tmpQ1 = $story_stats["UniqueCharUniqueCocona"] != -1
tmpQ2 = $story_stats["RecQuestCocona"] == 3
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2
#可可娜 教學
tmpQ2 = $story_stats["RecQuestCocona"] == 5
tmpQ3 = $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
return  get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3
#可可娜 Bath
tmpQ2 = $story_stats["RecQuestCocona"] == 7
tmpQ3 = $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
return  get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3
#可可娜 出遊
tmpQ2 = $story_stats["RecQuestCocona"] == 10
tmpQ3 = $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
return  get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3
#姐姐不要走 begin 以及決鬥
tmpQ1 = $story_stats["RecQuestCocona"] == 22
tmpQ2 = $story_stats["UniqueCharUniqueCocona"] != -1
tmpQ3 = $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
return  get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3
#交20G
tmpQ1 = $story_stats["RecQuestCocona"] == 24
tmpQ2 = $story_stats["UniqueCharUniqueCocona"] != -1
tmpQ3 = $game_date.dateAmt >= $story_stats["RecQuestCoconaAmt"]
tmpGOLD = $game_party.item_number("ItemCoin3") >= 20
return  get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3 && tmpGOLD
#取得船票
tmpQ1 = $story_stats["RecQuestCocona"] == 27
return  get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2
#交20G
return  get_character(0).call_balloon(28,-1) if $game_party.has_item?("ItemQuestMhKatana")
