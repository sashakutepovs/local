if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Torture"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} BellyPunch"
$game_portraits.lprt.hide


################################################################################################
$game_player.actor.stat["EventVag"] ="Punch2"
lona_mood "p5crit_damage"
load_script("Data/Batch/belly_punch_control.rb")
#message control
check_over_event
$game_player.call_balloon([6,26,27].sample)
#$game_map.popup(0,"QuickMsg:Lona/beaten#{rand(10)}",0,0)
################################################################################################
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
$story_stats["sex_record_torture"] +=1
