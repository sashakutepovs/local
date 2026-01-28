return if $story_stats["Setup_ScatEffect"] == 0

	if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
	end
	$game_player.actor.stat["AllowOgrasm"] = true if $game_actors[1].state_stack(105) !=0
	$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_Anal"] ==1
	$game_player.actor.stat["EventTargetPart"] = "Poo"
	p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Command_Poo"
	$game_portraits.lprt.hide
	

	$game_message.add("\\t[commonH:Lona/poo_begin]") if $story_stats["sex_record_defecate_incontinent"].between?(0,14)
	$game_message.add("\\t[commonH:Lona/poo_begin_pro]") if $story_stats["sex_record_defecate_incontinent"] >=15
	$game_map.interpreter.wait_for_message
	$game_actors[1].defecate_level =0
	temp_1st_worm = rand(100) if $game_player.actor.state_stack(93) !=0
	
	##############################################################normal off#################################################################
	$cg = TempCG.new(["event_poo"])
	$game_player.actor.stat["EventAnal"] = "DefecateIncontinent"
	lona_mood "p5sta_damage"
	load_script("Data/Batch/poo_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	call_msg("common:Lona/PooMoonWorm") if $game_player.actor.state_stack(93) !=0 && temp_1st_worm >= 50
	##############################################################normal off#################################################################
	$game_player.actor.stat["EventAnal"] = nil
	lona_mood "p5sta_damage"
	load_script("Data/Batch/Command_PooControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	##############################################################normal on#################################################################
	$game_player.actor.stat["EventAnal"] = "DefecateIncontinent"
	lona_mood "p5sta_damage"
	load_script("Data/Batch/Command_PooControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	
	##############################################################normal off#################################################################
	$game_player.actor.stat["EventAnal"] = nil
	lona_mood "p5sta_damage"
	load_script("Data/Batch/Command_PooControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	##############################################################normal on#################################################################
	$game_player.actor.stat["EventAnal"] = "DefecateIncontinent"
	lona_mood "p5sta_damage"
	load_script("Data/Batch/Command_PooControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	
	##############################################################normal off#################################################################
	$game_player.actor.stat["EventAnal"] = nil
	lona_mood "p5sta_damage"
	load_script("Data/Batch/Command_PooControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	##############################################################normal on#################################################################
	$game_player.actor.stat["EventAnal"] = "DefecateIncontinent"
	lona_mood "p5sta_damage"
	load_script("Data/Batch/Command_PooControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	##############################################################normal off#################################################################
	$game_player.actor.stat["EventAnal"] = nil
	lona_mood "p5sta_damage"
	load_script("Data/Batch/Command_PooControl.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
	$game_map.interpreter.wait_for_message
	$cg.erase
	################################################################################################
	$story_stats["sex_record_shat"] +=1
	$story_stats["sex_record_seen_shat"] +=1 if $game_player.innocent_spotted?
	check_over_event
	
	
	##################################################	
	if $game_player.actor.state_stack("ParasitedMoonWorm") !=0 #控制寄生蟲
		prev_worm_birth = $story_stats["sex_record_birth_MoonWorm"]
		if $game_player.actor.state_stack("ParasitedMoonWorm") >=1 && temp_1st_worm >= 50
			$game_map.reserve_summon_event("PlayerAbominationMoonWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
			$game_player.actor.anal_damage += 150
			$story_stats["sex_record_birth_MoonWorm"] +=1
		end
		if $game_player.actor.state_stack("ParasitedMoonWorm") >=2 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationMoonWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
			$game_player.actor.anal_damage += 150
			$story_stats["sex_record_birth_MoonWorm"] +=1
		end
		if $game_player.actor.state_stack("ParasitedMoonWorm") >=3 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationMoonWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
			$game_player.actor.anal_damage += 150
			$story_stats["sex_record_birth_MoonWorm"] +=1
		end
		if $game_player.actor.state_stack("ParasitedMoonWorm") >=4 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationMoonWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
			$game_player.actor.anal_damage += 150
			$story_stats["sex_record_birth_MoonWorm"] +=1
		end
		if $game_player.actor.state_stack("ParasitedMoonWorm") >=5 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationMoonWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
			$game_player.actor.anal_damage += 150
			$story_stats["sex_record_birth_MoonWorm"] +=1
		end
		call_msg("common:Lona/BirthedWorms") if prev_worm_birth != $story_stats["sex_record_birth_MoonWorm"]
	end
	##################################################	
optain_item("WastePoo0") #40
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

