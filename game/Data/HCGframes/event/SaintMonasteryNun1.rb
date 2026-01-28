if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpGetRewardRecQuestMT_crunch = false

get_character(0).call_balloon(0)
get_character(0).direction = 2
#tmpBeginTxt = $game_text["TagMapSaintMonastery:nun/keyBegin"]+$game_text["TagMapSaintMonastery:healer/Qmsg#{rand(4)}"]
#$game_message.add(tmpBeginTxt)
#$game_map.interpreter.wait_for_message

tmpTommyQu = $story_stats["RecQuestSMRefugeeCampFindChild"] == 2 && get_character(0).summon_data[:QuprogTommy] == 2
tmpToMT_crunch1 = $game_player.actor.weak < 25 && $story_stats["RecQuestSaintMonasteryToMT_crunch"] == 0
tmpToMT_crunch2 = [2,3].include?($story_stats["RecQuestSaintMonasteryToMT_crunch"]) && $story_stats["RecQuestMT_findDoc"] >= 3

tmpGotoTar = ""
tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]							,"Cancel"]
tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]							,"Barter"] if $story_stats["RecQuestCocona"] >= 15
tmpTarList << [$game_text["TagMapSaintMonastery:nun/opt_abandom_bb"]			,"opt_abandom_bb"]
tmpTarList << [$game_text["TagMapSaintMonastery:nun/opt_abandom_tommy"]			,"opt_abandom_tommy"] if tmpTommyQu
tmpTarList << [$game_text["TagMapSaintMonastery:nun/opt_TagMapMT_crunch"]		,"opt_TagMapMT_crunch"] if tmpToMT_crunch1 || tmpToMT_crunch2
cmd_sheet = tmpTarList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end

call_msg("TagMapSaintMonastery:MainNun/begin#{rand(3)}",0,2,0) if $story_stats["RecQuestCocona"] >= 15
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1

get_character(0).turn_toward_character($game_player)
case tmpPicked
	when "Barter"
		manual_barters("SaintMonasteryMainNun")

	when "opt_abandom_bb"
		call_msg("TagMapSaintMonastery:nun/abandom_bb0")
		if player_carry_LonaHumanoidBabies?
			call_msg("TagMapSaintMonastery:nun/abandom_bb1")
			tmp_bbCount = $game_party.lost_humanoid_baby
			$game_map.popup(0,"-#{tmp_bbCount}",$data_items[78].icon_index,-1)
			$game_player.animation = $game_player.animation_atk_sh
			SndLib.sys_equip
			wait(30)
			$game_player.call_balloon(8)
			wait(60)
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				SndLib.HumanBabyCry(70,120)
				wait(60)
				SndLib.HumanBabyCry(40,120)
				wait(60)
				SndLib.HumanBabyCry(20,120)
				wait(60)
				get_character(0).delete
			chcg_background_color(0,0,0,255,-7)
			$game_player.call_balloon(8)
			wait(60)
			call_msg("TagMapSaintMonastery:nun/abandom_bb2")
			$game_player.actor.mood -= 65535
			return eventPlayEnd
		else
			call_msg("TagMapSaintMonastery:nun/abandom_bb1_failed")
		end
		
	when "opt_abandom_tommy"
		get_character(0).call_balloon(0)
		$story_stats["RecQuestSMRefugeeCampFindChild"] = 3
		call_msg("TagMapSaintMonastery:MIAchildMAMA/prog2")
		$game_map.npcs.any?{|event|
			next if event.summon_data == nil
			next unless event.summon_data[:QuprogTommy] == 3
			next if event.actor.action_state == :death
			event.call_balloon(28,-1)
		}
		return eventPlayEnd
	
	
	when "opt_TagMapMT_crunch"
	if $game_player.actor.weak < 25 && $story_stats["RecQuestSaintMonasteryToMT_crunch"] == 0
		call_msg("TagMapSaintMonastery:ToMT_crunch/0")
			if $story_stats["RecQuestMT_findDoc"] >= 3 #若已與山脈修道院牧師對話過?
				tmpGetRewardRecQuestMT_crunch = true
				call_msg("TagMapSaintMonastery:ToMT_crunch/1_alreadyDid")
			else #進行任務
				call_msg("TagMapSaintMonastery:ToMT_crunch/0_brd")
				call_msg("common:Lona/Decide_optB")
				if $game_temp.choice == 1
					$story_stats["RecQuestSaintMonasteryToMT_crunch"] = 1
					call_msg("TagMapSaintMonastery:ToMT_crunch/0_accept")
				end
				
			end
		
		################################################################ 去山脈修道院找醫療 too weak
		elsif $game_player.actor.weak > 25 && $story_stats["RecQuestSaintMonasteryToMT_crunch"] == 0
			call_msg("TagMapSaintMonastery:ToMT_crunch/0_weak")
			
		################################################################ 去山脈修道院找醫療 Done
		elsif [2,3].include?($story_stats["RecQuestSaintMonasteryToMT_crunch"]) && $story_stats["RecQuestMT_findDoc"] >= 3
			call_msg("TagMapSaintMonastery:ToMT_crunch/1_alreadyDid")
			tmpGetRewardRecQuestMT_crunch = true
		end
end


if tmpGetRewardRecQuestMT_crunch
	optain_exp(2500)
	wait(30)
	optain_morality(1)
	$story_stats["RecQuestSaintMonasteryToMT_crunch"] = 4
end
eventPlayEnd
#check balloon
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSMRefugeeCampFindChild"] == 2 && get_character(0).summon_data[:QuprogTommy] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSaintMonasteryToMT_crunch"] == 0
return get_character(0).call_balloon(28,-1) if [2,3].include?($story_stats["RecQuestSaintMonasteryToMT_crunch"]) && $story_stats["RecQuestMT_findDoc"] >= 3
