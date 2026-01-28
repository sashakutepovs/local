if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
 if $game_actors[1].sensitivity_mouth >=5 || $game_actors[1].state_stack(102) !=0 || $game_player.actor.stat["AsVulva_Esophageal"] ==1
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Mouth" 
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_ForceFeed"
$game_portraits.lprt.hide

#removed race key 18 8 23
chcg_background_color
#half_event_key_cleaner
temp_EventMouthRace = $game_player.actor.stat["EventMouthRace"] #RACE需求防呆編碼
$game_player.actor.stat["EventMouthRace"] = "Human" if $game_player.actor.stat["EventMouthRace"] == nil #RACE需求防呆編碼
chcg_decider_basic(pose=5)
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding1"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -240 ; $game_player.actor.stat["chcg_y"] = -132
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 7
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_begin1")
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding2"
$game_player.actor.stat["HeadGround"] = 1
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -142 ; $game_player.actor.stat["chcg_y"] = -154
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 1
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_begin2")
######################################################################## FEED FRAME ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding3"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -142 ; $game_player.actor.stat["chcg_y"] = -154
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 5
$game_player.actor.portrait.update
#message control
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch1")
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch2")
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch3")
########################################################################第一次空碗###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding6"
$game_player.actor.stat["HeadGround"] = 1
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -240 ; $game_player.actor.stat["chcg_y"] = -132
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 2
$game_player.actor.stat["eyes"] = 2
$game_player.actor.stat["subeyes"] = 1
$game_player.actor.stat["eyes_tear"] = 1
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_begin3")
########################################################################第二次餵食 begin ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding7"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -240 ; $game_player.actor.stat["chcg_y"] = -132
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 6
$game_player.actor.stat["eyes_tear"] = 1
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_begin4")
########################################################################第二次餵食 begin ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding4"
$game_player.actor.stat["HeadGround"] = 1
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -240 ; $game_player.actor.stat["chcg_y"] = -132
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 1
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_begin5")
########################################################################第二次餵食 begin ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding5"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -142 ; $game_player.actor.stat["chcg_y"] = -154
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 4
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_begin6")
########################################################################第二次餵食 go ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding3"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -142 ; $game_player.actor.stat["chcg_y"] = -154
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 5
$game_player.actor.stat["eyes_tear"] = 1
$game_player.actor.stat["eyes_shock"] = 1
$game_player.actor.portrait.update
#message control
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch1")
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch2")
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch3")
########################################################################第3次餵食 begin ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding6"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = -240 ; $game_player.actor.stat["chcg_y"] = -132
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_begin7")
########################################################################第3次餵食 ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding7"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -142 ; $game_player.actor.stat["chcg_y"] = -154
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_begin3")
########################################################################第3次餵食 NANI?! AGAIN? ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding4"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -240 ; $game_player.actor.stat["chcg_y"] = -132
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 1
$game_player.actor.stat["eyes"] = 1
$game_player.actor.stat["subeyes"] = 1
$game_player.actor.stat["eyes_tear"] = 1
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_end")
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_end1")
########################################################################第3次餵食 NANI?! AGAIN? ###################################################################################################
$game_player.actor.stat["EventMouth"] ="ForceFeeding4"
$game_player.actor.stat["HeadGround"] = 0
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -240 ; $game_player.actor.stat["chcg_y"] = -132
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.stat["mouth"] = 5
$game_player.actor.stat["eyes"] = 2
$game_player.actor.stat["subeyes"] = 1
$game_player.actor.stat["eyes_tear"] = 1
$game_player.actor.portrait.update
#message control
$game_player.actor.portrait.shake
call_msg("commonH:Lona/ForceFeeding_end2")
$game_portraits.lprt.hide
$game_portraits.rprt.hide
$game_map.interpreter.chcg_background_color(0,0,0,255)
call_msg("commonH:Lona/ForceFeedingRunBatch_end")
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch1_end")
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch2_end")
load_script("Data/Batch/ForceFeeding_control.rb")
call_msg("commonH:Lona/ForceFeedingRunBatch3_end")
check_half_over_event
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$game_player.actor.stat["EventMouthRace"] = temp_EventMouthRace #RACE需求防呆編碼
$game_player.actor.stat["HeadGround"] = 0 #return to default
$game_player.actor.stat["EventMouth"] = nil
$story_stats["sex_record_mouth_count"]+=1
half_event_key_cleaner
chcg_background_color_off
