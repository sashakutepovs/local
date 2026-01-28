
get_character(0).summon_data[:MT_crunch] = false
get_character(0).call_balloon(0)
get_character(0).trigger = -1
SndLib.sound_QuickDialog
call_msg_popup("TagMapMT_crunch:DcSearch/Qmsg#{rand(3)}",0)
$game_player.animation = $game_player.animation_mc_pick_up


tmpDoAction = $game_map.events.any?{|event|
	next if !event[1].summon_data
	next unless event[1].summon_data[:MT_crunch]
	true
}
if !tmpDoAction
	$story_stats["RecQuestMT_findDoc"] = 3
	call_msg("TagMapMT_crunch:DcSearch/Done0")
end
eventPlayEnd