if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0 || $game_actors[1].state_stack(43) == 1 || $game_player.actor.stat["AsVulva_Anal"] == 1
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture" if $game_actors[1].state_stack(106) !=0 && $game_actors[1].state_stack(43) !=1
$game_player.actor.stat["EventTargetPart"] = "Anal" if $game_actors[1].state_stack(43) ==1
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_AnalBeads"
$game_portraits.lprt.hide

chcg_background_color
#half_event_key_cleaner
temp_bellysize = $game_player.actor.stat["preg"]
chcg_decider_basic(pose=2)
$game_player.actor.stat["analopen"] = 0
########################################################################frame 0 至中畫面 準備撥放###################################################################################################
$game_player.actor.stat["EventAnal"] ="AnalBeads1"
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -202 ; $game_player.actor.stat["chcg_y"] = -39
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/AnalBeads_begin1]")
$game_map.interpreter.wait_for_message
##################################################################
$game_player.actor.stat["EventAnal"] ="AnalBeads1"
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/AnalBeads_begin2]")
$game_map.interpreter.wait_for_message

##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads2B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads2"
end
$game_player.actor.stat["analopen"] = 1
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -190; $game_player.actor.stat["chcg_y"] = -62
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
$story_stats.sex_record_anal(["DataNpcName:part/beads"])
$story_stats["sex_record_anal_count"] +=1
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_miror health damage
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads2B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads2"
end
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -117 ; $game_player.actor.stat["chcg_y"] = -41
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads3B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads3"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -190; $game_player.actor.stat["chcg_y"] = -62
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads3B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads3"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $game_player.actor.stat["preg"] !=3 then $game_player.actor.stat["preg"] +=1 end
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads4B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads4"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -190; $game_player.actor.stat["chcg_y"] = -62
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads4B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads4"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $game_player.actor.stat["preg"] !=3 then $game_player.actor.stat["preg"] +=1 end
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads5B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads5"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -190; $game_player.actor.stat["chcg_y"] = -62
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_message.add("\\t[commonH:Lona/AnalBeads_begin3_normal]") 
else
$game_message.add("\\t[commonH:Lona/AnalBeads_begin3_damaged]")
end
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads5B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads5"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $game_player.actor.stat["preg"] !=3 then $game_player.actor.stat["preg"] +=1 end
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads6B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads6"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -190; $game_player.actor.stat["chcg_y"] = -62
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads6B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads6"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
$game_player.actor.stat["analopen"] = 0
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads7B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads7"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -190; $game_player.actor.stat["chcg_y"] = -62
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads7B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads7"
end
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads7B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads7"
end
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/AnalBeads_begin4]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads7B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads7"
end
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -165 ; $game_player.actor.stat["chcg_y"] = -58
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
$game_map.interpreter.wait_for_message
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
##############################################################################################################################################################################
$game_player.actor.stat["analopen"] = 1
if $game_player.actor.stat["preg"] !=3 then $game_player.actor.stat["preg"] +=1 end
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads8B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads8"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -190; $game_player.actor.stat["chcg_y"] = -62
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads8B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads8"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $game_player.actor.stat["preg"] != temp_bellysize then $game_player.actor.stat["preg"] -=1 end
if $game_player.actor.stat["preg"] !=3 then $game_player.actor.stat["preg"] +=1 end
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads9B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads9"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -190; $game_player.actor.stat["chcg_y"] = -62
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads9B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads9"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
SndLib.sound_chs_dopyu(rand(20)+80,rand(50)+50)
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads10B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads10"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
SndLib.sound_chs_dopyu(rand(20)+80,rand(50)+50)
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads11B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads11"
end
lona_mood "chcg2fuck_cuming_ahegao"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -209 ; $game_player.actor.stat["chcg_y"] = -73
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
SndLib.sound_chs_dopyu(rand(20)+80,rand(50)+50)
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/AnalBeads_begin5]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads10B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads10"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
SndLib.sound_chs_dopyu(rand(20)+80,rand(50)+50)
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads11B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads11"
end
lona_mood "chcg2fuck_cuming_ahegao"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -209 ; $game_player.actor.stat["chcg_y"] = -73
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
SndLib.sound_chs_dopyu(rand(20)+80,rand(50)+50)
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/AnalBeads_begin5]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads10B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads10"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
SndLib.sound_chs_dopyu(rand(20)+80,rand(50)+50)
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads11B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads11"
end
lona_mood "chcg2fuck_cuming_ahegao"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -209 ; $game_player.actor.stat["chcg_y"] = -73
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
SndLib.sound_chs_dopyu(rand(20)+80,rand(50)+50)
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/AnalBeads_begin5]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads10B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads10"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -75
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
SndLib.sound_chs_dopyu(rand(20)+80,rand(50)+50)
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $game_player.actor.stat["preg"] != temp_bellysize then $game_player.actor.stat["preg"] -=1 end
if $game_player.actor.stat["preg"] != temp_bellysize then $game_player.actor.stat["preg"] -=1 end
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads12B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads12"
end
lona_mood "chcg2fuck_cuming_ahegao"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -212 ; $game_player.actor.stat["chcg_y"] = -50
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch1
#stats_batch2
load_script("Data/Batch/AnalBeads_control.rb")
#stats_batch4
#stats_batch5
check_over_event
#message control
SndLib.sound_chs_dopyu(100,rand(50)+50)
SndLib.sound_chcg_AnalBead(100,rand(50)+20)
SndLib.sound_chcg_AnalBead(100,10)
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/AnalBeads_begin6]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads12B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads12"
end
lona_mood "chcg2fuck_cuming_ahegao"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -169 ; $game_player.actor.stat["chcg_y"] = -51
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################################################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalBeads12B"
else
$game_player.actor.stat["EventAnal"] ="AnalBeads12"
end
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -62 ; $game_player.actor.stat["chcg_y"] = -35
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/AnalBeads_end#{talk_style}]")
$game_map.interpreter.wait_for_message
##############################################################################
$story_stats["sex_record_anal_dilatation"] +=1
$story_stats["sex_record_analbeads"] +=1
$game_actors[1].defecate_level += 500
$game_player.actor.stat["preg"] = temp_bellysize


check_over_event
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

half_event_key_cleaner
chcg_background_color_off
