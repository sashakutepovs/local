return load_script("Data/HCGframes/EventMouth_CumInside_Overcum.rb") if $story_stats["Setup_UrineEffect"] == 0
if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Mouth"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} CumInside_Peein"
$game_portraits.lprt.hide

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventMouth"] ="CumInside1"
lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -155 ; $game_player.actor.stat["chcg_y"] = -58 end
if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -51 ; $game_player.actor.stat["chcg_y"] = -51 end
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -274 ; $game_player.actor.stat["chcg_y"] = -130 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -64 ; $game_player.actor.stat["chcg_y"] = -78 end
if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -204 ; $game_player.actor.stat["chcg_y"] = -141 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_mouth.rb")
#stats_batch3
#stats_batch4
#stats_batch5
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/EventMouth_begin]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2###################################################################################################
$game_player.actor.stat["EventMouth"] ="CumInside2"
lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
			#mouth
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -155 ; $game_player.actor.stat["chcg_y"] = -58 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -51 ; $game_player.actor.stat["chcg_y"] = -51 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -274 ; $game_player.actor.stat["chcg_y"] = -130 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -47 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -131 ; $game_player.actor.stat["chcg_y"] = -125 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_mouth.rb")
chcg_add_cums("EventMouthRace","CumsMouth") ; $game_player.actor.puke_value_normal += rand(100)
#stats_batch4
#stats_batch5
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#add mouth cums
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
########################################################################frame 3###################################################################################################
$game_player.actor.stat["EventMouth"] ="CumInsidePeein3"
lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
#mouth
if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -155 ; $game_player.actor.stat["chcg_y"] = -58 end
if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -51 ; $game_player.actor.stat["chcg_y"] = -51 end
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -274 ; $game_player.actor.stat["chcg_y"] = -130 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -47 end
if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -139 ; $game_player.actor.stat["chcg_y"] = -151 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_mouth.rb")
$game_actors[1].dirt += rand(6)+6
#stats_batch4
#stats_batch5
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[common:narrator/peein_mouth]")
$game_map.interpreter.wait_for_message

########################################################################frame 4###################################################################################################
$game_player.actor.stat["EventMouth"] ="CumInsidePeein4"
lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
			#mouth
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -155 ; $game_player.actor.stat["chcg_y"] = -58 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -51 ; $game_player.actor.stat["chcg_y"] = -51 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -274 ; $game_player.actor.stat["chcg_y"] = -130 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -47 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -139 ; $game_player.actor.stat["chcg_y"] = -151 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_mouth.rb")
$game_actors[1].dirt += rand(6)+6
#stats_batch4
#stats_batch5
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 5###################################################################################################
$game_player.actor.stat["EventMouth"] ="CumInsidePeein5"
lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
			#mouth
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -170 ; $game_player.actor.stat["chcg_y"] = -28 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -12 ; $game_player.actor.stat["chcg_y"] = -11 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -290 ; $game_player.actor.stat["chcg_y"] = -166 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -86 ; $game_player.actor.stat["chcg_y"] = -21 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -159 ; $game_player.actor.stat["chcg_y"] = -129 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_mouth.rb")
#stats_batch3
#stats_batch4
#stats_batch5
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$story_stats["sex_record_cumin_mouth"] +=1
$story_stats["sex_record_piss_drink"] +=1
