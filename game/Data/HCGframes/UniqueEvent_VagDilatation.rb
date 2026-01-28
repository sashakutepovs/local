if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0 || $game_actors[1].state_stack(41) !=0
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture" if $game_actors[1].state_stack(106) !=0 && $game_actors[1].state_stack(41) !=1
$game_player.actor.stat["EventTargetPart"] = "Vag" if $game_actors[1].state_stack(41) ==1
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_VagDilatation"
$game_portraits.lprt.hide

chcg_background_color
#half_event_key_cleaner
temp_bellysize = $game_player.actor.stat["preg"]
temp_bellysize_control = 1+$game_player.actor.stat["preg"] 
if temp_bellysize_control >=4 ; then temp_bellysize_control =3 end

temp_EventVagRace = $game_player.actor.stat["EventVagRace"] #RACE需求防呆編碼
$game_player.actor.stat["EventVagRace"] = "Human" if $game_player.actor.stat["EventVagRace"] == nil #RACE需求防呆編碼

chcg_decider_basic(pose=1)
$game_player.actor.stat["vagopen"] = 0
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] ="VagDilatation1"
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -150 ; $game_player.actor.stat["chcg_y"] = -55
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/VagDilatation_begin1]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] ="VagDilatation1"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -60 ; $game_player.actor.stat["chcg_y"] = -100
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/VagDilatation_begin2]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
$game_player.actor.stat["vagopen"] = 1
$game_player.actor.stat["EventVag"] ="VagDilatation2"
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
$story_stats.sex_record_vag(["DataNpcName:race/#{$game_player.actor.stat["EventVagRace"]}" , "DataNpcName:part/arm"])
$story_stats["sex_record_vaginal_count"] +=1
p "why here"
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
$game_player.actor.stat["EventVag"] ="VagDilatation2"
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
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
$game_player.actor.stat["EventVag"] ="VagDilatation2"
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
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
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation2B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation2"
end
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_message.add("\\t[commonH:Lona/VagDilatation_begin3_normal]")
else
$game_message.add("\\t[commonH:Lona/VagDilatation_begin3_damaged]")
end
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation2B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation2"
end
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
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
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation2B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation2"
end
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
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
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation2B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation2"
end
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
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
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation2B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation2"
end
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
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
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation2B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation2"
end
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -85
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/VagDilatation_control.rb")
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
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation3B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation3"
end
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -70
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_player.actor.stat["EventMouth"] = nil
################################################################################################
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation3B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation3"
end
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -70
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################
if $story_stats["sex_record_vag_dilatation"].between?(0,14)&&$game_actors[1].state_stack(41) < 1
$game_player.actor.stat["EventVag"] ="VagDilatation3B"
else
$game_player.actor.stat["EventVag"] ="VagDilatation3"
end
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -110 ; $game_player.actor.stat["chcg_y"] = -70
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$game_player.actor.stat["EventVagRace"] = temp_EventVagRace #RACE需求防呆編碼
$game_player.actor.stat["vagopen"] =0
$story_stats["sex_record_vag_dilatation"] +=1
half_event_key_cleaner
chcg_background_color_off
