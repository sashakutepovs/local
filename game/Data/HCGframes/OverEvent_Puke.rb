if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_Esophageal"] ==1
$game_player.actor.stat["EventTargetPart"] = "Torture" if $game_player.actor.state_stack(106) !=0
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Playing OverEvent :AutoPuke"
$game_portraits.lprt.hide
half_event_key_cleaner if $game_player.actor.action_state == :sex
temp_EventMouth = $game_player.actor.stat["EventMouth"]
temp_1st_worm = rand(100) if $game_player.actor.state_stack("ParasitedHookWorm") !=0
##############################################################normal on#################################################################
lona_mood "p5sta_damage"
$game_player.actor.portrait.shake
#message control
$game_message.add("\\t[common:Lona/puke_begin1]")
$game_map.interpreter.wait_for_message
##############################################################normal off#################################################################
lona_mood "p5sta_damage"
$cg = TempCG.new(["event_puke"])
$game_player.actor.portrait.shake
#message control
$game_message.add("\\t[common:Lona/puke_begin2]")
$game_map.interpreter.wait_for_message
##############################################################normal on#################################################################
lona_mood "p5puke"
load_script("Data/Batch/puke_value_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#message control
$game_message.add("\\t[common:Lona/puke1]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################normal on#################################################################
lona_mood "p5puke"
load_script("Data/Batch/puke_value_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#message control
$game_message.add("\\t[common:Lona/puke2]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################normal on#################################################################
lona_mood "p5puke"
load_script("Data/Batch/puke_value_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#message control
$game_message.add("\\t[common:Lona/puke3]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################normal on#################################################################
lona_mood "p5puke"
load_script("Data/Batch/puke_value_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#message control
$game_message.add("\\t[common:Lona/puke4]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################normal on#################################################################
lona_mood "p5puke"
load_script("Data/Batch/puke_value_control.rb")
#stats_batch3
#stats_batch4
#stats_batch5
#stats_batch6
#stats_batch7
#message control
$game_message.add("\\t[common:Lona/puke5]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
$game_map.interpreter.wait_for_message
##############################################################normal off#################################################################
lona_mood "tired"
$cg.erase
#message control
$game_message.add("\\t[common:Lona/puke_end1]")
$game_map.interpreter.wait_for_message
##############################################################normal off#################################################################
lona_mood "pain"
#message control
$game_message.add("\\t[common:Lona/puke_end2_normal]") if $game_actors[1].preg_level ==0
$game_message.add("\\t[common:Lona/puke_end2_preg]") if $game_actors[1].preg_level !=0
$game_map.interpreter.wait_for_message
################################################################################################
$game_player.actor.stat["EventMouth"] = temp_EventMouth
half_event_key_cleaner if $game_player.actor.action_state == :sex
check_over_event

##################################################
if $game_player.actor.state_stack("ParasitedHookWorm") !=0 #控制寄生蟲
	prev_worm_birth = $story_stats["sex_record_birth_HookWorm"]
	if $game_player.actor.state_stack("ParasitedHookWorm") >=1 && temp_1st_worm >= 50
		$game_map.reserve_summon_event("PlayerAbomCreatureMeatHookworm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.anal_damage += 150
		$story_stats["sex_record_birth_HookWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedHookWorm") >=2 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbomCreatureMeatHookworm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.anal_damage += 150
		$story_stats["sex_record_birth_HookWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedHookWorm") >=3 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbomCreatureMeatHookworm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.anal_damage += 150
		$story_stats["sex_record_birth_HookWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedHookWorm") >=4 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbomCreatureMeatHookworm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.anal_damage += 150
		$story_stats["sex_record_birth_HookWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedHookWorm") >=5 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbomCreatureMeatHookworm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.anal_damage += 150
		$story_stats["sex_record_birth_HookWorm"] +=1
	end
	call_msg("common:Lona/BirthedWorms") if prev_worm_birth != $story_stats["sex_record_birth_HookWorm"]
end
##################################################
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
