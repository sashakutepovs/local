if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

########################################################################## 歸還遺失的貨物
if $story_stats["RecQuestDancerSetReturned"] == 0 && $game_party.has_item?($data_items[100]) && $story_stats["UniqueCharUniqueTeller"] != -1
	tmpTellerX,tmpTellerY,tmpTellerID=$game_map.get_storypoint("teller")
	tmpTellerDoorX,tmpTellerDoorY,tmpTellerDoorID=$game_map.get_storypoint("TellerDoor")
	if get_character(tmpTellerID).x != tmpTellerX && get_character(tmpTellerID).y != tmpTellerY
		call_msg("CompTeller:HappyTrader/DancerSet0_waifuIsntThere")
		eventPlayEnd
		return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestDancerSetReturned"] == 0 && $game_party.has_item?($data_items[100])
	end
	get_character(0).call_balloon(0)
	call_msg("CompTeller:HappyTrader/DancerSet0") ; portrait_hide
	$story_stats["RecQuestDancerSetReturned"] = 1
	optain_lose_item($data_items[100],1)
	$game_player.animation = $game_player.animation_atk_sh
	wait(30)
	get_character(0).call_balloon(8)
	wait(60)
	call_msg("CompTeller:HappyTrader/DancerSet1")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpHappyMerchantX,tmpHappyMerchantY,tmpHappyMerchantID = $game_map.get_storypoint("HappyMerchant")
		get_character(0).npc_story_mode(true)
		get_character(tmpTellerID).npc_story_mode(true)
		tmpTellerX,tmpTellerY,tmpTellerID = $game_map.get_storypoint("teller")
		tmpHappyMerchantOX = get_character(0).x
		tmpHappyMerchantOY = get_character(0).y
		tmpHappyMerchantOD = get_character(0).direction
		tmpTellerMoveTYPE = get_character(tmpTellerID).move_type
		tmpTellerMoveTYPE
		$game_player.direction = 6
		tmpTellerOD = get_character(tmpTellerID).direction
		get_character(0).moveto(tmpHappyMerchantX+2,tmpHappyMerchantY+2)
		get_character(tmpTellerID).moveto(tmpHappyMerchantX+3,tmpHappyMerchantY+2)
		get_character(0).direction = 6
		get_character(tmpTellerDoorID).force_page(1,0) #open the door
		get_character(tmpTellerDoorID).refresh
		get_character(tmpTellerID).direction = 4
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompTeller:HappyTrader/DancerSet2")
	SndLib.sound_equip_armor(100)
	get_character(0).animation = get_character(0).animation_atk_sh
	wait(30)
	call_msg("CompTeller:HappyTrader/DancerSet3")
	1.times{
		get_character(tmpTellerID).direction = 6 ; get_character(tmpTellerID).move_forward_force
		get_character(tmpTellerID).move_speed = 3
		until !get_character(tmpTellerID).moving? ; wait(1) end
	}
	get_character(tmpTellerID).call_balloon(5)
	get_character(tmpTellerID).direction = 6 ; get_character(tmpTellerID).move_forward_force
	get_character(tmpTellerID).move_speed = 3
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).npc_story_mode(false)
		get_character(tmpTellerID).npc_story_mode(false)
		get_character(0).moveto(tmpHappyMerchantOX,tmpHappyMerchantOY)
		get_character(0).direction = tmpHappyMerchantOD
		get_character(tmpTellerID).moveto(tmpTellerX,tmpTellerY)
		get_character(tmpTellerID).direction = tmpTellerOD
		get_character(tmpTellerDoorID).force_page(2,4) #open the door
		get_character(tmpTellerDoorID).refresh
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompTeller:HappyTrader/DancerSet4")
	optain_exp(4000*2)
else
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	
	if $story_stats["UniqueCharUniqueTeller"] != -1
		call_msg("TagMapNoerRecRoom:HappyTrader/begin#{rand(2)}",0,2,0)
	else
		call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	end
	
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
				
	case tmpPicked
		when "Barter"
			manual_barters("NoerRecRoomHappyMerchant")
			call_msg("TagMapNoerRecRoom:HappyTrader/end") if $story_stats["UniqueCharUniqueTeller"] != -1
	end
end

eventPlayEnd

return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestDancerSetReturned"] == 0 && $game_party.has_item?($data_items[100])

