if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0 || $game_actors[1].state_stack(107) !=0
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture" if $game_actors[1].state_stack(106) !=0 && $game_actors[1].state_stack(107) ==0
$game_player.actor.stat["EventTargetPart"] = "Shame" if $game_actors[1].state_stack(107) ==1
$game_player.actor.stat["EventTargetPart"] = "Semen" if $game_actors[1].state_stack(102) >=1
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_FloorClearnCums"
p "race not support this event" if !["Orkind","Human","Deepone","Moot","Fishkind","Goblin","Troll"].include?($game_player.actor.stat["EventMouthRace"])
$game_portraits.lprt.hide

chcg_background_color
#half_event_key_cleaner
chcg_decider_basic(pose=3)
chcg_add_SemenWaste("EventMouthRace")
chcg_add_SemenWaste("EventMouthRace")
chcg_add_SemenWaste("EventMouthRace")
chcg_add_SemenWaste("EventMouthRace")
chcg_add_SemenWaste("EventMouthRace")
temp_EventMouthRace = $game_player.actor.stat["EventMouthRace"] #RACE需求防呆編碼
$game_player.actor.stat["EventMouthRace"] = "Human" if $game_player.actor.stat["EventMouthRace"] == nil #RACE需求防呆編碼
########################################################################frame 0 至中畫面 準備撥放###################################################################################################
$game_player.actor.stat["HeadGround"] =0
$game_player.actor.stat["PushDown"] =1
$game_player.actor.stat["EventMouth"] ="FloorClearnCums1"
lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -318 ; $game_player.actor.stat["chcg_y"] = -149
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/FloorClearnCums_begin1]")
$game_map.interpreter.wait_for_message
##################################################################
$game_player.actor.stat["HeadGround"] =1
$game_player.actor.stat["PushDown"] =1
$game_player.actor.stat["EventMouth"] ="FloorClearnCums2"
lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
$game_player.actor.portrait.update
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
$game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -160
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_player.actor.portrait.shake
#message control
$game_message.add("\\t[commonH:Lona/FloorClearnCums_begin2]")
$game_map.interpreter.wait_for_message
##############################################################################
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    Choice         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
$game_message.add("\\t[commonH:Lona/FloorClearnPee_choice1]")
$game_map.interpreter.wait_for_message
if $game_temp.choice == 1
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -160
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/FloorClearnCums_choice_no]")
	$game_map.interpreter.wait_for_message
	##########################################################################################################
	if (10+$game_actors[1].wisdom)*rand(100) >= 50*rand(100)
		$game_message.add("\\t[commonH:Lona/FloorClearnCums_testWIN]")
		$game_map.interpreter.wait_for_message
	else
		$game_message.add("\\t[commonH:Lona/FloorClearnCums_testLOSE]")
		$game_map.interpreter.wait_for_message
		$game_player.actor.stat["HeadGround"] =0
		$game_player.actor.stat["PushDown"] =0
		half_event_key_cleaner
		chcg_background_color_off
		load_script("Data/Batch/common_MCtorture_FunBeaten_event.rb")
		$game_message.add("\\t[commonH:Lona/FloorClearnCums_choice2]")
		$game_map.interpreter.wait_for_message
		if $game_temp.choice == 1
			$game_message.add("\\t[commonH:Lona/FloorClearnCums_choice_no]")
			$game_map.interpreter.wait_for_message
			if (20+$game_actors[1].wisdom)*rand(100) >= 50*rand(100)
				$game_message.add("\\t[commonH:Lona/FloorClearnCums_testWIN]")
				$game_map.interpreter.wait_for_message
			else
				load_script("Data/Batch/common_MCtorture_FunBeaten_event.rb")
				$game_message.add("\\t[commonH:Lona/FloorClearnCums_choice3]")
				$game_map.interpreter.wait_for_message
				if $game_temp.choice == 1
					$game_message.add("\\t[commonH:Lona/FloorClearnCums_choice_no]")
					$game_map.interpreter.wait_for_message
					if (20+$game_actors[1].wisdom)*rand(100) >= 50*rand(100)
						$game_message.add("\\t[commonH:Lona/FloorClearnCums_testWIN]")
						$game_map.interpreter.wait_for_message
					else
						load_script("Data/Batch/common_MCtorture_FunEnd_event.rb")
						$game_message.add("\\t[commonH:Lona/FloorClearnCums_testLOSE_end]")
						$game_map.interpreter.wait_for_message
					end
				end
			end
		end
	end
