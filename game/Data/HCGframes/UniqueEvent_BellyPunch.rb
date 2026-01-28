if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_BellyPunch"
$game_portraits.lprt.hide

#removed race key 18 8 23
chcg_background_color
#half_event_key_cleaner
chcg_decider_basic(pose=1)
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch0"
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -146 ; $game_player.actor.stat["chcg_y"] = -18
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/PunchEvent_begin]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch0"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -146 ; $game_player.actor.stat["chcg_y"] = -18
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch1"
lona_mood "chcg1fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -132 ; $game_player.actor.stat["chcg_y"] = -47
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/belly_punch_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch0"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -146 ; $game_player.actor.stat["chcg_y"] = -18
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch2"
lona_mood "chcg1fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -132 ; $game_player.actor.stat["chcg_y"] = -47
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/belly_punch_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch0"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -146 ; $game_player.actor.stat["chcg_y"] = -18
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch3"
lona_mood "chcg1fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -132 ; $game_player.actor.stat["chcg_y"] = -47
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/belly_punch_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch3"
lona_mood "chcg1fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -132 ; $game_player.actor.stat["chcg_y"] = -47
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventMouth"] ="Punch3"
lona_mood "chcg1fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -132 ; $game_player.actor.stat["chcg_y"] = -47
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] = "Punch0"
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/PunchEvent_end]")
$game_map.interpreter.wait_for_message
######################################################################################
$game_player.actor.stat["EventMouth"] = "Punch0"
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message
######################################################################################
$game_player.actor.stat["EventMouth"] = "Punch0"
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/PunchEvent_end#{talk_style}]")
$game_map.interpreter.wait_for_message
$game_player.actor.stat["EventMouth"] = nil
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$game_player.actor.stat["EventMouth"] = nil
$story_stats["sex_record_torture"] +=1
half_event_key_cleaner
chcg_background_color_off
