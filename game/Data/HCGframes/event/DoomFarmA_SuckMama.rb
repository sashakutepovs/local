#可利用 EventMouth 預先設定事件類型 但變數本身與事件無關
#若KEY並不匹配則由單位之SWITCH2ID判斷之

$game_player.actor.stat["EventMouthRace"] = "Human"
$game_player.actor.stat["EventMouth"] ="Smegma"
tmpRace = $game_player.actor.stat["EventMouthRace"]
tmpPenisID = $game_player.actor.stat["EventMouth"]
tmpFailed = false
prev_gold = $game_party.gold
$game_portraits.setLprt("OldSlut_vag")
$game_portraits.lprt.shake
call_msg("TagMapDoomFarmA:JobSuck/Mama_start")
call_msg("TagMapDoomFarmA:JobSuck/Mama_begin1")

	portrait_hide
	chcg_background_color
	
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = 7
	$game_player.actor.portrait.update
	$game_player.actor.portrait.angle=90
	$game_portraits.rprt.set_position(-100,920)
	$game_portraits.setLprt("HumVagFemaleOldCHCG")
	$game_portraits.lprt.set_position(193+rand(4),-157+rand(4))
	SndLib.sound_chcg_full(rand(100)+50)
	call_msg("TagMapDoomFarmA:JobSuck/Mama_begin2")
	
	lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["mouth"] = [9,4].sample
	$game_player.actor.stat["HeadGround"] =0
	$game_player.actor.portrait.update
	$game_player.actor.portrait.angle=90
	$game_portraits.rprt.set_position(-110+70,850)
	SndLib.sound_chcg_full(rand(100)+50)
	$game_portraits.setLprt("HumVagFemaleOldCHCG")
	$game_portraits.lprt.set_position(233-80+rand(4),-77-120+rand(4))
	call_msg("TagMapDoomFarmA:JobSuck/Mama_begin3")
	
	#############################################################SUCKA PART
	tmp_loop_time= 5
	tmp_current_loop = 0
	tmp_loop_time.times{
		tmp_current_loop +=1
		
		lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["mouth"] = [3,5,6,7,8].sample
		$game_player.actor.stat["HeadGround"] =1
		$game_player.actor.portrait.update
		$game_player.actor.portrait.angle=90
		$game_portraits.rprt.set_position(-100+70+rand(5),880+rand(5))
		$game_portraits.setLprt("HumVagFemaleOldCHCG")
		$game_portraits.lprt.set_position(233-80+rand(4),-77-120+rand(4))
		wait(37+rand(5))
		SndLib.sound_chcg_full(rand(100)+50)
		$game_portraits.rprt.set_position(-100+70+rand(5),880+rand(5))
		wait(2+rand(3))
		
		lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["mouth"] = [9,4].sample
		$game_player.actor.stat["HeadGround"] =0
		$game_player.actor.portrait.update
		$game_player.actor.portrait.angle=90
		$game_portraits.rprt.set_position(-100+70-rand(5),850-rand(5))
		$game_portraits.setLprt("HumVagFemaleOldCHCG")
		$game_portraits.lprt.set_position(233-80+rand(4),-77-120+rand(4))
		load_script("Data/Batch/chcg_basic_frame_mouth.rb") if tmp_current_loop % 2 == 0 
		wait(17+rand(5))
		$game_portraits.rprt.set_position(-100+70-rand(5),850-rand(5))
		wait(2+rand(3))
	}
	tempTxtData =  ["DataNpcName:race/#{$game_player.actor.stat["EventMouthRace"]}" , "DataNpcName:part/penis"]
	$story_stats.sex_record_mouth(tempTxtData)
	call_msg("TagMapDoomFarmA:JobSuck/Mama_begin4")
	
	#################
						load_script("Data/Batch/FloorClearnScat_control.rb") # SmegmaDMG
	#################
	
	
	
	tmp_loop_time= 8
	tmp_current_loop = 0
	until tmp_current_loop >= tmp_loop_time
		tmp_current_loop +=1
		
		lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["mouth"] = [3,5,6,7,8].sample
		$game_player.actor.stat["HeadGround"] =1
		$game_player.actor.portrait.update
		$game_player.actor.portrait.angle=90
		$game_portraits.rprt.set_position(-100+70+rand(5),880+rand(5))
		$game_portraits.setLprt("HumVagFemaleOldCHCG")
		$game_portraits.lprt.set_position(233-80+rand(4),-77-120+rand(4))
		wait(27+rand(4))
		SndLib.sound_chcg_full(rand(100)+50)
		$game_portraits.rprt.set_position(-100+70+rand(5),880+rand(5))
		wait(2+rand(3))
		
		lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["mouth"] = [9,4].sample
		$game_player.actor.stat["HeadGround"] =0
		$game_player.actor.portrait.update
		$game_player.actor.portrait.angle=90
		$game_portraits.rprt.set_position(-100+70-rand(5),850-rand(5))
		$game_portraits.setLprt("HumVagFemaleOldCHCG")
		$game_portraits.lprt.set_position(233-80+rand(4),-77-120+rand(4))
		load_script("Data/Batch/chcg_basic_frame_mouth.rb") if tmp_current_loop % 2 == 0 
		wait(17+rand(4))
		$game_portraits.rprt.set_position(-100+70-rand(5),850-rand(5))
		wait(2+rand(3))
	end
	
	

call_msg("TagMapDoomFarmA:JobSuck/Mama_begin5")
if $story_stats["Setup_UrineEffect"] ==1
	$game_portraits.setLprt("nil")
	chcg_decider_basic_mouth(5)
	$game_player.actor.stat["pose"] == "chcg5"
	$game_player.actor.stat["EventMouthRace"] = "Human"
	2.times{
		$game_player.actor.stat["EventMouth"] ="Peeon"
		lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["chcg_x"] = -238 ; $game_player.actor.stat["chcg_y"] = -117
		$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
		$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
		$game_player.actor.stat["mouth"] = 4
		$game_player.actor.portrait.update
		load_script("Data/Batch/FloorClearnPee_control.rb")
		check_over_event
		$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
		$game_map.interpreter.wait_for_message
		$story_stats["sex_record_golden_shower"] +=1
	}
		$game_player.actor.stat["EventMouth"] ="Peeon"
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -238 ; $game_player.actor.stat["chcg_y"] = -117
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/FloorClearnPee_control.rb")
	check_over_event
	call_msg("TagMapDoomFarmA:JobSuck/Mama_begin6")
	
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -238 ; $game_player.actor.stat["chcg_y"] = -117
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/FloorClearnPee_control.rb")
	check_over_event
	call_msg("TagMapDoomFarmA:JobSuck/Mama_begin7")
	
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -238 ; $game_player.actor.stat["chcg_y"] = -117
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/FloorClearnPee_control.rb")
	check_over_event
	call_msg("TagMapDoomFarmA:JobSuck/Mama_begin8")
end
#load_script("Data/HCGframes/UniqueEvent_PeeonTavernHead.rb")



$story_stats["sex_record_cunnilingus_given_count"] += 1
$game_portraits.setLprt("nil")
lona_mood "normal"
portrait_hide
chcg_background_color_off
whole_event_end
player_force_update
$game_temp.choice = -1
