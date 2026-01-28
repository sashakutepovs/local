

if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Birth"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]},#{$game_player.actor.baby_race}"

$game_portraits.lprt.hide

if $game_player.actor.preg_level >=1
#High LVL MISCARRIAGE
	if $game_player.actor.preg_level.between?(3,5)
	chcg_background_color
	event_key_cleaner
	$game_player.actor.stat["vagopen"] =0
	$game_player.actor.stat["analopen"] =0
	chcg_decider_basic(pose=4)
	$game_player.actor.health -=5
	########################################################################frame 0 至中畫面 準備撥放###################################################################################################
	$game_player.actor.stat["EventVag"] = nil
	$game_player.actor.stat["vagopen"] =0
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/birth_basic_frame.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_heavy sta damage
	#message control
	$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	
	################################################################
	$game_player.actor.stat["EventVag"] = nil
	$game_player.actor.stat["vagopen"] =0
	$game_player.actor.add_state(28) #wet
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -68 ; $game_player.actor.stat["chcg_y"] = -166
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/brith_begin#{talk_style}#{rand(4)}]")
	$game_map.interpreter.wait_for_message
	
	########################################################################frame 0 至中畫面 準備撥放###################################################################################################
	$game_player.actor.stat["EventVag"] = nil
	$game_player.actor.stat["vagopen"] =0
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/birth_basic_frame.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_heavy sta damage
	#message control
	$game_message.add("\\t[commonH:Lona/brith_begin#{talk_style}#{rand(4)}]")
	$game_map.interpreter.wait_for_message
	
	################################################################
	$game_player.actor.stat["EventVag"] ="miscarriage1"
	$game_player.actor.stat["vagopen"] =0
	$game_player.actor.add_state(37)#bleed
	$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
	#$game_party.leader.setup_state(37,1) #bleed
	#$game_party.leader.setup_state(29,2) #preg
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -64 ; $game_player.actor.stat["chcg_y"] = -183
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/brith_begin#{talk_style}#{rand(4)}]")
	$game_map.interpreter.wait_for_message
	
	########################################################################frame 1###################################################################################################
	$game_player.actor.stat["EventVag"] = "miscarriage1"
	$game_player.actor.stat["vagopen"] =0
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/birth_basic_frame.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_heavy sta damage
	#message control
	$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	
	################################################################
	$game_player.actor.stat["EventVag"] ="miscarriage2"
	$game_player.actor.stat["vagopen"] =1
	$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
	#$game_party.leader.setup_state(29,1) #preg
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -64 ; $game_player.actor.stat["chcg_y"] = -183
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	
	########################################################################frame 1###################################################################################################
	$game_player.actor.stat["EventVag"] = "miscarriage2"
	$game_player.actor.stat["vagopen"] =1
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -90
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	load_script("Data/Batch/birth_basic_frame.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_heavy sta damage
	#message control
	$game_message.add("\\t[commonH:Lona/beaten#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	
	################################################################
	$game_player.actor.stat["EventVag"] ="miscarriage3"
	$game_player.actor.stat["vagopen"] =1
	$game_player.actor.stat["preg"] -=1 if $game_player.actor.stat["preg"] !=0 #preg
	#$game_party.leader.setup_state(29,1) #preg
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -68 ; $game_player.actor.stat["chcg_y"] = -273
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	$game_message.add("\\t[commonH:Lona/brith#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	
	################################################################
	$game_player.actor.stat["EventVag"] ="miscarriage3"
	$game_player.actor.stat["vagopen"] =1
	#$game_party.leader.setup_state(29,1) #preg
	lona_mood "chcg4fuck_#{chcg_mood_decider}"
	$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
	$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
	$game_player.actor.stat["chcg_x"] = -68 ; $game_player.actor.stat["chcg_y"] = -327
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	#message control
	SndLib.sound_gore(100,150)
	$game_message.add("...........")
	$game_map.interpreter.wait_for_message
	SndLib.sound_gore(90,150)
	$game_message.add("......")
	$game_map.interpreter.wait_for_message
	SndLib.sound_gore(80,150)
	$game_message.add("...")
	$game_map.interpreter.wait_for_message
	###############################################################
	event_key_cleaner
	chcg_background_color_off
	lona_mood "normal"
	end
#LOW LVL MISCARRIAGE
	if $game_player.actor.preg_level.between?(1,2)
		$game_player.actor.add_state(28) #wet
		$game_player.actor.add_state(37)#bleed
		$cg = TempCG.new(["event_miscarriage_low"])
		$game_message.add("\\t[common:Lona/preg_miscarriage_begin#{rand(4)}]")
		$game_map.interpreter.wait_for_message
		$game_message.add("\\t[common:Lona/preg_miscarriage_begin#{rand(4)}]")
		$game_map.interpreter.wait_for_message
		$cg.erase
		call_msg("common:Lona/preg_miscarriage_end0")
		call_msg("common:Lona/preg_miscarriage_end1")
	end
$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false
$game_player.actor.sta -= 50 if $game_player.actor.preg_level.between?(1,2)
$game_player.actor.sta -= 1000 if $game_player.actor.preg_level.between?(3,5)
$game_player.actor.mood -= 1000
$game_player.actor.healCums("CumsCreamPie",1000)
$story_stats["sex_record_miscarriage"] +=1
$game_player.actor.cleanup_after_birth
$game_player.actor.preg_level =0
end

