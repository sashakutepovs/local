return SndLib.sys_trigger if $story_stats["UniqueCharUniqueOgreWarBoss"] == -1
return SndLib.sys_trigger if $story_stats["RapeLoop"] == 0
tmpMove_type = $game_player.actor.master.move_type
$game_player.actor.master.npc_story_mode(true)
$game_player.actor.master.move_type = 0
get_character(0).npc_story_mode(true)


call_msg("TagMapSyb_WarBossRoom:Butcher/begin1")

tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]							,"Cancel"]
tmpTarList << [$game_text["TagMapSyb_WarBossRoom:Warboss/rapeloop_OPT_Feed"]	,"rapeloop_OPT_Feed"]
cmd_sheet = tmpTarList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
##call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1

case tmpPicked
	when "rapeloop_OPT_Feed"
		$game_player.actor.sta -= 30
		$game_player.actor.stat["EventMouthRace"] = "Orkind"
		load_script("Data/HCGframes/UniqueEvent_ForceFeed.rb")
		whole_event_end
end

$game_player.actor.master.move_type = tmpMove_type
$game_player.actor.master.npc_story_mode(false)
$game_player.animation = nil

get_character(0).npc_story_mode(false)
get_character(0).animation = nil
eventPlayEnd
