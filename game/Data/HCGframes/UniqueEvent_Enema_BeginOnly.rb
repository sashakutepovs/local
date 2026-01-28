
return if $story_stats["Setup_ScatEffect"] == 0
	if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
		else 
		$game_player.actor.stat["allow_ograsm_record"] = false 
	end
	$game_player.actor.stat["AllowOgrasm"] = true
	$game_player.actor.stat["EventTargetPart"] = "Anal"
	p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_Enema"
	$game_portraits.lprt.hide

	chcg_background_color
	#half_event_key_cleaner
	temp_bellysize = $game_player.actor.stat["preg"]
	
	temp_EventAnalRace = $game_player.actor.stat["EventAnalRace"] #RACE需求防呆編碼
	$game_player.actor.stat["EventAnalRace"] = "Human" if $game_player.actor.stat["EventAnalRace"] == nil #RACE需求防呆編碼
	
	chcg_decider_basic(pose=2)
	$game_player.actor.stat["analopen"] = 0
	########################################################################frame 0 至中畫面 準備撥放###################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema1"
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -202 ; $game_player.actor.stat["chcg_y"] = -39
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/Enema_begin]")
	$game_map.interpreter.wait_for_message
	##################################################################
	$game_player.actor.stat["EventAnal"] ="Enema1"
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -95 ; $game_player.actor.stat["chcg_y"] = -44
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/Enema_begin2]")
	$game_map.interpreter.wait_for_message
	
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema2"
	lona_mood "chcg2fuck_#{chcg_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -156 ; $game_player.actor.stat["chcg_y"] = -51
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/chcg_basic_frame_anal.rb")
	load_script("Data/Batch/take_other_anal.rb")
	load_script("Data/Batch/take_sex_wound_groin.rb")
	$story_stats.sex_record_anal(["DataNpcName:part/enema"])
	#$story_stats.sex_record_anal(["DataNpcName:race/#{$game_player.actor.stat["EventAnalRace"]}","DataNpcName:part/enema"])
	$story_stats["sex_record_anal_count"] +=1
	check_over_event
	#stats_batch5
	#stats_batch6
	#add_miror health damage
	#message control
	$game_message.add("\\t[commonH:Lona/Enema_begin3]")
	$game_map.interpreter.wait_for_message
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema3"
	$game_player.actor.stat["analopen"] = 1
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -180 ; $game_player.actor.stat["chcg_y"] = -53
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/enema_control.rb")
	check_over_event
	#stats_batch5
	#stats_batch6
	#add_miror health damage
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema4"
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -156 ; $game_player.actor.stat["chcg_y"] = -51
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/enema_control.rb")
	check_over_event
	#stats_batch5
	#stats_batch6
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema4"
	if $game_player.actor.stat["preg"] !=3 then $game_player.actor.stat["preg"] +=1 end
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -97
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/enema_control.rb")
	$game_message.add("\\t[commonH:Lona/Enema_common]")
	$game_map.interpreter.wait_for_message
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema5"
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -156 ; $game_player.actor.stat["chcg_y"] = -51
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/enema_control.rb")
	check_over_event
	#stats_batch5
	#stats_batch6
	#add_miror health damage
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema5"
	if $game_player.actor.stat["preg"] !=3 then $game_player.actor.stat["preg"] +=1 end
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -97
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/enema_control.rb")
	$game_message.add("\\t[commonH:Lona/Enema_common]")
	$game_map.interpreter.wait_for_message
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema6"
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -156 ; $game_player.actor.stat["chcg_y"] = -51
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/enema_control.rb")
	check_over_event
	#stats_batch5
	#stats_batch6
	#add_miror health damage
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema6"
	if $game_player.actor.stat["preg"] !=3 then $game_player.actor.stat["preg"] +=1 end
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -164 ; $game_player.actor.stat["chcg_y"] = -97
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_message.add("\\t[commonH:Lona/Enema_common]")
	$game_map.interpreter.wait_for_message
	load_script("Data/Batch/enema_control.rb")
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema7"
	$game_player.actor.stat["analopen"] = 0
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -197 ; $game_player.actor.stat["chcg_y"] = -43
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/enema_control.rb")
	check_over_event
	#stats_batch5
	#stats_batch6
	#add_miror health damage
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema7"
	$game_player.actor.stat["analopen"] = 0
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -117 ; $game_player.actor.stat["chcg_y"] = -45
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.shake
	SndLib.sound_chs_buchu(100)
	SndLib.sound_chs_dopyu(100,rand(50)+50)
	SndLib.sound_chcg_scat(20,50)
	$game_message.add("\\t[commonH:Lona/Enema_end1#{talk_style}]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################
	$game_player.actor.stat["EventAnal"] ="Enema7"
	$game_player.actor.stat["analopen"] = 0
	$game_player.actor.portrait.shake
	lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.portrait.update
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -115 ; $game_player.actor.stat["chcg_y"] = -40
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.shake
	SndLib.sound_chs_buchu(100)
	SndLib.sound_chs_dopyu(100,rand(50)+50)
	SndLib.sound_chcg_scat(20,50)
	$game_message.add("\\t[commonH:Lona/Enema_end2]")
	$game_map.interpreter.wait_for_message
	##############################################################################################################################################################################

	$game_player.actor.stat["EventTargetPart"] = nil
	$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

	$game_player.actor.stat["EventAnalRace"] = temp_EventAnalRace #RACE需求防呆編碼
	$story_stats["dialog_defecated"] =1 #chain event scat
	$story_stats["sex_record_enemaed"] +=1
	$game_player.actor.stat["preg"] = temp_bellysize
	$game_actors[1].defecate_level = 1000 # this is enema, it direct get full scat level

	half_event_key_cleaner
	chcg_background_color_off