end
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    Choice END     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
$game_player.actor.stat["HeadGround"] =0
$game_player.actor.stat["PushDown"] =0
$game_player.actor.stat["EventMouth"] = temp_EventMouthRace
half_event_key_cleaner
chcg_background_color_off

#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    AGREE          ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
#▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
if $game_temp.choice == 0
	chcg_background_color
	half_event_key_cleaner
	temp_EventMouthRace = $game_player.actor.stat["EventMouthRace"]
	chcg_decider_basic(pose=3)
	$game_player.actor.stat["EventMouthRace"] = "Human" if $game_player.actor.stat["EventMouthRace"] == nil
	##############################################################################
	$game_player.actor.stat["HeadGround"] =1
	$game_player.actor.stat["PushDown"] =1
	$game_player.actor.stat["EventMouth"] ="FloorClearnCums2"
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -250
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/FloorClearnCums_begin3]")
	$game_map.interpreter.wait_for_message
	##############################################################################
	##############################################################################################################################
	$game_player.actor.stat["HeadGround"] =1
	$game_player.actor.stat["PushDown"] =1
	$game_player.actor.stat["EventMouth"] ="FloorClearnCums3"
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -250
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#stats_batch1
	load_script("Data/Batch/FloorClearnCums_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/FloorClearnCums_begin4]")
	$game_map.interpreter.wait_for_message
	###############################################################################################################################
	$game_player.actor.stat["HeadGround"] =1
	$game_player.actor.stat["PushDown"] =1
	$game_player.actor.stat["EventMouth"] ="FloorClearnCums4"
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 7
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -250
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#stats_batch1
	load_script("Data/Batch/FloorClearnCums_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/FloorClearnCums_begin5]")
	$game_map.interpreter.wait_for_message
	###############################################################################################################################
	$game_player.actor.stat["HeadGround"] =1
	$game_player.actor.stat["PushDown"] =1
	$game_player.actor.stat["EventMouth"] ="FloorClearnCums4"
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -275
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	###############################################################################################################################
	$game_player.actor.stat["HeadGround"] =1
	$game_player.actor.stat["PushDown"] =1
	$game_player.actor.stat["EventMouth"] ="FloorClearnCums5"
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 9
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -275
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#stats_batch1
	load_script("Data/Batch/FloorClearnCums_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/FloorClearnCums_begin6]")
	$game_map.interpreter.wait_for_message
	###############################################################################################################################
	$game_player.actor.stat["HeadGround"] =1
	$game_player.actor.stat["PushDown"] =1
	$game_player.actor.stat["EventMouth"] ="FloorClearnCums5"
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 6
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -275
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	###############################################################################################################################
	$game_player.actor.stat["HeadGround"] =1
	$game_player.actor.stat["PushDown"] =1
	$game_player.actor.stat["EventMouth"] ="FloorClearnCums6"
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 8
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -322 ; $game_player.actor.stat["chcg_y"] = -277
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#stats_batch1
	load_script("Data/Batch/FloorClearnCums_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	#stats_batch7
	#message control
	$game_message.add("\\t[commonH:Lona/FloorClearnCums_end]")
	$game_map.interpreter.wait_for_message
	###############################################################################################################################
	$game_player.actor.stat["HeadGround"] =1
	$game_player.actor.stat["PushDown"] =1
	$game_player.actor.stat["EventMouth"] ="FloorClearnCums6"
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 6
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -322 ; $game_player.actor.stat["chcg_y"] = -277
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/frame_weak#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$game_message.add("\\t[commonH:Lona/FloorClearnCums_end#{talk_style}]")
	$game_map.interpreter.wait_for_message
	###############################################################################################################################
	$story_stats["sex_record_FloorClearnCums"] +=1
	$story_stats["sex_record_semen_swallowed"] +=1
	$game_player.actor.stat["HeadGround"] =0
	$game_player.actor.stat["PushDown"] =0
	$game_player.actor.stat["EventMouthRace"] = temp_EventMouthRace #race需求防呆編碼
	check_over_event
end
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
half_event_key_cleaner
chcg_background_color_off
