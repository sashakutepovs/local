if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true if $game_player.actor.stat["AsVulva_MilkGland"] ==1 || $game_player.actor.stat["AsVulva_Skin"] ==1
$game_player.actor.stat["EventTargetPart"] = "Milking"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Playing OverEvent :MilkSplash"
$game_portraits.lprt.hide

$game_message.add("\\t[commonH:Lona/MilkSpray_begin]") if $story_stats["sex_record_MilkSplash_incontinence"].between?(0,14)
$game_message.add("\\t[commonH:Lona/MilkSpray_begin_pro]") if $story_stats["sex_record_MilkSplash_incontinence"] >=15
$game_map.interpreter.wait_for_message

until $game_actors[1].lactation_level <=500
	if IsChcg? || $game_player.actor.action_state == :sex
		$game_map.interpreter.player_sex_get_tar_key if $game_player.actor.action_state == :sex && $game_player.manual_sex != true
		temp_EventMouth = $game_player.actor.stat["EventMouth"] if $game_player.actor.stat["pose"] == "chcg5"
		$game_player.actor.stat["EventMouth"] = nil			if $game_player.actor.stat["pose"] == "chcg5"
		#############################################################CHCG FRAME MilkSplash##################################################################################
		$game_player.actor.stat["MilkSplash"] = 1
		lona_mood "#{chcg_decider_MilkSplash}fuck_#{chcg_shame_mood_decider}"
			#################################################################################
						if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -193 ; $game_player.actor.stat["chcg_y"] = -53 end
						if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -67 ; $game_player.actor.stat["chcg_y"] = -61 end
						if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -331 ; $game_player.actor.stat["chcg_y"] = -210 end
						$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
						$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
			##################################################################################
		load_script("Data/Batch/MilkSplash_control.rb")
		$game_actors[1].lactation_level -= 100+rand(100)
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/MilkSpray#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME MilkSplash##################################################################################
		$game_player.actor.stat["MilkSplash"] = 0
		lona_mood "#{chcg_decider_MilkSplash}fuck_#{chcg_shame_mood_decider}"
			#################################################################################
						if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -193 ; $game_player.actor.stat["chcg_y"] = -53 end
						if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -67 ; $game_player.actor.stat["chcg_y"] = -61 end
						if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -331 ; $game_player.actor.stat["chcg_y"] = -210 end
						$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
						$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
			##################################################################################
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/pee#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		##################################################################################
		$game_player.actor.stat["EventMouth"] = temp_EventMouth if $game_player.actor.stat["pose"] == "chcg5"
	
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	else #non chcg
		half_event_key_cleaner
		##############################################################normal on#################################################################
		$game_player.actor.stat["MilkSplash"] = 1
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="pee")
		load_script("Data/Batch/MilkSplash_control.rb")
		$game_actors[1].lactation_level -= 100+rand(100)
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/MilkSpray#{rand(5)}]")
		$game_map.interpreter.wait_for_message
		
		##############################################################normal off#################################################################
		$game_player.actor.stat["MilkSplash"] = 0
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="pee")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/MilkSpray#{rand(5)}]")
		$game_map.interpreter.wait_for_message
	end
	
end #until
################################################################################################
$story_stats["sex_record_MilkSplash_incontinence"] +=1 if IsChcg?
$story_stats["sex_record_MilkSplash"] +=1
half_event_key_cleaner if $game_player.actor.action_state == :sex
check_over_event
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
