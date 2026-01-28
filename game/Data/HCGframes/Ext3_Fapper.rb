if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Semen"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} FapperSlot3"
$game_portraits.lprt.hide

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventExt3"] ="FapperCuming1"
lona_mood "#{chcg_decider_basic_fapper}fuck_#{chcg_mood_decider}"
			#ext3
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -111 ; $game_player.actor.stat["chcg_y"] = -26 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -117 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -194 ; $game_player.actor.stat["chcg_y"] = -144 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -80 ; $game_player.actor.stat["chcg_y"] = -20 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -32 ; $game_player.actor.stat["chcg_y"] = -174 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 2###################################################################################################
$game_player.actor.stat["EventExt3"] ="FapperCuming2"
lona_mood "#{chcg_decider_basic_fapper}fuck_#{chcg_mood_decider}"
			#ext3
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -111 ; $game_player.actor.stat["chcg_y"] = -26 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -117 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -194 ; $game_player.actor.stat["chcg_y"] = -144 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -80 ; $game_player.actor.stat["chcg_y"] = -20 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -32 ; $game_player.actor.stat["chcg_y"] = -174 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_fapper.rb")
#stats_batch3
#stats_batch4
chcg_add_cums("EventExt3Race",["CumsMid","CumsHead","CumsBot","CumsTop"].sample)
#stats_batch6
check_over_event
#add cums body
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$story_stats["sex_record_cumshotted"] +=1
