if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if $game_player.actor.weak >= 25 || $game_player.actor.stat["SlaveBrand"] == 1
	call_msg("TagMapPB_FishCampA:ConvoyTar/TooWeak")
	return eventPlayEnd
end
tmpSetComp = false
call_msg("TagMapPB_FishCampA:ConvoyTar/About_opt")
tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonNPC:commonNPC/Cancel"]									,"cancel"]
tmpQuestList << [$game_text["TagMapPB_FishCampA:ConvoyTar/OPT_WhyFishHereAise"]				,"OPT_WhyFishHere"]
tmpQuestList << [$game_text["TagMapPB_FishCampA:ConvoyTar/OPT_OutControll"]					,"OPT_OutControll"]
tmpQuestList << [$game_text["TagMapPB_FishCampA:ConvoyTar/OPT_CaveExplore"]					,"OPT_CaveExplore"]  if $story_stats["RecQuestAriseVillageFish"] < 100
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
	when "OPT_WhyFishHere"
		call_msg("TagMapPB_FishCampA:ConvoyTar/WhyFishHereAise0")
	when "OPT_OutControll"
		call_msg("TagMapPB_FishCampA:ConvoyTar/OPT_OutControll0")
	when "OPT_CaveExplore"
		call_msg("TagMapPB_FishCampA:ConvoyTar/OPT_CaveExplore0")
		call_msg("TagMapPB_FishCampA:ConvoyTar/OPT_CaveExplore_BRD")
		call_msg("common:Lona/Decide_optB")
		if $game_temp.choice == 1
			call_msg("TagMapPB_FishCampA:ConvoyTar/OPT_CaveExplore_Y")
			tmpSetComp = true
			if tmpSetComp == true && $game_player.record_companion_name_ext != nil
				$game_temp.choice = -1
				call_msg("commonComp:notice/ExtOverWrite")
				call_msg("common:Lona/Decide_optD")
				if $game_temp.choice ==1
					tmpSetComp = true
				else
					tmpAggro = false
					tmpSetComp = false
					tmpSummonFish = false
				end
			end
		else
			call_msg("TagMapPB_FishCampA:ConvoyTar/OPT_CaveExplore_N")
		end
end

if tmpSetComp
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		$story_stats["RecQuestAriseVillageFish"] = 2
		get_character(0).set_this_event_companion_ext("AriseVillageCompExtConvoy",false,10+$game_date.dateAmt)	
		get_character(0).delete
		$game_map.reserve_summon_event("AriseVillageCompExtConvoy",$game_player.x,$game_player.y-1)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapPB_FishCampA:ConvoyTar/OPT_CaveExplore_BRD")
	#call_msg("TagMapAriseVillage:AriseVillage/0to1_Fishman2_joined")
end

eventPlayEnd

return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestAriseVillageFish"] < 100
