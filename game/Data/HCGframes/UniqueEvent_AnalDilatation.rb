if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0 || $game_actors[1].state_stack(43) ==1 || $game_player.actor.stat["AsVulva_Anal"] == 1
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture" if $game_actors[1].state_stack(106) !=0 && $game_actors[1].state_stack(43) !=1
$game_player.actor.stat["EventTargetPart"] = "Anal" if $game_actors[1].state_stack(43) ==1
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_AnalDilatation"
$game_portraits.lprt.hide


chcg_background_color
#half_event_key_cleaner
temp_bellysize = $game_player.actor.stat["preg"]
temp_bellysize_control = 1+$game_player.actor.stat["preg"] 
if temp_bellysize_control >=4 then temp_bellysize_control =3 end

temp_EventAnalRace = $game_player.actor.stat["EventAnalRace"] #RACE需求防呆編碼
$game_player.actor.stat["EventAnalRace"] = "Human" if $game_player.actor.stat["EventAnalRace"] == nil #RACE需求防呆編碼

chcg_decider_basic(pose=2)
$game_player.actor.stat["analopen"] = 0
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventAnal"] ="AnalDilatation1"
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -199 ; $game_player.actor.stat["chcg_y"] = -74
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/AnalDilatation_begin1]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventAnal"] ="AnalDilatation1"
lona_mood "chcg2fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -46
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/AnalDilatation_begin2]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
$game_player.actor.stat["analopen"] = 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
$story_stats.sex_record_anal(["DataNpcName:race/#{$game_player.actor.stat["EventAnalRace"]}" , "DataNpcName:part/arm"])
$story_stats["sex_record_anal_count"] +=1
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation2B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_message.add("\\t[commonH:Lona/AnalDilatation_begin3_normal]")
else
$game_message.add("\\t[commonH:Lona/AnalDilatation_begin3_damaged]")
end
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation2B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation2B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation2B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation2B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation2B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation2"
end
lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -44
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/AnalDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 1###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation3B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation3"
end
lona_mood "chcg2fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -81
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation3B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation3"
end
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -81
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################
if $story_stats["sex_record_anal_dilatation"].between?(0,14)&&$game_actors[1].state_stack(43) < 1
$game_player.actor.stat["EventAnal"] ="AnalDilatation3B"
else
$game_player.actor.stat["EventAnal"] ="AnalDilatation3"
end
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -81
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$game_player.actor.stat["EventAnalRace"] = temp_EventAnalRace #RACE需求防呆編碼
$game_player.actor.stat["analopen"] =0
$story_stats["sex_record_anal_dilatation"] +=1
half_event_key_cleaner
chcg_background_color_off
