

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
$game_player.actor.stat["EventVag"] ="Moot_Birth0"
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
$game_player.actor.stat["EventVag"] = "Moot_Birth1"
$game_player.actor.stat["vagopen"] =1
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
$game_player.actor.stat["EventVag"] ="Moot_Birth1"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,3) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -72 ; $game_player.actor.stat["chcg_y"] = -171
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Moot_Birth1"
$game_player.actor.stat["vagopen"] =1
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
$game_player.actor.stat["EventVag"] ="Moot_Birth2"
$game_player.actor.stat["vagopen"] =1
$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
#$game_party.leader.setup_state(29,2) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -68 ; $game_player.actor.stat["chcg_y"] = -273
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventVag"] = "Moot_Birth2"
$game_player.actor.stat["vagopen"] =1
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
$game_player.actor.stat["EventVag"] ="Moot_Birth3"
$game_player.actor.stat["vagopen"] =1
$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
#$game_party.leader.setup_state(29,1) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -68 ; $game_player.actor.stat["chcg_y"] = -327
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################
$game_player.actor.stat["EventVag"] ="Moot_Birth3"
$game_player.actor.stat["vagopen"] =1
$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventVag"] ="Moot_Birth3"
$game_player.actor.stat["vagopen"] =1
#$game_party.leader.setup_state(29,1) #preg
lona_mood "chcg4fuck_#{chcg_mood_decider}"
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -45 ; $game_player.actor.stat["chcg_y"] = -327
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
SndLib.HumanBabyCry(70,120)
$game_message.add("...........")
$game_map.interpreter.wait_for_message
SndLib.HumanBabyCry(60,120)
$game_message.add("......")
$game_map.interpreter.wait_for_message
SndLib.HumanBabyCry(50,120)
$game_message.add("...")
$game_map.interpreter.wait_for_message

################################################################
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
$game_map.reserve_summon_event("PlayerMootBaby") if !$game_map.isOverMap
$story_stats["sex_record_baby_birth"] +=1
$story_stats["sex_record_birth_Moot"] +=1
$game_actors[1].sta -= 1000
$game_party.gain_item($data_items[79], 1)
$game_actors[1].cleanup_after_birth
$game_actors[1].preg_level =0
$game_player.actor.healCums("CumsCreamPie",1000)
event_key_cleaner
chcg_background_color_off
lona_mood "normal"
