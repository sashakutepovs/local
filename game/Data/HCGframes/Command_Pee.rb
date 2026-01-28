return if $story_stats["Setup_UrineEffect"] == 0

if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true if $game_actors[1].state_stack(105) !=0
$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_Urethra"] ==1
$game_player.actor.stat["EventTargetPart"] = "Pee"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Command_Pee"
$game_portraits.lprt.hide



	
	call_msg("commonH:Lona/pee_begin") if $story_stats["sex_record_urinary_incontinence"].between?(0,14)
	call_msg("commonH:Lona/pee_begin_pro") if $story_stats["sex_record_urinary_incontinence"]>=15
	
	$game_actors[1].urinary_level =0
	temp_1st_worm = rand(100) if $game_player.actor.state_stack("ParasitedPotWorm") !=0
	
	##############################################################normal on#################################################################
	$cg = TempCG.new(["event_pee"])
	$game_player.actor.stat["EffectPee"] = 1
	lona_mood "p5pee"
	load_script("Data/Batch/Command_PeeControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	call_msg("commonH:Lona/pee#{rand(5)}")
	call_msg("common:Lona/PeePotWorm") if $game_player.actor.state_stack("ParasitedPotWorm") !=0 && temp_1st_worm >=50
	##############################################################normal off#################################################################
	$game_player.actor.stat["EffectPee"] = 0
	lona_mood "p5pee"
	load_script("Data/Batch/Command_PeeControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	call_msg("commonH:Lona/pee#{rand(5)}")
	
	##############################################################normal on#################################################################
	$game_player.actor.stat["EffectPee"] = 1
	lona_mood "p5pee"
	load_script("Data/Batch/Command_PeeControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	call_msg("commonH:Lona/pee#{rand(5)}")
	
	
	##############################################################normal off#################################################################
	$game_player.actor.stat["EffectPee"] = 0
	lona_mood "p5pee"
	load_script("Data/Batch/Command_PeeControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	call_msg("commonH:Lona/pee#{rand(5)}")
	
	##############################################################normal on#################################################################
	$game_player.actor.stat["EffectPee"] = 1
	lona_mood "p5pee"
	load_script("Data/Batch/Command_PeeControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	call_msg("commonH:Lona/pee#{rand(5)}")
	
	
	##############################################################normal off#################################################################
	$game_player.actor.stat["EffectPee"] = 0
	lona_mood "p5pee"
	load_script("Data/Batch/Command_PeeControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	call_msg("commonH:Lona/pee#{rand(5)}")
	
	##############################################################normal on#################################################################
	$game_player.actor.stat["EffectPee"] = 1
	lona_mood "p5pee"
	load_script("Data/Batch/Command_PeeControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	call_msg("commonH:Lona/pee#{rand(5)}")
	
	
	##############################################################normal off#################################################################
	$game_player.actor.stat["EffectPee"] = 0
	lona_mood "p5pee"
	load_script("Data/Batch/Command_PeeControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	call_msg("commonH:Lona/pee#{rand(5)}")
	
	$cg.erase
	
	################################################################################################
	check_over_event
	##################################################
	$story_stats["sex_record_peed"] +=1
	$story_stats["sex_record_seen_peeing"] +=1 if $game_player.innocent_spotted?
	
	##################################################	
if $game_player.actor.state_stack("ParasitedPotWorm") !=0 #控制寄生蟲
	prev_worm_birth = $story_stats["sex_record_birth_PotWorm"]
	if $game_player.actor.state_stack("ParasitedPotWorm") >=1 && temp_1st_worm >= 50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedPotWorm") >=2 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedPotWorm") >=3 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedPotWorm") >=4 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedPotWorm") >=5 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	call_msg("common:Lona/BirthedWorms") if prev_worm_birth != $story_stats["sex_record_birth_PotWorm"]
end
EvLib.sum("ProjectilePee",$game_player.x,$game_player.y)
##################################################	
chk_force_aggro_around_player(tmpIgnoreRace=["Human","Deepone","Moot"],tmpInRange=5,tmpSensorStr=7,tmpAggroTime=300)



$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
