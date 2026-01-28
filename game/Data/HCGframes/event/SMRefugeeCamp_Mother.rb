if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpMotherX,tmpMotherY,tmpMotherID = $game_map.get_storypoint("Mother")
tmpTommyX,tmpTommyrY,tmpTommyID = $game_map.get_storypoint("Tommy")
if $story_stats["RecQuestSMRefugeeCampFindChild"] == 0
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog0")
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog0_board")
	call_msg("common:Lona/Decide_optB") #[算了,決定]
	if $game_temp.choice == 1
		call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog0_Taken")
		$story_stats["RecQuestSMRefugeeCampFindChild"] = 1
	end
	
	########################################################## 沒找到 回報任務後刪除母親
elsif $story_stats["RecQuestSMRefugeeCampFindChild"] == 6
	get_character(0).call_balloon(0)
	$story_stats["RecQuestSMRefugeeCampFindChild"] = 7
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).moveto(tmpMotherX,tmpMotherY)
		get_character(0).direction = 2
		get_character(0).move_speed = 3
		$game_player.moveto(tmpMotherX,tmpMotherY+1)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/QdoneBegin")
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog7_NotFound")
	cam_center(0)
	get_character(0).npc_story_mode(true)
	get_character(0).direction = 2 ; get_character(0).move_forward_force ; wait(10)
	$game_player.jump_to(tmpMotherX+1,tmpMotherY+1) ; $game_player.turn_toward_character(get_character(0)) ; SndLib.sound_punch_hit(100)
	wait(35)
	get_character(0).direction = 4 ; get_character(0).move_forward_force ; $game_player.turn_toward_character(get_character(0))
	wait(35)
	2.times{
		get_character(0).direction = 2 ; get_character(0).move_forward_force ; $game_player.turn_toward_character(get_character(0))
		wait(35)
	}
	chcg_background_color(0,0,0,0,7)
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog7_end")
	optain_exp(5000)
	
	########################################################################## 10 FOUND TOMMY AND  BACK TOMMY TO HIS MOTHER
elsif $story_stats["RecQuestSMRefugeeCampFindChild"].between?(8,9) && $game_player.record_companion_name_ext == "MonasteryFindChild_Qobj"
	$story_stats["RecQuestSMRefugeeCampFindChild"] = 10
	get_character(0).call_balloon(0)
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog9_win0")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpExt = get_character($game_player.get_companion_id(-1))
		tmpExt.set_this_companion_disband if tmpExt
		get_character(0).moveto(tmpMotherX,tmpMotherY+1)
		get_character(0).direction = 4
		get_character(tmpTommyID).moveto(tmpMotherX-1,tmpMotherY+1)
		get_character(tmpTommyID).direction = 6
		$game_player.moveto(tmpMotherX,tmpMotherY+2)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog9_win1")
	$game_player.direction = 4 ; $game_player.move_forward_force
	wait(10)
	get_character(tmpTommyID).direction = 2
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog9_win2")
	$game_player.direction = 8
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog9_win3")
	SndLib.sound_equip_armor
	get_character(tmpTommyID).npc_story_mode(true)
	get_character(tmpTommyID).animation = get_character(tmpTommyID).animation_atk_shoot_hold
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog9_win4")
	SndLib.sound_chs_buchu(100)
	get_character(tmpTommyID).animation = get_character(tmpTommyID).animation_atk_sh
	optain_item("ItemMhSilverDildo",1) #ItemMhSilverDildo
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog9_win5")
	optain_exp(10000)
	wait(30)
	chcg_background_color(0,0,0,0,7)
		get_character(tmpTommyID).npc_story_mode(false)
		get_character(0).moveto(tmpMotherX,tmpMotherY)
		get_character(0).direction = 4
		get_character(tmpTommyID).moveto(tmpMotherX-1,tmpMotherY-1)
		get_character(tmpTommyID).direction = 2
	chcg_background_color(0,0,0,255,-7)
	
	########################################################################## 11 FOUND TOMMY BUT TOMMY ISNT THERE
elsif $story_stats["RecQuestSMRefugeeCampFindChild"].between?(8,9) && $game_player.record_companion_name_ext != "MonasteryFindChild_Qobj"
	$story_stats["RecQuestSMRefugeeCampFindChild"] = 11
	get_character(0).call_balloon(0)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).moveto(tmpMotherX,tmpMotherY)
		get_character(0).direction = 2
		get_character(0).move_speed = 3
		$game_player.moveto(tmpMotherX,tmpMotherY+1)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/QdoneBegin")
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog9_failed")
	cam_center(0)
	get_character(0).npc_story_mode(true)
	get_character(0).direction = 2 ; get_character(0).move_forward_force ; wait(10)
	$game_player.jump_to(tmpMotherX+1,tmpMotherY+1) ; $game_player.turn_toward_character(get_character(0)) ; SndLib.sound_punch_hit(100)
	wait(35)
	get_character(0).direction = 4 ; get_character(0).move_forward_force ; $game_player.turn_toward_character(get_character(0))
	wait(35)
	2.times{
		get_character(0).direction = 2 ; get_character(0).move_forward_force ; $game_player.turn_toward_character(get_character(0))
		wait(35)
	}
	chcg_background_color(0,0,0,0,7)
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog7_end")
	optain_exp(6000)
	
elsif $story_stats["RecQuestSMRefugeeCampFindChild"].between?(1,5)
	call_msg("TagMapSMRefugeeCamp:MIAchildMAMA/prog1_noNews")
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapSMRefugeeCamp:MAMAdone/Qmsg",get_character(0).id)
end
eventPlayEnd

#check balloon
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSMRefugeeCampFindChild"] == 0
