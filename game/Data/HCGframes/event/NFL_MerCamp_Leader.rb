


if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $story_stats["NFL_MerCamp_Invade"] == 1 || $story_stats["UniqueChar_NFL_MerCamp_Leader"] == -1
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapNFL_MerCamp:Leader/BattleQmsg#{rand(2)}",get_character(0).id)
	return
end

if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 1
	call_msg("TagMapNFL_MerCamp:Leader/RecQuestNorthFL_AtkOrkCamp2_1")
	$story_stats["RecQuestNorthFL_AtkOrkCamp2"] = 2
end

if $story_stats["NFL_MerCamp_Invade"] == 2
	$story_stats["NFL_MerCamp_Invade"] = 3
	call_msg("TagMapNFL_MerCamp:Invade/NFL_MerCamp_Invade_3")
	optain_exp(12000)
	
elsif $story_stats["RecQuestNorthFL_AtkOrkCamp2"] >= 2
	$game_temp.choice = 0
	tmpPicked = ""
	until tmpPicked == "Cancel" || $game_temp.choice == -1
		tmpQuestList = []
		tmpQuestList << [$game_text["commonNPC:commonNPC/Cancel"]					,"Cancel"]
		tmpQuestList << [$game_text["commonNPC:commonNPC/About"]					,"OPT_About"]
		tmpQuestList << [$game_text["DataItem:QuestRecQuestNorthFL4/item_name"]		,"OPT_Mail"]	if [3].include?($story_stats["RecQuestNorthFL_AtkOrkCamp2"]) && $story_stats["RecQuestNorthFL_Main"] == 7
		tmpQuestList << [$game_text["commonNPC:commonNPC/Work"]						,"OPT_Work"]	if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 4
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
		end
		call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
		call_msg("\\optB[#{cmd_text}]")
		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		
		case tmpPicked
			when "OPT_About"
				call_msg("TagMapNFL_MerCamp:Leader/OPT_About0")
				$story_stats["RecQuestNorthFL_AtkOrkCamp2"] = 3 if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 2
				
				break if $story_stats["NFL_MerCamp_Invade"] == 0
				
			when "OPT_Mail"
				$story_stats["RecQuestNorthFL_AtkOrkCamp2"] = 4 if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 3
				call_msg("TagMapNFL_MerCamp:Leader/OPT_Mail0")
				portrait_fade
				optain_lose_item("ItemQuestRecQuestNorthFL4",1)
				$game_player.animation = $game_player.animation_atk_sh
				wait(60)
				2.times{
					get_character(0).call_balloon(8)
					wait(60)
				}
				call_msg("TagMapNFL_MerCamp:Leader/OPT_Mail1")
				break if $story_stats["NFL_MerCamp_Invade"] == 0
				
			when "OPT_Work"
				$game_temp.choice = 0
				call_msg("TagMapNFL_MerCamp:Leader/OPT_Work0")
				call_msg("TagMapNFL_MerCamp:Leader/OPT_Work1_board")
				call_msg("common:Lona/Decide_optB")
				if $game_temp.choice == 1
					call_msg("TagMapNFL_MerCamp:Leader/OPT_Work2_accept")
					$story_stats["RecQuestNorthFL_AtkOrkCamp2"] = 100 if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 4
					$story_stats["NFL_MerCamp_SaveDog"] = 1 if $story_stats["NFL_MerCamp_SaveDog"] == 0
					$story_stats["NFL_MerCamp_SaveDogAMT"] = $game_date.dateAmt+4
					call_msg("TagMapNFL_MerCamp:Leader/OPT_Work2_accept1")
					portrait_hide
					chcg_background_color(0,0,0,0,7)
						portrait_off
						get_character(0).delete
						$game_map.npcs.each{|event|
							next unless event.summon_data
							next unless event.summon_data[:HumanGuards]
							event.delete
						}
						SndLib.sys_StepChangeMap
					chcg_background_color(0,0,0,255,-7)
				else
					call_msg("TagMapNFL_MerCamp:Leader/OPT_Work2_no")
				end
				break
		end
	end
