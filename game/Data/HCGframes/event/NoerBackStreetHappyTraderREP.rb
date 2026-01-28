if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpH_BIOS_ID = $game_map.get_storypoint("H_BIOS")[2]
tmpWorkMode = get_character(tmpH_BIOS_ID).summon_data[:WorkerMode]
call_msg("TagMapNoerBackStreet:FishTraderREP/begin_normal") if $story_stats["BackStreetArrearsPrincipal"] == 0
call_msg("TagMapNoerBackStreet:FishTraderREP/begin_normalArrears") if $story_stats["BackStreetArrearsPrincipal"] > 0

tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]									,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]									,"Barter"]
tmpTarList << [$game_text["commonNPC:commonNPC/Work"]									,"Work"]			if $story_stats["Captured"] != 1
tmpTarList << [$game_text["commonNPC:commonNPC/opt_ex_LoanInfo"]			,"LoanInfo"]		if $story_stats["BackStreetArrearsPrincipal"] > 0	 && $game_player.actor.stat["SlaveBrand"] != 1
tmpTarList << [$game_text["commonNPC:commonNPC/opt_ex_Loan"]				,"Loan"]			if $story_stats["BackStreetArrearsPrincipal"] == 0	 && $game_player.actor.stat["SlaveBrand"] != 1
tmpTarList << [$game_text["commonNPC:commonNPC/opt_ex_Repayment"]			,"Repayment"]		if $story_stats["BackStreetArrearsPrincipal"]+$story_stats["BackStreetArrearsWhorePrincipal"] > 0
cmd_sheet = tmpTarList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
call_msg("TagMapNoerBackStreet:HappyTrader/opt",0,2,0)
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1

