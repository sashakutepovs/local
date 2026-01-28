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
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} Playing OverEvent :AnalTaken"
$game_portraits.lprt.hide

#檢察處女
if $story_stats["dialog_anal_virgin"] ==1
	$story_stats["dialog_anal_virgin"] =0
	$game_message.add("\\t[commonH:Lona/AnalTaken_begin]")
	$game_map.interpreter.wait_for_message
	$game_actors[1].add_state(40) #bleed anal
	if IsChcg? || $game_player.actor.action_state == :sex
		$game_map.interpreter.player_sex_get_tar_key if $game_player.actor.action_state == :sex && $game_player.manual_sex != true
		#建立占存姿勢表 避免超越事件造成error
		temp_pose = 1 
		case $game_player.actor.stat["pose"]
			when "chcg1" ; temp_pose = 1
			when "chcg2" ; temp_pose = 2
			when "chcg3" ; temp_pose = 3
			when "chcg4" ; temp_pose = 4
			when "chcg5" ; temp_pose = 5
		else
		temp_pose = 1
		end
		chcg_decider_basic_arousal(pose=temp_pose)
		#############################################################CHCG FRAME PEE ON##################################################################################
		lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_cumming_mood_decider}"
			#################################################################################
			
			
						if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -56 end
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -101 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -152 end
						if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -69 ; $game_player.actor.stat["chcg_y"] = -98 end
						if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
						$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
						$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
			##################################################################################
		$cg = TempCG.new(["event_AnalTaken"])
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		flash_screen(Color.new(255,0,0,200),8,false)
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}0]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE OFF##################################################################################
		lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_cumming_mood_decider}"
			#################################################################################
			
			
						if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -64 end
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -118 ; $game_player.actor.stat["chcg_y"] = -48 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -193 ; $game_player.actor.stat["chcg_y"] = -124 end
						if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -71 end
						if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
						$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
						$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
			##################################################################################
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		flash_screen(Color.new(255,0,0,200),8,false)
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}1]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE ON##################################################################################
		lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_cumming_mood_decider}"
			#################################################################################
			
			
						if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -56 end
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -101 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -152 end
						if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -69 ; $game_player.actor.stat["chcg_y"] = -98 end
						if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
						$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
						$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
			##################################################################################
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		flash_screen(Color.new(255,0,0,200),8,false)
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}2]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE OFF##################################################################################
		lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_cumming_mood_decider}"
			#################################################################################
			
			
						if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -64 end
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -118 ; $game_player.actor.stat["chcg_y"] = -48 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -193 ; $game_player.actor.stat["chcg_y"] = -124 end
						if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -71 end
						if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
						$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
						$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
			##################################################################################
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}3]")
		$game_map.interpreter.wait_for_message
		#############################################################CHCG FRAME PEE ON##################################################################################
		lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_cumming_mood_decider}"
			#################################################################################
			
			
						if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -56 end
						if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -101 end
						if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -143 ; $game_player.actor.stat["chcg_y"] = -152 end
						if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -69 ; $game_player.actor.stat["chcg_y"] = -98 end
						if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
						$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
						$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
			##################################################################################
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}4]")
		$game_map.interpreter.wait_for_message
		
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
		#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
	else
		##############################################################normal on#################################################################
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="_#{chcg_cumming_mood_decider}")
		$cg = TempCG.new(["event_AnalTaken"])
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		flash_screen(Color.new(255,0,0,200),8,false)
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}0]")
		$game_map.interpreter.wait_for_message
		
		##############################################################normal off#################################################################
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="_#{chcg_cumming_mood_decider}")
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		flash_screen(Color.new(255,0,0,200),8,false)
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}1]")
		$game_map.interpreter.wait_for_message
		##############################################################normal on#################################################################
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="_#{chcg_cumming_mood_decider}")
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		flash_screen(Color.new(255,0,0,200),8,false)
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}2]")
		$game_map.interpreter.wait_for_message
		
		##############################################################normal off#################################################################
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="_#{chcg_cumming_mood_decider}")
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}3]")
		$game_map.interpreter.wait_for_message
		##############################################################normal on#################################################################
		pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="_#{chcg_cumming_mood_decider}")
		load_script("Data/Batch/chcg_basic_frame_anal.rb")
		#stats_batch3
		#stats_batch4
		#stats_batch5
		#stats_batch6
		#stats_batch7
		#message control
		$game_message.add("\\t[commonH:Lona/anal_taken#{talk_style}4]")
		$game_map.interpreter.wait_for_message
	end
	#########################################################################################################################################
	$game_message.add("\\t[commonH:Lona/AnalTaken_end]")
	$game_map.interpreter.wait_for_message
	$cg.erase
end
half_event_key_cleaner if $game_player.actor.action_state == :sex
check_over_event
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false