if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_VagNeedle"
$game_portraits.lprt.hide

chcg_background_color
temp_bellysize = $game_player.actor.stat["preg"]
temp_bellysize_control = 1+$game_player.actor.stat["preg"] 
if temp_bellysize_control >=4 ; then temp_bellysize_control =3 end
#half_event_key_cleaner
chcg_decider_basic(pose=1)

##############################################################################################################################################################################
$game_player.actor.stat["EventExt3"] ="AbomBellyPara1"
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-150+rand(5),-70+rand(5))
call_msg("commonH:Lona/AbomBellyPara_begin1")
call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")

##############################################################################################################################################################################
$game_player.actor.stat["EventExt3"] ="AbomBellyPara1"
lona_mood "chcg1fuck_#{chcg_mood_decider}"
$game_portraits.rprt.set_position(-150+rand(5),-70+rand(5))
call_msg("commonH:Lona/AbomBellyPara_begin2")

##############################################################################################################################################################################
$game_player.actor.stat["EventExt3"] ="AbomBellyPara2"
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_portraits.rprt.set_position(-150+rand(5),-80+rand(5))
load_script("Data/Batch/AbomBellyPara_control.rb")
check_over_event
call_msg("commonH:Lona/beaten#{rand(10)}")
load_script("Data/Batch/AbomBellyPara_control.rb")
check_over_event
call_msg("commonH:Lona/AbomBellyPara_begin3")

##############################################################################################################################################################################
5.times{
$game_player.actor.stat["preg"] = temp_bellysize_control
$game_player.actor.stat["EventExt3"] ="AbomBellyPara2"
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_portraits.rprt.set_position(-150+rand(5),-80+rand(5))
load_script("Data/Batch/AbomBellyPara_control2.rb")
check_over_event
call_msg("commonH:Lona/beaten#{rand(10)}")
}

##############################################################################################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
$game_player.actor.stat["EventExt3"] ="AbomBellyPara3"
lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
$game_portraits.rprt.set_position(-150+rand(5),-80+rand(5))
load_script("Data/Batch/AbomBellyPara_control2.rb")
check_over_event
call_msg("commonH:Lona/beaten#{rand(10)}")

##############################################################################################################################################################################
$game_player.actor.stat["preg"] = temp_bellysize_control
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-160+rand(5),-70+rand(5))
call_msg("commonH:Lona/frame_overfatigue#{rand(10)}")
$game_player.actor.stat["preg"] = temp_bellysize_control
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-160+rand(5),-70+rand(5))
call_msg("commonH:Lona/AbomBellyPara_end#{talk_style}")
$game_player.actor.stat["preg"] = temp_bellysize_control
lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-160+rand(5),-70+rand(5))

#######################################################

$game_player.actor.stat["preg"] = temp_bellysize
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$game_player.actor.add_state("WombSeedBed")
$game_player.actor.add_state("AnalSeedBed")
$game_player.actor.add_state("BladderSeedBed")

$story_stats["sex_record_torture"] +=1
half_event_key_cleaner
chcg_background_color_off
