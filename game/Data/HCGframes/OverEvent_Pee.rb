return if $story_stats["Setup_UrineEffect"] == 0
if $game_player.actor.stat["AllowOgrasm"] == true
	$game_player.actor.stat["allow_ograsm_record"] = true
else 
	$game_player.actor.stat["allow_ograsm_record"] = false
end
$game_player.actor.stat["AllowOgrasm"] = true if $game_actors[1].state_stack(105) !=0
$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_Urethra"] ==1
$game_player.actor.stat["EventTargetPart"] = "Pee"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Playing OverEvent :AutoPee"
$game_portraits.lprt.hide

$game_message.add("\\t[commonH:Lona/pee_begin]") if $story_stats["sex_record_urinary_incontinence"].between?(0,14)
$game_message.add("\\t[commonH:Lona/pee_begin_pro]") if $story_stats["sex_record_urinary_incontinence"]>=15
$game_map.interpreter.wait_for_message
$game_actors[1].urinary_level =0
$game_actors[1].add_state(28)
temp_1st_worm = rand(100) if $game_player.actor.state_stack("ParasitedPotWorm") !=0
	
if IsChcg? || $game_player.actor.action_state == :sex
	$game_map.interpreter.player_sex_get_tar_key if $game_player.actor.action_state == :sex && $game_player.manual_sex != true
	temp_EventVag = $game_player.actor.stat["EventVag"] if $game_player.actor.stat["pose"] == "chcg2"
	$game_player.actor.stat["EventVag"] = nil			if $game_player.actor.stat["pose"] == "chcg2"
	#############################################################CHCG FRAME PEE ON##################################################################################
	$game_player.actor.stat["EffectPee"] = 1
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_shame_mood_decider}"
		#################################################################################
		
		
					if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -56 end
					if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -101 end
					if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -152 end
					if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -69 ; $game_player.actor.stat["chcg_y"] = -98 end
					if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		##################################################################################
	load_script("Data/Batch/pee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	call_msg("common:Lona/PeePotWorm") if $game_player.actor.state_stack("ParasitedPotWorm") !=0 && temp_1st_worm >=50
	#############################################################CHCG FRAME PEE OFF##################################################################################
	$game_player.actor.stat["EffectPee"] = 0
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_shame_mood_decider}"
		#################################################################################
		
		
					if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -64 end
					if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -118 ; $game_player.actor.stat["chcg_y"] = -48 end
					if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -193 ; $game_player.actor.stat["chcg_y"] = -124 end
					if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -71 end
					if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		##################################################################################
	load_script("Data/Batch/pee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	#############################################################CHCG FRAME PEE ON##################################################################################
	$game_player.actor.stat["EffectPee"] = 1
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_shame_mood_decider}"
		#################################################################################
		
		
					if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -56 end
					if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -101 end
					if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -152 end
					if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -69 ; $game_player.actor.stat["chcg_y"] = -98 end
					if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		##################################################################################
	load_script("Data/Batch/pee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	#############################################################CHCG FRAME PEE OFF##################################################################################
	$game_player.actor.stat["EffectPee"] = 0
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_shame_mood_decider}"
		#################################################################################
		
		
					if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -64 end
					if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -118 ; $game_player.actor.stat["chcg_y"] = -48 end
					if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -193 ; $game_player.actor.stat["chcg_y"] = -124 end
					if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -71 end
					if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		##################################################################################
	load_script("Data/Batch/pee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	#############################################################CHCG FRAME PEE ON##################################################################################
	$game_player.actor.stat["EffectPee"] = 1
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_shame_mood_decider}"
		#################################################################################
		
		
					if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -56 end
					if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -101 end
					if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -152 end
					if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -69 ; $game_player.actor.stat["chcg_y"] = -98 end
					if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		##################################################################################
	load_script("Data/Batch/pee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	#############################################################CHCG FRAME PEE OFF##################################################################################
	$game_player.actor.stat["EffectPee"] = 0
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_shame_mood_decider}"
		#################################################################################
		
		
					if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -64 end
					if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -118 ; $game_player.actor.stat["chcg_y"] = -48 end
					if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -193 ; $game_player.actor.stat["chcg_y"] = -124 end
					if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -71 end
					if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		##################################################################################
	load_script("Data/Batch/pee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	#############################################################CHCG FRAME PEE ON##################################################################################
	$game_player.actor.stat["EffectPee"] = 1
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_shame_mood_decider}"
		#################################################################################
		
		
					if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -56 end
					if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -101 end
					if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -152 end
					if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -69 ; $game_player.actor.stat["chcg_y"] = -98 end
					if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		##################################################################################
	load_script("Data/Batch/pee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	#############################################################CHCG FRAME PEE OFF##################################################################################
	$game_player.actor.stat["EffectPee"] = 0
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_shame_mood_decider}"
		#################################################################################
		
		
					if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -64 end
					if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -118 ; $game_player.actor.stat["chcg_y"] = -48 end
					if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -193 ; $game_player.actor.stat["chcg_y"] = -124 end
					if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -71 end
					if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
					$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
					$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		##################################################################################
	load_script("Data/Batch/pee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	##################################################################################
	$story_stats["sex_record_urinary_incontinence"]+=1 #when chcg only
	$game_player.actor.stat["EventVag"] = temp_EventVag if $game_player.actor.stat["pose"] == "chcg2"
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
else #not chcg
	half_event_key_cleaner
	$cg = TempCG.new(["event_pee"])
	4.times{
		##############################################################normal on#################################################################
		$game_player.actor.stat["EffectPee"] = 1
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="pee")
		load_script("Data/Batch/pee_control.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		##############################################################normal off#################################################################
		$game_player.actor.stat["EffectPee"] = 0
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="pee")
		load_script("Data/Batch/pee_control.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
		$game_map.interpreter.wait_for_message
	}
	$cg.erase
	call_msg("common:Lona/PeePotWorm") if $game_player.actor.state_stack("ParasitedPotWorm") !=0 && temp_1st_worm >=50
	$cg.erase
end
################################################################################################
$story_stats["sex_record_peed"] +=1
$story_stats["sex_record_seen_peeing"] +=1 if $game_player.innocent_spotted?
half_event_key_cleaner if $game_player.actor.action_state == :sex
check_over_event

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
	##################################################	
if $game_map.isOverMap
	$game_map.reserve_summon_event("WasteRandom3",$game_player.x,$game_player.y)
else
	$game_map.reserve_summon_event("ProjectilePee",$game_player.x,$game_player.y)
end
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
