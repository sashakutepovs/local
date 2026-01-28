
$game_map.interpreter.chcg_background_color(0,0,0,0,7)

	tmpWkX,tmpWkY,tmpWkID =  $game_map.get_storypoint("WakeUp")
	tmpTorX,tmpTorY,tmpTorID =  $game_map.get_storypoint("TorPT")
	tmpMcX,tmpMcY,tmpMcID =  $game_map.get_storypoint("MapCont")
	tmpMcX,tmpMcY,tmpMcID =  $game_map.get_storypoint("MapCont")
	tmpLLX,tmpLLY,tmpLLID =  $game_map.get_storypoint("GuardA")  #lightL
	tmpLRX,tmpLRY,tmpLRID =  $game_map.get_storypoint("Cam1")  #lightR
	get_character(tmpWkID).switch2_id[1] = 0
	#get_character(tmpMcID).trigger = -1
	set_event_force_page(tmpTorID,2)

	$game_player.moveto(tmpTorX,tmpTorY)
	$game_player.direction = 2
	$game_player.actor.setup_state(161,10)

	get_character(tmpLLID).moveto(tmpTorX-2,tmpTorY)
	get_character(tmpLRID).moveto(tmpTorX+2,tmpTorY)
	##set NPC to dancer
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:customer]
		next if event.actor.action_state == :death
		next if event.actor.action_state == :stun
		posi=$game_map.region_map[12].sample
		next if $game_map.events_xy(posi[0],posi[1]).any?{|ev| ev.npc?}
		event.setup_audience
		event.move_type =0
		event.summon_data[:o_posiX] = event.x
		event.summon_data[:o_posiY] = event.y
		event.summon_data[:o_posiD] = event.direction
		event.summon_data[:o_fucker_condition] = event.npc.fucker_condition
		event.moveto(posi[0],posi[1])
		event.npc.fucker_condition={"sex"=>[0, "="]}
		event.animation = nil
	end



	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:customer]
		next if event.actor.action_state == :death
		next if event.actor.action_state == :stun
		next if event.faced_character?($game_player)
		event.turn_toward_character($game_player)
		event.animation = nil
	end

	portrait_hide

$game_map.interpreter.chcg_background_color(0,0,0,255,-7)
########################################################################################################################
$story_stats["HiddenOPT0"] = "1"
$story_stats["HiddenOPT1"] = "1"
lewdJoked = false
danced_times = 0
score = 0
times_did = 0
until times_did >= 3# || score >=6
	call_msg("TagMapBanditCamp1:HevGang/begin#{rand(2)}") if times_did == 0#[跳舞<r=HiddenOPT0>,說笑話<r=HiddenOPT1>]
	call_msg("TagMapBanditCamp1:HevGang/begin_encore") if times_did > 0#[跳舞<r=HiddenOPT0>,說笑話<r=HiddenOPT1>]
	call_msg("TagMapBanditCamp1:HevGang/opt")
	$game_player.animation = nil

	#################################################################### DANCE
	if $game_temp.choice == 0
		$game_temp.choice = -1
		call_msg("TagMapBanditCamp1:HevGang/Dance") if danced_times == 0
		danced_times += 1
		times_did += 1
		$game_player.actor.sta -= 1
		portrait_hide
		$game_player.animation = $game_player.animation_dance
		dance_score = mini_game_ddr
		if dance_score >= 2
			balloon = [25,24]
			score += 2
			SndLib.ppl_CheerGroup
			dialog = "TagMapBanditCamp1:HevGang/Dance_success_2"
		elsif dance_score >= 1
			balloon = [3,4]
			score += 1
			SndLib.ppl_CheerGroup
			dialog = "TagMapBanditCamp1:HevGang/Dance_success_1"
		else
			balloon = [5,7,12,10,8,15]
			score -= 1
			SndLib.ppl_BooGroup
			dialog = "TagMapBanditCamp1:HevGang/Dance_failed#{rand(3)}"
		end
		wait(30)
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next if !event.summon_data[:customer]
			next if event.actor.action_state == :death
			next if event.actor.action_state == :stun
			next if rand(100) >= 50
			event.call_balloon(balloon.sample)
		end
		call_msg(dialog)
		portrait_hide
	end
	#################################################################### Joke
	if $game_temp.choice == 1
		$game_temp.choice = -1
		$story_stats["HiddenOPT1"] = "0"
		lewdJoked = true
		times_did += 1
		portrait_hide
		call_msg("TagMapBanditCamp1:HevGang/Joke0")   #todo talk a joke and they like it
		if $game_player.actor.stat["Prostitute"] >= 1 || $game_player.actor.wisdom_trait >= 15
			call_msg("TagMapBanditCamp1:HevGang/Joke1")
			call_msg("TagMapBanditCamp1:HevGang/Joke2_#{rand(3)}")
			call_msg("TagMapBanditCamp1:HevGang/Joke_success")   #todo talk a joke and they like it
			balloon = [3,4]
			SndLib.ppl_CheerGroup
			score += 2
		else
			call_msg("TagMapBanditCamp1:HevGang/Joke_failed")   # she failed to say a joke.    that feels nothing
			balloon = [5,7,12,10,8,15]
			SndLib.ppl_BooGroup
		end
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next if !event.summon_data[:customer]
			next if event.actor.action_state == :death
			next if event.actor.action_state == :stun
			next if rand(100) >= 50
			event.call_balloon(balloon.sample)
		end
		#call_msg("TagMapBanditCamp1:HevGang/Dance2")
		portrait_hide
	end