case tmpPicked
	when "Barter"
			manual_barters("NoerBackStreetHappyTraderREP")
	when "Work"
			tmpGotoTar = ""
			tmpTarList = []
			tmpTarList << [$game_text["commonNPC:commonNPC/work_opt_ex_nothing"]			,"Cancel"]
			tmpTarList << [$game_text["commonNPC:commonNPC/work_opt_ex_whore"]				,"Whore"]			if $story_stats["Captured"] != 1 && !tmpWorkMode
			tmpTarList << [$game_text["commonNPC:commonNPC/opt_ex_Employee"]				,"Employee"]		if $game_player.actor.stat["SlaveBrand"] != 1
			cmd_sheet = tmpTarList
			cmd_text =""
			for i in 0...cmd_sheet.length
				cmd_text.concat(cmd_sheet[i].first+",")
			end
			call_msg("TagMapNoerBackStreet:FishTraderREP/work_opt",0,2,0)
			call_msg("\\optB[#{cmd_text}]")
			$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
			$game_temp.choice = -1
			case tmpPicked
					when "Employee"
						call_msg("TagMapNoerBackStreet:FishTraderREP/BecomeSlave_begin0")
						call_msg("TagMapNoerBackStreet:HappyTrader/BecomeSlave_begin2")
						call_msg("common:Lona/Decide_optB")
						if $game_temp.choice == 1
							call_msg("TagMapNoerBackStreet:HappyTrader/BecomeSlave_accept0")
							call_msg("TagMapNoerBackStreet:FishTraderREP/BecomeSlave_accept1")
							$game_map.popup(0,"1",$data_ItemName["ItemHiPotionLV2"].icon_index,-1)
							$game_player.actor.itemUseBatch("ItemHiPotionLV2")
							SndLib.sound_drink(100)
							wait(60)
							call_msg("TagMapNoerBackStreet:HappyTrader/BecomeSlave_accept2")
							portrait_hide
							chcg_background_color(0,0,0,0,7)
								portrait_off
								$game_player.animation = $game_player.animation_stun
								tmpU1X,tmpU1Y,tmpU1ID=$game_map.get_storypoint("stGang1")
								$game_player.actor.stat["EventExt1Race"] = "Human"
								$game_player.actor.stat["EventExt1"] ="Grab"
								tmpU2X,tmpU2Y,tmpU2ID=$game_map.get_storypoint("stGang2")
								get_character(tmpU1ID).npc_story_mode(true)
								get_character(tmpU2ID).npc_story_mode(true)
								set_event_force_page(tmpU1ID,1,0)
								set_event_force_page(tmpU2ID,1,0)
								get_character(tmpU1ID).moveto($game_player.x,$game_player.y)
								get_character(tmpU1ID).move_forward_passable_dir
								get_character(tmpU2ID).moveto($game_player.x,$game_player.y)
								get_character(tmpU2ID).move_forward_passable_dir
								until !get_character(tmpU2ID).moving? && !get_character(tmpU1ID).moving?
									wait(1)
								end
							chcg_background_color(0,0,0,255,-7)
							get_character(tmpU1ID).turn_toward_character($game_player)
							get_character(tmpU1ID).call_balloon([1,5,7,15].sample)
							get_character(tmpU2ID).turn_toward_character($game_player)
							get_character(tmpU2ID).call_balloon([1,5,7,15].sample)
							get_character(tmpU1ID).animation = get_character(tmpU1ID).animation_grabber_qte($game_player)
							$game_player.animation = $game_player.animation_grabbed_qte
							$game_player.actor.sta = -100
							$game_player.actor.mood = -99
							call_msg("TagMapNoerBackStreet:HappyTrader/BecomeSlave_accept3")
							call_msg("TagMapNoerBackStreet:HappyTrader/BecomeSlave_accept3_1")
							call_msg("TagMapNoerBackStreet:HappyTrader/BecomeSlave_accept3_2")
							call_msg("TagMapNoerBackStreet:HappyTrader/BecomeSlave_accept3_3")
							$game_player.actor.add_state("SlaveBrand") #51
							whole_event_end
							get_character(tmpH_BIOS_ID).summon_data[:WorkerMode] = false
							$story_stats["Captured"] = 1
							$story_stats["RapeLoop"] = 1
							$story_stats["BackStreetArrearsPrincipal"] = 0
							$story_stats["BackStreetArrearsInterest"] = 0
							$story_stats["BackStreetArrearsWhorePrincipal"] = 0
							$story_stats["SlaveOwner"] = "NoerBackStreet"
							#移除裝備
							rape_loop_drop_item(false,false)
							load_script("Data/Batch/Put_HeavyestBondage_no_dialog.rb") #上銬批次檔
							call_msg("TagMapNoerBackStreet:HappyTrader/BecomeSlave_accept4")
							$game_player.actor.update_lonaStat
							$game_player.update
							chcg_background_color(0,0,0,0,7)
							map_background_color(0,0,0,255)
							$game_player.animation = nil
							$game_map.clear_fog
							tmpX,tmpY = $game_map.get_storypoint("WakeUp")
							$game_player.moveto(tmpX,tmpY)
						end
					when "Whore"
						$game_temp.choice = -1
						if $game_player.actor.stat["Prostitute"] == 1
							tmpDialyDiff = 1300
							tmpAfterDiff = 600
							$story_stats["HiddenOPT0"] = [tmpDialyDiff,tmpAfterDiff]
							call_msg("TagMapNoerBackStreet:HappyTrader/work_whore_board1")
							call_msg("TagMapNoerBackStreet:HappyTrader/work_whore_board2")
							$story_stats["HiddenOPT0"] = "0"
							call_msg("common:Lona/Decide_optB")
							case $game_temp.choice
								when 1
									$story_stats["BackStreetArrearsPrincipal"] += tmpDialyDiff
									get_character(tmpH_BIOS_ID).summon_data[:WorkerMode] = true
									call_msg("TagMapNoerBackStreet:FishTraderREP/work_whore_accept0")
									call_msg("TagMapNoerBackStreet:FishTraderREP/work_whore_accept1") if $story_stats["UniqueCharUniqueGangBoss"] == -1
									cam_center(0)
							end
					else
						call_msg("TagMapNoerBackStreet:FishTraderREP/work_whore_NoTrait")
					end
				end
	when "LoanInfo"
			call_msg("TagMapNoerBackStreet:FishTraderREP/opt_AboutArrears")
			call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info")
	when "Loan"
			$game_temp.choice = -1
			tmpMult = (1.05**7).round(3)
			if $story_stats["RecordBackStreetArrears"] == 0
				$story_stats["RecordBackStreetArrears"] = 1
				call_msg("TagMapNoerBackStreet:FishTraderREP/Arrears_NewTo0")
				call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_NewTo1")
			end
			call_msg("TagMapNoerBackStreet:FishTraderREP/Arrears1_opt") # [算了,20000,40000,60000,80000]
			case $game_temp.choice
				when 0,-1
				else
					$story_stats["BackStreetArrearsPrepayDateAMT"] = 14+$game_date.dateAmt
					$story_stats["BackStreetArrearsPrincipal"] = 20000*$game_temp.choice
					$story_stats["BackStreetArrearsInterest"] = 0
					tmpTotal = $story_stats["BackStreetArrearsPrincipal"] * tmpMult
					tmpDec = tmpTotal - $story_stats["BackStreetArrearsPrincipal"]
					tmpReward= $story_stats["BackStreetArrearsPrincipal"] - tmpDec
					optain_item_chain(tmpReward,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
					call_msg("TagMapNoerBackStreet:FishTraderREP/Arrears_accept")
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

			call_msg("TagMapNoerBackStreet:FishTraderREP/Arrears_return_opt",0,2,0)
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
						$game_variables[1] =0
						call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info")
				when "PawnItems"
						call_msg("TagMapNoerBackStreet:HappyTrader/Arrears_info")
						SceneManager.goto(Scene_ItemStorage)
						SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
						call_msg("TagMapNoerBackStreet:FishTraderREP/opt_AboutArrears")
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


		 #OPT 交易點　ＯＲ　物品
end #case


if $story_stats["BackStreetArrearsPrincipal"] <= 0
	$story_stats["BackStreetArrearsPrincipal"]=0
	$story_stats["BackStreetArrearsInterest"] = 0
	$story_stats["BackStreetArrearsPrepayDateAMT"] =0
	if !$game_player.player_slave?
		$story_stats["Captured"] = 0
		$story_stats["RapeLoop"] = 0
		$story_stats["RapeLoopTorture"] = 0
	end
end


#clearn up Arrears
#$story_stats["Captured"] = 0
#$story_stats["RapeLoop"] = 0
#$story_stats["RapeLoopTorture"] = 0
#$story_stats["BackStreetArrearsPrepayDateAMT"] =0
#$story_stats["BackStreetArrearsPrincipal"] = 0
#$story_stats["BackStreetArrearsInterest"] = 0

$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT3"] = "0"
$story_stats["HiddenOPT4"] = "0"
eventPlayEnd
return get_character(0).call_balloon(28,-1) if $story_stats["BackStreetArrearsPrincipal"] != 0
return get_character(0).call_balloon(28,-1) if $story_stats["BackStreetArrearsInterest"] != 0
