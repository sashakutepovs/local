if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["EventTargetPart"] = "Breast"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Grab_Feeding.rb"
$game_portraits.lprt.hide


################################################################################################
$game_player.actor.stat["EventMouth"] ="Feeding"
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.angle=90
$game_portraits.rprt.set_position(300,710)
load_script("Data/Batch/harassment_frame_Feeding.rb")
$game_player.call_balloon([6,26,27].sample)
#call_msg_popup("QuickMsg:Lona/Feeding#{rand(3)}")
################################################################################################

#$game_actors[1].portrait.reset_rotation
$story_stats["sex_record_BreastFeeding"] +=1
