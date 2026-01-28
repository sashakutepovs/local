if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpH_BIOS_ID = $game_map.get_storypoint("H_BIOS")[2]
tmpWorkMode = get_character(tmpH_BIOS_ID).summon_data[:WorkerMode]
if $story_stats["RecordGangBossFirstTimeTalked"] == 0 && $game_player.actor.stat["SlaveBrand"] != 1 && $story_stats["Captured"] !=1 && $game_party.item_number("ItemPassportLona") >=1
	$story_stats["RecordGangBossFirstTimeTalked"] = 1
	call_msg("TagMapNoerBackStreet:GangBoss/begin_NONtrigger1")
	call_msg("TagMapNoerBackStreet:GangBoss/begin_NONtrigger2")
	call_msg("TagMapNoerBackStreet:GangBoss/begin_NONtrigger3")
	return eventPlayEnd
end
	if $game_player.actor.stat["SlaveBrand"] == 1 || $story_stats["Captured"] ==1
		$story_stats["RecordGangBossFirstTimeTalked"] = 1
		call_msg("TagMapNoerBackStreet:GangBoss/begin_slave")
	else
		call_msg("TagMapNoerBackStreet:GangBoss/begin")
	end


	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]									,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]									,"Barter"]
	tmpTarList << [$game_text["TagMapNoerBackStreet:GangBoss/opt_ex_sellID"]				,"sellID"]			if $game_party.item_number("ItemPassportLona") >= 1 #ItemPassportLona
	tmpTarList << [$game_text["commonNPC:commonNPC/opt_ex_Repayment"]						,"Repayment"]		if $story_stats["BackStreetArrearsPrincipal"]+$story_stats["BackStreetArrearsWhorePrincipal"] > 0
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end

	call_msg("TagMapNoerBackStreet:GangBoss/begin_triggered",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
	case tmpPicked
		when "Barter"	#trade
				tmpItemPassportFakeNum = $game_party.item_number("ItemPassportFake") #ItemPassportFake
				tmpItemPassportLonaNum = $game_party.item_number("ItemPassportLona") #ItemPassportLona
				tmpTotalPassportNum = tmpItemPassportFakeNum+tmpItemPassportLonaNum

				manual_barters("NoerBackStreetGangBoss")

				tmpItemPassportFakeNum = $game_party.item_number("ItemPassportFake") #ItemPassportFake
				tmpItemPassportLonaNum = $game_party.item_number("ItemPassportLona") #ItemPassportLona
				tmpTotalPassportNum_after = tmpItemPassportFakeNum+tmpItemPassportLonaNum
				if tmpTotalPassportNum_after != tmpTotalPassportNum
					optain_morality((50-$game_player.actor.morality_lona).round)
					$game_player.actor.morality_lona = 50
					$game_party.lose_item("ItemPassportFake",tmpItemPassportFakeNum-1) if tmpItemPassportFakeNum >=2
				end
		when "sellID"
			call_msg("TagMapNoerBackStreet:GangBoss/SellPassport")
			call_msg("common:Lona/Decide_optB")
			if $game_temp.choice == 1
				optain_lose_item("ItemPassportLona",$game_party.item_number("ItemPassportLona")) #ItemPassportLona
				call_msg("TagMapNoerBackStreet:GangBoss/SellPassport_sold")
				optain_item("ItemCoin3",1)
			end
		when "Repayment"
			tmpGotoTar = ""
			tmpTarList = []
			tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]									,"Cancel"]
			tmpTarList << [$game_text["menu:main_stats/trade_point"]								,"TP"]
			tmpTarList << [$game_text["commonNPC:commonNPC/opt_PawnItems"]				,"PawnItems"]
			cmd_sheet = tmpTarList
			cmd_text =""
			for i in 0...cmd_sheet.length
				cmd_text.concat(cmd_sheet[i].first+",")
			end

			call_msg("TagMapNoerBackStreet:GangBoss/Arrears_return_opt",0,2,0)
			call_msg("\\optB[#{cmd_text}]")
			$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
			$game_temp.choice = -1
			case tmpPicked
				when "TP"
						call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info")
						tmpTotal = [$story_stats["BackStreetArrearsPrincipal"]+$story_stats["BackStreetArrearsInterest"],$story_stats["BackStreetArrearsWhorePrincipal"]].max
						tmpArr = tmpTotal.to_i.num_digits
						tmpGold = $game_party.gold.to_i.num_digits
						tmpLeng = [tmpGold,tmpArr].min
						setup_num_input([1,tmpLeng])
						$game_map.interpreter.wait_for_message
						wait(20)

						tmpReturn = [$game_variables[1],$game_party.gold].min
						$game_party.lose_gold(tmpReturn)
						$story_stats["BackStreetArrearsInterest"] -= tmpReturn
						$story_stats["BackStreetArrearsWhorePrincipal"] -= $story_stats["BackStreetArrearsInterest"].abs if $story_stats["BackStreetArrearsInterest"] < 0 #&& $story_stats["RapeLoop"] != 1
						$story_stats["BackStreetArrearsWhorePrincipal"] =0 if $story_stats["BackStreetArrearsWhorePrincipal"] < 0
						if $story_stats["BackStreetArrearsInterest"] < 0
							$story_stats["BackStreetArrearsPrincipal"] += $story_stats["BackStreetArrearsInterest"]
							$story_stats["BackStreetArrearsInterest"] = 0
							if $story_stats["BackStreetArrearsPrincipal"] < 0
								$story_stats["BackStreetArrearsPrincipal"]=0
								$story_stats["BackStreetArrearsInterest"] = 0
							end
						end
						$game_variables[1] =0
						call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info")
				when "PawnItems"
						call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info")
						SceneManager.goto(Scene_ItemStorage)
						SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
						call_msg("TagMapNoerBackStreet:GangBoss/wait")
						tmpTotal = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
						$story_stats["BackStreetArrearsInterest"] -= tmpTotal
						$story_stats["BackStreetArrearsWhorePrincipal"] -= $story_stats["BackStreetArrearsInterest"].abs if $story_stats["BackStreetArrearsInterest"] < 0
						$story_stats["BackStreetArrearsWhorePrincipal"] =0 if $story_stats["BackStreetArrearsWhorePrincipal"] < 0
						if $story_stats["BackStreetArrearsInterest"] < 0
							$story_stats["BackStreetArrearsPrincipal"] += $story_stats["BackStreetArrearsInterest"]
							$story_stats["BackStreetArrearsInterest"] = 0
							if $story_stats["BackStreetArrearsPrincipal"] < 0
								$story_stats["BackStreetArrearsPrincipal"]=0
								$story_stats["BackStreetArrearsInterest"] = 0
							end
						end
						$story_stats["BackStreetArrearsPrincipal"] += $story_stats["BackStreetArrearsInterest"] if $story_stats["BackStreetArrearsInterest"] < 0
						call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info")
						$game_boxes.box(System_Settings::STORAGE_TEMP).clear
				end
	end #case


if $story_stats["BackStreetArrearsPrincipal"] <= 0 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1
	$story_stats["BackStreetArrearsPrincipal"]=0
	$story_stats["BackStreetArrearsInterest"] = 0
	$story_stats["BackStreetArrearsPrepayDateAMT"] =0
	if !$game_player.player_slave?
		$story_stats["Captured"] = 0
		$story_stats["RapeLoop"] = 0
		$story_stats["RapeLoopTorture"] = 0
	end
end

$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
eventPlayEnd
return get_character(0).call_balloon(28,-1) if $story_stats["BackStreetArrearsPrincipal"] != 0 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1
return get_character(0).call_balloon(28,-1) if $story_stats["BackStreetArrearsInterest"] != 0 && $story_stats["UniqueCharUniqueHappyMerchant"] != -1
