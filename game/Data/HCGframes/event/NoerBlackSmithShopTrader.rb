if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $game_player.actor.state_stack(51) != 0 #is slave brand?
	call_msg("TagMapNoerBSS:BSStrader/SlaveBrand")
	return eventPlayEnd
end

call_msg("TagMapNoerBSS:BSStrader/welcome")
tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]					,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/About"]					,"About"]
tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]					,"Barter"]
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
	when "Cancel"
		call_msg("TagMapNoerBSS:BSStrader/end")
		
	when "Barter"
		manual_barters("NoerBlackSmithShopTrader")
	when "About"
		call_msg("TagMapNoerBSS:BSStrader/About")
			
	else
		call_msg("TagMapNoerBSS:BSStrader/end")
end #case

if $game_party.has_item_type("SurgeryCoupon")
	if $game_player.actor.state_stack(51) != 0 #is slave brand?
		call_msg("TagMapNoerBSS:BSStrader/SlaveBrand")
		optain_gold($game_party.get_item_type_price("SurgeryCoupon"))
		$game_party.lost_item_type("SurgeryCoupon")
		
	elsif !$game_player.player_slave?
		call_msg("TagMapNoerBSS:BSStrader/NotCuffed")
		optain_gold($game_party.get_item_type_price("SurgeryCoupon"))
		$game_party.lost_item_type("SurgeryCoupon")
	else
		tmpTraderX,tmpTraderY,tmpTraderID = $game_map.get_storypoint("BSStrader")
		tmpBSSwPtX,tmpBSSwPtY,tmpBSSwPtID = $game_map.get_storypoint("BssWork")
		tmpBSSwLonaX,tmpBSSwLonaY,tmpBSSwLonaID = $game_map.get_storypoint("BssWorkLona")
		tmpBSSRtLonaX,tmpBSSRtLonaY,tmpBSSRtLonaID = $game_map.get_storypoint("BssRtLona")
		call_msg("TagMapNoerBSS:BSStrader/Aid0")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_player.moveto(tmpBSSwLonaX,tmpBSSwLonaY)
			$game_player.direction = 4
			get_character(tmpTraderID).moveto(tmpBSSwPtX,tmpBSSwPtY)
			get_character(tmpTraderID).direction = 6
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapNoerBSS:BSStrader/Aid1")
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			#####################################################################
			#Do thing
			wait(35)
			SndLib.sound_combat_sword_hit_sword(90,90+rand(20))
			wait(35)
			SndLib.sound_combat_sword_hit_sword(90,90+rand(20))
			wait(35)
			SndLib.sound_combat_sword_hit_sword(90,90+rand(20))
			wait(35)
			SndLib.sound_combat_sword_hit_sword(90,90+rand(20))
			if $game_party.has_item?("AidChainCuff") && $game_player.actor.equips[0] == $data_ItemName["ItemChainCuff"]
				call_msg("TagMapNoerBSS:BSStrader/RemoveEnd")
				$game_player.actor.change_equip(0, nil)
				optain_lose_item("ItemChainCuff",1)
			end
			if $game_party.has_item?("AidCuff") && $game_player.actor.equips[0] == $data_ItemName["ItemCuff"]
				call_msg("TagMapNoerBSS:BSStrader/RemoveEnd")
				$game_player.actor.change_equip(0, nil)
				optain_lose_item("ItemCuff",1)
			end
			if $game_party.has_item?("AidChainCollar") && $game_player.actor.equips[5] == $data_ItemName["ItemChainCollar"]
				call_msg("TagMapNoerBSS:BSStrader/RemoveEnd")
				$game_player.actor.change_equip(5, nil)
				optain_lose_item("ItemChainCollar",1)
			end
			if $game_party.has_item?("AidCollar") && $game_player.actor.equips[5] == $data_ItemName["ItemCollar"]
				call_msg("TagMapNoerBSS:BSStrader/RemoveEnd")
				$game_player.actor.change_equip(5, nil)
				optain_lose_item("ItemCollar",1)
			end
			if $game_party.has_item?("AidChainMidExtra") && $game_player.actor.equips[6] == $data_ItemName["ItemChainMidExtra"]
				call_msg("TagMapNoerBSS:BSStrader/RemoveEnd")
				$game_player.actor.change_equip(6, nil)
				optain_lose_item("ItemChainMidExtra",1)
			end
			$game_party.lost_item_type("SurgeryCoupon")
			#######################################################################
			
			get_character(tmpTraderID).moveto(tmpTraderX,tmpTraderY)
			get_character(tmpTraderID).direction = 2
			$game_player.moveto(tmpBSSRtLonaX,tmpBSSRtLonaY)
			$game_player.direction =8
		chcg_background_color(0,0,0,255,-7)
	end
end


$story_stats["HiddenOPT0"] = "0" 
eventPlayEnd
