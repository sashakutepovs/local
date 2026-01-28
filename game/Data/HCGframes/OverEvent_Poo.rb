


return if $story_stats["Setup_ScatEffect"] == 0

	if $game_player.actor.stat["AllowOgrasm"] == true
		$game_player.actor.stat["allow_ograsm_record"]=true
	else 
		$game_player.actor.stat["allow_ograsm_record"] = false 
	end
	$game_player.actor.stat["AllowOgrasm"] = true if $game_actors[1].state_stack(105) !=0
	$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_Anal"] ==1
	$game_player.actor.stat["EventTargetPart"] = "Poo"
	p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Playing OverEvent :AutoPoo"
	$game_portraits.lprt.hide
	
	$game_message.add("\\t[commonH:Lona/poo_begin]") if $story_stats["sex_record_defecate_incontinent"].between?(0,14)
	$game_message.add("\\t[commonH:Lona/poo_begin_pro]") if $story_stats["sex_record_defecate_incontinent"] >=15
	$game_map.interpreter.wait_for_message
	$game_player.actor.defecate_level =0
	temp_1st_worm = rand(100) if $game_player.actor.state_stack("ParasitedMoonWorm") !=0
	
	if IsChcg? || $game_player.actor.action_state == :sex
		$game_map.interpreter.player_sex_get_tar_key if $game_player.actor.action_state == :sex && $game_player.manual_sex != true
		chcg_decider_scatoff(pose=rand(2)+1)
		temp_EventAnal = $game_player.actor.stat["EventAnal"]
		temp_EventVag = $game_player.actor.stat["EventVag"]
		temp_analopen = $game_player.actor.stat["analopen"]
		temp_vagopen = $game_player.actor.stat["vagopen"]
		#############################################################CHCG FRAME PEE ON##################################################################################
		$game_player.actor.stat["EventAnal"] = nil
		$game_player.actor.stat["EventVag"] = nil
		$game_player.actor.stat["analopen"] = 0
		$game_player.actor.stat["vagopen"] = 0
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -162; $game_player.actor.stat["chcg_y"] = -66 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -66 ; $game_player.actor.stat["chcg_y"] = -11 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		load_script("Data/Batch/poo_control.rb")
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		call_msg("common:Lona/PooMoonWorm") if $game_player.actor.state_stack("ParasitedMoonWorm") !=0 && temp_1st_worm >= 50
		#############################################################CHCG FRAME PEE OFF##################################################################################
		$game_player.actor.stat["EventAnal"] = nil
		$game_player.actor.stat["analopen"] = 0
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -96 ; $game_player.actor.stat["chcg_y"] = -12 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -171 ; $game_player.actor.stat["chcg_y"] = -76 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		load_script("Data/Batch/poo_control.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE ON##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent1"
		$game_player.actor.stat["analopen"] = 0
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -96 ; $game_player.actor.stat["chcg_y"] = -12 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -45 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		load_script("Data/Batch/poo_control.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE OFF##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent2"
		$game_player.actor.stat["analopen"] = 0
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -162; $game_player.actor.stat["chcg_y"] = -66 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -84 ; $game_player.actor.stat["chcg_y"] = -27 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		$game_player.actor.portrait.shake
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE ON##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent2"
		$game_player.actor.stat["analopen"] = 0
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -96 ; $game_player.actor.stat["chcg_y"] = -12 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -45 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		load_script("Data/Batch/poo_control.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE OFF##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent2"
		$game_player.actor.stat["analopen"] = 0
		$game_player.actor.add_state(39) if $game_player.actor.stat["EffectScat"] < 1
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -162; $game_player.actor.stat["chcg_y"] = -66 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -3 ; $game_player.actor.stat["chcg_y"] = -39 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		$game_player.actor.portrait.shake
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE ON##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent2"
		$game_player.actor.stat["analopen"] = 0
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -96 ; $game_player.actor.stat["chcg_y"] = -12 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -45 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		load_script("Data/Batch/poo_control.rb")
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE OFF##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent3"
		$game_player.actor.stat["analopen"] = 0
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -162; $game_player.actor.stat["chcg_y"] = -66 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -3 ; $game_player.actor.stat["chcg_y"] = -39 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		$game_player.actor.portrait.shake
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE ON##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent3"
		$game_player.actor.stat["analopen"] = 1
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -96 ; $game_player.actor.stat["chcg_y"] = -12 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -45 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		load_script("Data/Batch/poo_control.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE OFF##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent4"
		$game_player.actor.stat["analopen"] = 1
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -201 ; $game_player.actor.stat["chcg_y"] = -93 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -3 ; $game_player.actor.stat["chcg_y"] = -39 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		$game_player.actor.portrait.shake
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#################################################################################################################################################################
		#############################################################CHCG FRAME PEE ON##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent4"
		$game_player.actor.stat["analopen"] = 1
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -96 ; $game_player.actor.stat["chcg_y"] = -12 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -45 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		load_script("Data/Batch/poo_control.rb")
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE OFF##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent5"
		$game_player.actor.stat["analopen"] = 1
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -201 ; $game_player.actor.stat["chcg_y"] = -93 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -87 ; $game_player.actor.stat["chcg_y"] = -51 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		$game_player.actor.portrait.shake
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE ON##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent5"
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -96 ; $game_player.actor.stat["chcg_y"] = -12 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -45 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		load_script("Data/Batch/poo_control.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE OFF##################################################################################
		$game_player.actor.stat["EventAnal"] = "DefecateIncontinent5"
		lona_mood "#{chcg_decider_scatoff}fuck_#{chcg_shame_mood_decider}"
			
			
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -245 ; $game_player.actor.stat["chcg_y"] = -162 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -3 ; $game_player.actor.stat["chcg_y"] = -39 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		$game_message.add("\\t[commonH:Lona/poo5_auto_end]")
		$game_map.interpreter.wait_for_message
		$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#################################################################################################################################################################
		$story_stats["sex_record_defecate_incontinent"] +=1 #when chcg only
		$game_player.actor.stat["EventAnal"] = temp_EventAnal
		$game_player.actor.stat["EventVag"] = temp_EventVag
		$game_player.actor.stat["analopen"] = temp_analopen
		$game_player.actor.stat["vagopen"] = temp_vagopen
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	else #not chcg
		half_event_key_cleaner
		$cg = TempCG.new(["event_poo"])
		$game_player.actor.add_state(39) if $game_player.actor.stat["EffectScat"] < 1
		4.times{
			##############################################################normal on#################################################################
			$game_player.actor.stat["EventAnal"] = "DefecateIncontinent"
			pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="sta_damage")
			load_script("Data/Batch/poo_control.rb")
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
			pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="sta_damage")
			load_script("Data/Batch/poo_control.rb")
			#stats_batch3
			#stats_batch4
			#stats_batch5
			#stats_batch6
			#stats_batch7
			#message control
			$game_message.add("\\t[commonH:Lona/poo#{rand(5)}]")
			$game_map.interpreter.wait_for_message
		}
		$cg.erase
		call_msg("common:Lona/PooMoonWorm") if $game_player.actor.state_stack("ParasitedMoonWorm") !=0 && temp_1st_worm >= 50
		$cg.erase
	end
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
temp_Cums =$game_player.actor.cumsMeters["CumsMoonPie"]
$game_player.actor.healCums("CumsMoonPie", ((temp_Cums * 0.5).round)+$game_player.actor.constitution)
if $game_map.isOverMap
	$game_map.reserve_summon_event("WasteRandom10",$game_player.x,$game_player.y)
else
	$game_map.reserve_summon_event("ProjectilePoo",$game_player.x,$game_player.y)
end
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
half_event_key_cleaner if $game_player.actor.action_state == :sex
	
