if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Mouth"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} CumOutside"
$game_portraits.lprt.hide

########################################################################frame 0###################################################################################################
$game_player.actor.stat["EventMouth"] ="CumInside1"
lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
			#normal cam
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -138 ; $game_player.actor.stat["chcg_y"] = -65 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -165 ; $game_player.actor.stat["chcg_y"] = -89 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -64 ; $game_player.actor.stat["chcg_y"] = -78 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -204 ; $game_player.actor.stat["chcg_y"] = -141 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/EventMouth_begin]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2###################################################################################################
$game_player.actor.stat["EventMouth"] ="CumOutside2"
lona_mood "#{chcg_decider_basic_mouth}fuck_#{chcg_mood_decider}"
			#mouth
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -170 ; $game_player.actor.stat["chcg_y"] = -28 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -12 ; $game_player.actor.stat["chcg_y"] = -11 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -290 ; $game_player.actor.stat["chcg_y"] = -166 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -86 ; $game_player.actor.stat["chcg_y"] = -21 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -151 ; $game_player.actor.stat["chcg_y"] = -114 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_mouth.rb")
chcg_add_cums("EventMouthRace","CumsHead")
#stats_batch4
#stats_batch5
load_script("Data/Batch/take_sex_wound_head.rb")
check_over_event
#add head cums
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$story_stats["sex_record_cumshotted"] +=1
