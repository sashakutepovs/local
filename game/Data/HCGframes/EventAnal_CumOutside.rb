if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Anal"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} CumOutside"
$game_portraits.lprt.hide

########################################################################frame 0###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside1"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
			#normal cam
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -138 ; $game_player.actor.stat["chcg_y"] = -65 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -165 ; $game_player.actor.stat["chcg_y"] = -89 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -203 ; $game_player.actor.stat["chcg_y"] = -103 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/EventAnal_begin]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message


########################################################################frame 2###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumOutside2"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -24  ; $game_player.actor.stat["chcg_y"] = -163 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -206 ; $game_player.actor.stat["chcg_y"] = -27 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -20 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -62 ; $game_player.actor.stat["chcg_y"] = -283 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
chcg_add_cums("EventAnalRace","CumsBot")
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add bot cums
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$story_stats["sex_record_cumshotted"] +=1