end

##################################3 todo  if score >=6   too lewd rape
$game_player.animation = nil
if score >=6
	#too lewd rape
	#remove all rape begin event and end event
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:customer]
		next if event.actor.action_state == :death
		next if event.actor.action_state == :stun
		next unless event.summon_data[:o_posiX]
		event.actor.npc.sex_taste["sex_fetish_appetizer"] = []
		event.actor.npc.sex_taste["sex_fetish_ending"] = []
	end
	call_msg("TagMapBanditCamp1:HevGang/score_success_full")
elsif score >=4
	#in between pass
	#do nothing  they will all gone
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:customer]
		next if event.actor.action_state == :death
		next if event.actor.action_state == :stun
		next unless event.summon_data[:o_fucker_condition]
		#event.npc.fucker_condition = event.summon_data[:o_fucker_condition]
		#event.npc.fucker_condition = {"sex"=>[65535, "="]}
		event.animation = nil
		event.actor.process_target_lost
	end
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:customer]
		event.npc.fucker_condition = {"sex"=>[65535, "="]}
	end
	call_msg("TagMapBanditCamp1:HevGang/score_success")
	tmpWkX = $game_player.x
	tmpWkY = $game_player.y
	tmp1_X,tmp1_Y=tmpWkX+1+rand(2),tmpWkY
	tmp2_X,tmp2_Y=tmpWkX+1+rand(2),tmpWkY
	tmp3_X,tmp3_Y=tmpWkX+1+rand(2),tmpWkY
	tmp4_X,tmp4_Y=tmpWkX+1+rand(2),tmpWkY
	food = ["ItemOrange","ItemCarrot","ItemPotato","ItemPotato","ItemDreg","ItemSopGoodMystery"]
	$game_map.reserve_summon_event(food.sample,tmp1_X,tmp1_Y) if rand(100) >= 50
	$game_map.reserve_summon_event(food.sample,tmp2_X,tmp2_Y)
	$game_map.reserve_summon_event(food.sample,tmp2_X,tmp2_Y)
	$game_map.reserve_summon_event(food.sample,tmp3_X,tmp3_Y)
else
	#failed angry rape
	#do what original design do
	call_msg("TagMapBanditCamp1:HevGang/score_failed")
end


$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
$game_temp.choice = -1

return eventPlayEnd
