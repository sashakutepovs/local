if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if $story_stats["RecQuestTeller"] == 0
	$story_stats["RecQuestTeller"] = 1
	call_msg("TagMapNoerRecRoom:teller/Unknow0")
end

tmpYourChild = $game_player.actor.stat["RaceRecord"] == "Abomination" && !$game_player.actor.skill_learn?($data_skills[67]) #BasicAbomEatDed
tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
tmpQuestList << [$game_text["commonNPC:commonNPC/Yes"]					,"RecEvent"]
tmpQuestList << [$game_text["CompTeller:AbomRebirth/opt_rebirth"]		,"YourChild"] if tmpYourChild
cmd_sheet = tmpQuestList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
if $game_player.actor.stat["RaceRecord"] == "Abomination"
	call_msg("CompTeller:AbomRebirth/beginIfAbom",0,2,0)
else
	call_msg("TagMapNoerRecRoom:teller/opt",0,2,0)
end
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1


case tmpPicked
	when "RecEvent"
		portrait_off
		tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("Cannon")
		get_character(tmpCurID).start
		
	when "YourChild"
		call_msg("CompTeller:AbomRebirth/ans_rebirth0")
		get_character(0).npc_story_mode(true)
			portrait_hide
			get_character(0).animation = get_character(0).animation_hold_casting_sh
			SndLib.sound_FlameCast(80)
			wait(60)
			SndLib.sound_FlameCast(80)
			wait(60)
			EvLib.sum("EffectLifeBuffRev",$game_player.x,$game_player.y)
			SndLib.buff_life(80)
			get_character(0).animation = get_character(0).animation_casting_mh
			wait(60)
			$game_player.call_balloon(8)
			wait(60)
		get_character(0).npc_story_mode(false)
		call_msg("CompTeller:AbomRebirth/ans_rebirth1")
		GabeSDK.getAchievement("AbomLona")
		$game_player.actor.learn_skill("BasicAbomGrab") #66
		$game_player.actor.learn_skill("BasicAbomEatDed") #67
	end

eventPlayEnd
