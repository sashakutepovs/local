tmpQ1 = $story_stats["RecQuestElise"] == 17
tmpQ2 = $game_player.record_companion_name_ext == "CompExtUniqueElise"
tmpQ3 = $story_stats["UniqueCharUniqueElise"] != -1
tmpQ4 = $game_party.has_item?($data_items[120])
if tmpQ1 && tmpQ2 && tmpQ3 && !tmpQ4
 call_msg("CompElise:FishResearch1/17_exit_failed")
 eventPlayEnd
elsif tmpQ1 && tmpQ2 && tmpQ3 && tmpQ4
 tmpEliseID=$game_player.get_followerID(-1)
 if get_character(tmpEliseID).region_id == 50
  call_msg("CompElise:FishResearch1/17_exit_success")
  call_msg("CompElise:FishResearch1/17_exit_success2")
  eventPlayEnd
  change_map_tag_map_exit(true)
 else
  SndLib.sys_buzzer
  call_msg_popup("CompElise:FishResearch1/17_exit_failedQMSG")
 end
else
 change_map_tag_map_exit(true)
end