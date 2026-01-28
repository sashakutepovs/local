if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Birth"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]},#{$game_actors[1].baby_race}"
#
#
$game_portraits.lprt.hide
chcg_background_color
event_key_cleaner
$game_player.actor.stat["vagopen"] =0
$game_player.actor.stat["analopen"] =0
chcg_decider_basic(pose=4)
$game_player.actor.health -= $game_player.actor.subtraction_health(50)
########################################################################frame 0 至中畫面 準備撥放###################################################################################################
$game_player.actor.stat["EventVag"] = nil
$game_player.actor.stat["vagopen"] =0
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] = nil
$game_player.actor.stat["vagopen"] =0
$game_actors[1].add_state(28) #wet
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -68 ; $game_player.actor.stat["chcg_y"] = -166
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith_begin#{talk_style}#{rand(4)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 0 至中畫面 準備撥放###################################################################################################
$game_player.actor.stat["EventVag"] = nil
$game_player.actor.stat["vagopen"] =0
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/brith_begin#{talk_style}#{rand(4)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth0"
$game_player.actor.stat["vagopen"] =0
$game_actors[1].add_state(37)#bleed
#$game_party.leader.setup_state(29,3) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -68 ; $game_player.actor.stat["chcg_y"] = -166
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith_begin#{talk_style}#{rand(4)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Orkind_Birth0"
$game_player.actor.stat["vagopen"] =0
#$game_party.leader.setup_state(29,3) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth1"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,3) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -64 ; $game_player.actor.stat["chcg_y"] = -224
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Orkind_Birth1"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,3) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth2"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,3) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -71 ; $game_player.actor.stat["chcg_y"] = -269
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Orkind_Birth2"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,3) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth3"
$game_player.actor.stat["vagopen"] =1
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -26 ; $game_player.actor.stat["chcg_y"] = -287
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Orkind_Birth3"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,2) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth4"
$game_player.actor.stat["vagopen"] =1
$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -26 ; $game_player.actor.stat["chcg_y"] = -287
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Orkind_Birth4"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,2) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth5"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,2) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -86 ; $game_player.actor.stat["chcg_y"] = -214
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Orkind_Birth5"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,2) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth6"
$game_player.actor.stat["vagopen"] =1
$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -321
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Orkind_Birth6"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,1) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/birth_basic_frame.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#add_heavy sta damage
#message control
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth7"
$game_player.actor.stat["vagopen"] =1
$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -63 ; $game_player.actor.stat["chcg_y"] = -323
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Orkind_Birth7"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,1) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame_overfatigue#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Orkind_Birth7"
$game_player.actor.stat["vagopen"] =1
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -63 ; $game_player.actor.stat["chcg_y"] = -323
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
SndLib.sound_goblinBB_spot(100)
$game_message.add("...........")
$game_map.interpreter.wait_for_message
SndLib.sound_goblinBB_roar(90)
$game_message.add("......")
$game_map.interpreter.wait_for_message
SndLib.sound_goblinBB_idle(80)
$game_message.add("...")
$game_map.interpreter.wait_for_message

#######################################################
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
$game_party.gain_item($data_items[68], 2)
$game_map.reserve_summon_event("PlayerOrcBaby") if !$game_map.isOverMap
$game_map.reserve_summon_event("PlayerOrcBaby") if !$game_map.isOverMap
$story_stats["sex_record_baby_birth"] +=2
$story_stats["sex_record_birth_Orkind"] +=2
$game_actors[1].sta -= 1000
$game_actors[1].cleanup_after_birth
$game_actors[1].preg_level =0
$game_player.actor.healCums("CumsCreamPie",1000)
event_key_cleaner
chcg_background_color_off
lona_mood "normal"
