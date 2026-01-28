if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
########################################## thos should move to all relay
if $game_player.record_companion_name_ext == "CompHorseCarry"
	SndLib.horseIdle
	get_character(0).call_balloon(2)
	return eventPlayEnd
end
get_character(0).animation = nil
SndLib.horseIdle
tpNeed = 100
$story_stats["HiddenOPT1"] = tpNeed
call_msg("commonComp:CompHorseCarry/CompData")
$story_stats["HiddenOPT1"] = "0"
call_msg("common:Lona/Decide_optB")
set_comp=false
if $game_temp.choice ==1 && $game_player.record_companion_name_ext == nil
	set_comp = true
elsif $game_temp.choice ==1 && $game_player.record_companion_name_ext != nil
	$game_temp.choice = -1
	call_msg("commonComp:notice/ExtOverWrite")
	call_msg("common:Lona/Decide_optD")
	if $game_temp.choice ==1
		set_comp = true
	else
		return eventPlayEnd
	end
else
	return eventPlayEnd
end



$game_boxes.box(System_Settings::STORAGE_TEMP).clear
SceneManager.goto(Scene_ItemStorage)
SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
wait(1)
tmpPP = $game_boxes.get_price(System_Settings::STORAGE_TEMP)
$game_boxes.box(System_Settings::STORAGE_TEMP).clear
dateAmt = tmpPP/tpNeed
return eventPlayEnd if dateAmt < 1
if set_comp
	chcg_background_color(0,0,0,0,7)
		$story_stats["RecQuestConvoyTarget"] = [21,22] #Inside Noer
		$game_boxes.box(System_Settings::STORAGE_HORSE_CARRY).clear
		get_character(0).set_this_event_companion_ext(temp_name="CompHorseCarry",false, date_amt=dateAmt+$game_date.dateAmt)
		EvLib.sum("CompHorseCarry",$game_player.x,$game_player.y)
		SndLib.horseDed
		#get_character(0).delete ############################################################################################## if for relay
	chcg_background_color(0,0,0,255,-7)
end
eventPlayEnd