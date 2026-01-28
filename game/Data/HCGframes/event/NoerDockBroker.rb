
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end








	call_msg("TagMapNoerDock:Captain/Welcome_unknow") if $story_stats["RecQuestCaptain"] == 0
	call_msg("TagMapNoerDock:Captain/Welcome_talked") if $story_stats["RecQuestCaptain"] == 1

goEndingShip = false
temp_price = (20 + $story_stats["WorldDifficulty"] *0.1).to_i
tmpMaidText = $game_map.interpreter.cocona_maid? ? "Maid" : ""
tmpMaidText = "UniqueCocona#{tmpMaidText}"
tmpIsSlave = $game_player.player_slave?
OPT_BeSlave = false
goWithCOcona = $game_player.record_companion_name_back == tmpMaidText && $story_stats["RecQuestCocona"] == 28 && $game_party.has_item?("ItemQuestCoconaShip")
	tmpPicked = ""
	tmpQuestList = []
	tmpQuestList << [$game_text["commonNPC:commonNPC/Cancel"]										,"Cancel"]
	tmpQuestList << [$game_text["commonNPC:commonNPC/About"]										,"About"] if $story_stats["RecQuestCaptain"] == 0
	tmpQuestList << [$game_text["TagMapNoerDock:Captain/OPT_HowMuch"]								,"OPT_HowMuch"] if $story_stats["RecQuestCaptain"] == 1
	tmpQuestList << [$game_text["TagMapNoerDock:Captain/OPT_GiveMoney"]								,"OPT_GiveMoney"] if $story_stats["RecQuestCaptain"] == 1 && !goWithCOcona
	tmpQuestList << [$game_text["CompCocona:ShipEnding/OPT_GoWithCocona"]							,"OPT_GoWithCocona"] if $story_stats["RecQuestCaptain"] == 1 && goWithCOcona
	tmpQuestList << [$game_text["TagMapNoerDock:Captain/OPT_BeSlave"]								,"OPT_BeSlave"] if $story_stats["RecQuestCaptain"] == 1 && !tmpIsSlave
	cmd_sheet = tmpQuestList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
case tmpPicked
	when "About"
		get_character(0).call_balloon(0)
		call_msg("TagMapNoerDock:Captain/Welcome_unknow_detail")
		$story_stats["RecQuestCaptain"] = 1 if $story_stats["RecQuestCaptain"] == 0
		$story_stats["RecQuestCaptainAmt"] = $game_date.dateAmt if $story_stats["RecQuestCaptain"] == 0
	when "OPT_HowMuch"
			$game_message.add("#{$game_text["TagMapNoerDock:Captain/Price_today"]}#{temp_price}#{$game_text["TagMapNoerDock:Captain/Price_today_link"]}")
			$game_map.interpreter.wait_for_message
	when "OPT_GoWithCocona"
			goEndingShip = true
	when "OPT_GiveMoney"
			goEndingShip = true
	when "OPT_BeSlave"
			call_msg("TagMapNoerDock:Captain/Leave_Slave")
			call_msg("common:Lona/Decide_optB")
			if $game_temp.choice == 1
				call_msg("TagMapNoerDock:Captain/Leave_Slave_yes0")
				portrait_hide
				chcg_background_color(0,0,0,0,7)
					portrait_off
					$game_player.actor.stat["EventExt1Race"] = "Human"
					$game_player.actor.stat["EventExt1"] ="Grab"
					call_msg("TagMapNoerDock:Captain/Leave_Slave_yes1")
					$game_player.actor.mood = -100
					$game_player.actor.add_state("SlaveBrand") #51
					whole_event_end
					goEndingShip = true
					$cg.erase
					$bg.erase
					map_background_color(0,0,0,255,0)
				chcg_background_color(0,0,0,255,-7)
			else
				call_msg("TagMapNoerDock:Captain/Leave_Slave_no")
			end
			#call_msg("TagMapNoerDock:Captain/Leave_Slave")
		
end

if goEndingShip
	if $game_player.player_slave? && OPT_BeSlave
		$story_stats["Ending_MainCharacter"] = "Ending_MC_ShipSlave"
		return load_script("Data/HCGframes/event/Ending_loader.rb")
	elsif $game_player.player_slave?
		portrait_hide
		get_character(0).call_balloon(8)
		wait(90)
		get_character(0).npc_story_mode(true)
		get_character(0).animation = get_character(0).animation_atk_mh
		get_character(0).call_balloon([15,7,5].sample)
		SndLib.sound_punch_hit(100)
		lona_mood "p5crit_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.force_stun("Stun1")
		call_msg("!!!!!")
		wait(60)
		portrait_hide
		chcg_background_color(0,0,0,0,7)
		map_background_color(0,0,0,255,0)
		call_msg("TagMapNoerDock:Captain/Leave_SlaveTR1")
		portrait_hide
		$story_stats["Ending_MainCharacter"] = "Ending_MC_ShipSlave"
		return load_script("Data/HCGframes/event/Ending_loader.rb")
	elsif $game_party.item_number($data_items[52]) < temp_price
		call_msg("TagMapNoerDock:Captain/Leave_NotEnoughMoney")
		get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
	elsif $game_party.item_number($data_items[52]) >= temp_price
		call_msg("TagMapNoerDock:Captain/Leave_WithEnoughMoney")
		return load_script("Data/HCGframes/event/NoerDockBrokerBsArrears.rb") if $story_stats["UniqueCharUniqueGangBoss"] != -1 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1 && $story_stats["BackStreetArrearsPrincipal"] >=1
		if tmpPicked == "OPT_GoWithCocona"
			$story_stats["RecQuestCocona"] = 29
			GabeSDK.getAchievement("RecQuestCocona_28")
			tmpCaptainX,tmpCaptainY,tmpCaptainID = $game_map.get_storypoint("Captain")
			coconaID = $game_player.get_followerID(0)
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				get_character(0).moveto(tmpCaptainX,tmpCaptainY)
				get_character(0).direction = 8
				get_character(0).forced_x = 16
				$game_player.moveto(tmpCaptainX,tmpCaptainY-1)
				get_character(coconaID).moveto(tmpCaptainX+1,tmpCaptainY-1)
				$game_player.direction = 2
				get_character(coconaID).direction = 2
				call_msg("CompCocona:EndingShip/0")
				portrait_hide
			chcg_background_color(0,0,0,255,-7)
			call_msg("CompCocona:EndingShip/1")
			$game_player.animation = $game_player.animation_atk_sh
			wait(10)
			optain_lose_item("ItemQuestCoconaShip",1)
			wait(50)
			$game_player.direction = 6
			call_msg("CompCocona:EndingShip/2")
			$game_player.direction = 2
			call_msg("CompCocona:EndingShip/3")
		end
		$story_stats["Ending_MainCharacter"] = "Ending_MC_ShipTicketBought"
		return load_script("Data/HCGframes/event/Ending_loader.rb")
	end
end
eventPlayEnd

return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestCaptain"] == 0
