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
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_FacePunch"
p "race not support this event" if !["Orkind","Human","Deepone","Moot","Fishkind","Goblin","Troll"].include?($game_player.actor.stat["EventMouthRace"])
$game_portraits.lprt.hide

chcg_background_color
#half_event_key_cleaner
temp_EventMouthRace = $game_player.actor.stat["EventMouthRace"] #RACE需求防呆編碼
$game_player.actor.stat["EventMouthRace"] = "Human" if $game_player.actor.stat["EventMouthRace"] == nil #RACE需求防呆編碼
chcg_decider_basic(pose=5)
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="FacePunch1"
$game_player.actor.stat["HeadGround"] = 1
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -187 ; $game_player.actor.stat["chcg_y"] = -153
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/FacePunch_begin]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
SndLib.sound_punch_hit(100)
$game_player.actor.stat["EventMouth"] ="FacePunch2"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = -124 ; $game_player.actor.stat["chcg_y"] = -129
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/FacePunch_control.rb")
check_over_event
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
$game_player.actor.stat["EventMouth"] ="FacePunch2"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = -124 ; $game_player.actor.stat["chcg_y"] = -129
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/FacePunch_control.rb")
check_over_event
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
$game_player.actor.stat["EventMouth"] ="FacePunch2"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = -124 ; $game_player.actor.stat["chcg_y"] = -129
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/FacePunch_control.rb")
check_over_event
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
#$game_player.actor.stat["EventMouth"] = "FacePunch3"
#$game_player.actor.stat["HeadGround"] = 0
#lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
#$game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98
#$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
#$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#$game_player.actor.portrait.shake
##message control
#$game_message.add("\\t[commonH:Lona/FacePunch_end]")
#$game_map.interpreter.wait_for_message
#######################################################################################
#$game_player.actor.stat["EventMouth"] = "FacePunch3"
#$game_player.actor.stat["HeadGround"] = 0
#lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
#$game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98
#$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
#$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
##message control
#$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
#$game_map.interpreter.wait_for_message
######################################################################################
$game_player.actor.stat["EventMouth"] = "FacePunch3"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
call_msg("commonH:Lona/frame_overfatigue#{rand(10)}")
#$game_message.add("\\t[commonH:Lona/FacePunch_end2#{talk_style}]")
#$game_map.interpreter.wait_for_message
$game_player.actor.stat["EventMouth"] = nil
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$game_player.actor.stat["EventMouthRace"] = temp_EventMouthRace #RACE需求防呆編碼
$game_player.actor.stat["HeadGround"] = 0 #return to default
$game_player.actor.stat["EventMouth"] = nil
$story_stats["sex_record_torture"] +=1
half_event_key_cleaner
chcg_background_color_off
