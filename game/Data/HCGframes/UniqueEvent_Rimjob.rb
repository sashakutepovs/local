
	
	tmp_loop_time= 8
	tmp_current_loop = 0
	until tmp_current_loop >= tmp_loop_time
		tmp_current_loop +=1
		tmpLonaPosX = -100
		tmpLonaPosY =  50
		tmpManPosX =  263
		tmpManPosY =  -177
		lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["mouth"] = [3,5,6,7,8].sample
		$game_player.actor.stat["HeadGround"] =1
		$game_player.actor.portrait.update
		#$game_player.actor.portrait.angle=90
		$game_portraits.rprt.set_position(tmpLonaPosX+rand(5),tmpLonaPosY+30+rand(5))
		$game_portraits.setLprt("Rimjob_Human_basic1")
		$game_portraits.lprt.set_position(tmpManPosX+rand(4),tmpManPosY+rand(4))
		wait(27+rand(4))
		SndLib.sound_chcg_full(rand(100)+50)
		$game_portraits.rprt.set_position(tmpLonaPosX+rand(5),tmpLonaPosY+30+rand(5))
		wait(2+rand(3))
		
		lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
		$game_player.actor.stat["mouth"] = [9,4].sample
		$game_player.actor.stat["HeadGround"] =0
		$game_player.actor.portrait.update
		#$game_player.actor.portrait.angle=90
		$game_portraits.rprt.set_position(tmpLonaPosX-rand(5),tmpLonaPosY-rand(5))
		$game_portraits.setLprt("Rimjob_Human_basic1")
		$game_portraits.lprt.set_position(tmpManPosX+rand(4),tmpManPosY+rand(4))
		#load_script("Data/Batch/chcg_basic_frame_mouth.rb") if tmp_current_loop % 2 == 0 
		wait(17+rand(4))
		$game_portraits.rprt.set_position(tmpLonaPosX-rand(5),tmpLonaPosY-rand(5))
		wait(2+rand(3))
	end
	

$game_portraits.setLprt("nil")
$game_portraits.setLprt("nil")
