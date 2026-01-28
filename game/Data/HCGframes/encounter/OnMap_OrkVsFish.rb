[true,false].sample ? SndLib.sound_goblin_spot : SndLib.FishkindSmSpot
tmp1 = $game_text["DataNpcName:group/OrkindCave"]
tmp2 = $game_text["DataNpcName:group/FishkindCave"]

tmpGotoTar = ""
tmpQuestList = []
tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Leave"]			,"Options_Leave"]	
tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Approach"]		,"Options_Approach"]
tmpQuestList << [$game_text["OvermapEvents:Lona/Options_Kyaaah"]		,"Options_Kyaaah"]	
cmd_sheet = tmpQuestList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
$game_player.actor.prtmood("confused")
$cg = TempCG.new(["map_VS"])
call_msg("#{tmp1} VS #{tmp2}",0,2,0)
chcg_background_color(0,0,0,255,-15) if @chcg_background_color
call_msg("#{$game_text["OvermapEvents:Lona/Options"]}\\optD[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1

case tmpPicked
	when "Options_Approach"
		enter_tag_map = true
	when "Options_Kyaaah"
		$story_stats["OverMapEvent_saw"] =1
		$game_player.actor.sta = -99 
		call_msg("OvermapEvents:Lona/OvermapSlip")
		enter_tag_map = 1
end
$cg.erase

if enter_tag_map
	$story_stats["OverMapEvent_saw"] == 0
	$story_stats["OverMapEvent_name"] = "Custom"
	$story_stats["OverMapEvent_SosName"] = [
	
	#loop?,WildDanger,SpawnRace,BackGround
	1,10000,["Orkind","Fishkind"].sample,"FishkindMessy",
	
	#QuestTarSpawn,SumVal,Region[x,x,x]
	["RandomOrkindGroup",1,nil],
	["RandomFishkindGroup",1,nil]
	]
	change_map_enter_region
else
	$story_stats["WildDangerous"] =0
	$story_stats["OverMapEvent_name"] =0
	$story_stats["OverMapEvent_saw"] =0
	$story_stats["OverMapEvent_enemy"] =0
	$story_stats["RegionMap_Background"] = 0
end
eventPlayEnd