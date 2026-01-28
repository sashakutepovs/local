if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0 || $game_actors[1].state_stack(42) !=0 || $game_player.actor.stat["AsVulva_Urethra"] == 1
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture" if $game_actors[1].state_stack(106) !=0 && $game_actors[1].state_stack(42) !=1
$game_player.actor.stat["EventTargetPart"] = "Vag" if $game_actors[1].state_stack(42) ==1
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_UrinaryDilatation"
$game_portraits.lprt.hide

chcg_background_color
#half_event_key_cleaner

temp_EventVagRace = $game_player.actor.stat["EventVagRace"] #RACE需求防呆編碼
$game_player.actor.stat["EventVagRace"] = "Human" if $game_player.actor.stat["EventVagRace"] == nil #RACE需求防呆編碼

chcg_decider_basic(pose=1)
$game_player.actor.stat["vagopen"] = 0
########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] ="UrinaryDilatation1"
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -34 ; $game_player.actor.stat["chcg_y"] = -61
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/UrethraDilatation_begin1]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventVag"] ="UrinaryDilatation2"
lona_mood "chcg1fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -34 ; $game_player.actor.stat["chcg_y"] = -61
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/UrinaryDilatation_control.rb")
$game_actors[1].sta +=10
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/UrethraDilatation_begin2]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventVag"] ="UrinaryDilatation3"
lona_mood "chcg1fuck_cuming_ahegao"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -34 ; $game_player.actor.stat["chcg_y"] = -61
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/UrinaryDilatation_control.rb")
$game_actors[1].sta +=3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control

if $story_stats["sex_record_urinary_dilatation"].between?(0,14)&&$game_actors[1].state_stack(42) < 1
$game_message.add("\\t[commonH:Lona/UrethraDilatation_begin3_normal]")
else
$game_message.add("\\t[commonH:Lona/UrethraDilatation_begin3_damaged]")
end
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventVag"] ="UrinaryDilatation4"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -34 ; $game_player.actor.stat["chcg_y"] = -61
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/UrinaryDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventVag"] ="UrinaryDilatation2"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -34 ; $game_player.actor.stat["chcg_y"] = -61
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/UrinaryDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventVag"] ="UrinaryDilatation3"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -34 ; $game_player.actor.stat["chcg_y"] = -61
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/UrinaryDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2!!!!!!!###################################################################################################
$game_player.actor.stat["EventVag"] ="UrinaryDilatation4"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -34 ; $game_player.actor.stat["chcg_y"] = -61
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/UrinaryDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/grab#{talk_style}#{rand(3)}]")
$game_map.interpreter.wait_for_message


########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] ="UrinaryDilatation5"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -34 ; $game_player.actor.stat["chcg_y"] = -61
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/UrinaryDilatation_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add punch stats control
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/UrethraDilatation_end]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -135 ; $game_player.actor.stat["chcg_y"] = -65
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/UrethraDilatation_end#{talk_style}]")
$game_map.interpreter.wait_for_message
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$game_player.actor.stat["EventVagRace"] = temp_EventVagRace #RACE需求防呆編碼
$story_stats["sex_record_urinary_dilatation"] +=1
$game_player.actor.stat["EventVag"] = nil
half_event_key_cleaner
chcg_background_color_off
