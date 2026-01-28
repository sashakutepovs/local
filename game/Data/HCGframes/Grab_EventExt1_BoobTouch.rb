if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Breast"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} BoobTouch"
$game_portraits.lprt.hide


################################################################################################
$game_player.actor.stat["EventExt1"] ="BoobTouch"
lona_mood "p5sta_damage"
load_script("Data/Batch/harassment_frame_BoobTouch.rb")
#message control
check_over_event
$game_player.call_balloon([6,26,27].sample)
#$game_map.popup(0,"QuickMsg:Lona/grab#{talk_style}#{rand(3)}",0,0)
################################################################################################
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
$story_stats["sex_record_groped"] +=1
$story_stats["sex_record_boob_harassment"] +=1