else
	call_msg("TagMapNFL_MerCamp:Leader/OPT_Work0")
end


if $story_stats["NFL_MerCamp_Invade"] == 0
	get_character(0).prelock_direction = 6
	$story_stats["NFL_MerCamp_Invade"] = 1
	$story_stats["OnRegionMapSpawnRace"] = "Goblin"
	
	portrait_fade
	$game_map.interpreter.screen.start_shake(1,7,60)
	SndLib.sound_FlameCast(60,70)
	wait(30)
	get_character(0).call_balloon(1)
	$game_player.call_balloon(1)
	wait(90)
	call_msg("TagMapNFL_MerCamp:Invade/0")
	tmpAniArr = [
		[11,5,2 ,0 ,1]
	]
	SndLib.sound_FlameCast(100,70)
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	$game_map.interpreter.screen.start_shake(5,10,60)
	portrait_fade
	wait(60)
	get_character(0).call_balloon(8)
	wait(60)
	get_character(0).animation = nil
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:HumanGuards]
		next unless [nil,:none].include?(event.npc.action_state)
		event.summon_data[:tmpDir] = event.direction
		event.turn_toward_character(get_character(0))
	}
	call_msg("TagMapNFL_MerCamp:Invade/1")
	get_character(0).direction = 6
	get_character(0).animation = get_character(0).aniCustom([[8, 6, 4, 1,0], [8, 6, 2, 0, 0], ],-1)
	call_msg("TagMapNFL_MerCamp:Invade/2#{talk_persona}")
	tmpPotX,tmpPotY=$game_map.get_storypoint("Pot")
	tmpInvadePTTX,tmpInvadePTTY=$game_map.get_storypoint("InvadePTT")
	tmpInvadePTDX,tmpInvadePTDY=$game_map.get_storypoint("InvadePTD")
	tmpInvadePTLX,tmpInvadePTLY=$game_map.get_storypoint("InvadePTL")
	tmpInvadePTRX,tmpInvadePTRY=$game_map.get_storypoint("InvadePTR")
	tmpPT1X,tmpPT1Y=$game_map.get_storypoint("PT1")
	tmpYellingSubX,tmpYellingSubY,tmpYellingSubID=$game_map.get_storypoint("YellingSub")
	tmpMapContID=$game_map.get_storypoint("MapCont")[2]
	set_event_force_page(tmpMapContID,2)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		SndLib.bgm_play("D/Action Combat Orchestral Theme 5 (Looped)",80,90)
		SndLib.bgs_stop
		SndLib.bgs_play("forest_wind",20,100)
		get_character(tmpYellingSubID).moveto(tmpPotX+1,tmpPotY+1) if [nil,:none].include?(get_character(tmpYellingSubID).npc.action_state)
		get_character(tmpYellingSubID).direction = 6 if [nil,:none].include?(get_character(tmpYellingSubID).npc.action_state)
		get_character(0).animation = nil
		get_character(0).moveto(tmpPotX+3,tmpPotY+1)
		get_character(0).direction = 6
		get_character(0).set_original_direction(6)
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:HumanGuards]
			next unless [nil,:none].include?(event.npc.action_state)
			event.direction = event.summon_data[:tmpDir] if event.summon_data[:tmpDir]
			event.summon_data[:tmpDir] = nil
		}
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:Wave1]
			next unless [nil,:none].include?(event.npc.action_state)
			event.summon_data[:WildnessNapEvent] = "Goblin"
			event.moveto(tmpInvadePTRX,tmpInvadePTRY)
			event.set_manual_move_type(3)
			event.move_type = 3
		}
	chcg_background_color(0,0,0,255,-7)
end


eventPlayEnd
return if $story_stats["NFL_MerCamp_Invade"] == 1
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 1
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 3 && $story_stats["RecQuestNorthFL_Main"] == 7
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestNorthFL_AtkOrkCamp2"] == 4
return get_character(0).call_balloon(28,-1) if $story_stats["NFL_MerCamp_Invade"] == 2



