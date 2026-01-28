p "Playing OverEvent :Arousal warning (wet)"
$game_portraits.lprt.hide

if IsChcg? || $game_player.actor.action_state == :sex
	$game_map.interpreter.player_sex_get_tar_key if $game_player.actor.action_state == :sex && $game_player.manual_sex != true
		#CHCG狀態
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
	$game_actors[1].add_state(28) #add wet
	lona_mood "#{chcg_decider_basic_arousal}fuck_#{chcg_mood_decider}"
	#################################################################################
	
	
				if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -123 end
				if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -212 ; $game_player.actor.stat["chcg_y"] = -107 end
				if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -100 end
				if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -68 ; $game_player.actor.stat["chcg_y"] = -138 end
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	##################################################################################
	$game_actors[1].gain_exp(rand(65)+$game_actors[1].level)
	$game_message.add("\\t[commonH:Lona/wet#{talk_style}#{rand(3)}]")
	$game_map.interpreter.wait_for_message
	
##################################################################################
	else
	#其他狀態
	$game_actors[1].add_state(28) #add wet
	lona_mood "shy"  if $game_player.actor.stat["persona"] != "slut"
	lona_mood "lewd" if $game_player.actor.stat["persona"] == "slut"
	$game_actors[1].gain_exp(rand(65)+$game_actors[1].level)
	$game_message.add("\\t[commonH:Lona/wet#{talk_style}#{rand(3)}]")
	$game_map.interpreter.wait_for_message
end
half_event_key_cleaner if $game_player.actor.action_state == :sex

