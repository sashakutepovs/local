call_msg("TagMapNoerTavern:Waifu/Opt_work_dance_end")
$game_map.interpreter.chcg_background_color(0,0,0,0,7)
	
	$game_timer.off
	
	tmpSEXY=get_character($game_map.get_storypoint("DanceCount")[2]).switch2_id[1]
	tmpSexState = 0#tmpSEXY / 1000
	
	tmpX,tmpY=$game_map.get_storypoint("DdrEndPt")
	$game_player.moveto(tmpX,tmpY)
	$game_player.direction = 4
	
	$game_map.npcs.each do |event|
		next if event.actor.action_state == :death
		event.npc_story_mode(false)
		next if event.summon_data == nil
		next event.npc_story_mode(false) if event.summon_data[:SkipJob]
		next if !event.summon_data[:customer]
		event.trigger = event.summon_data[:ot]
		next if !event.summon_data[:ox]
		next if !event.summon_data[:oy]
		next if event.actor.action_state == :stun
		next if event.actor.action_state == :sex
		next if event.actor.target != nil
		tmpSexState +=1 if event.animation !=nil
		event.turn_toward_character($game_player)
		event.animation =nil
		event.actor.process_target_lost # move_type_return
	end
	tmpSexState /=2
	
	prev_gold = get_character(0).switch2_id[2]
	cur_vol= $game_party.gold
	tmpSecord =(cur_vol - prev_gold)
	tmpSecord = 0 if 0 > tmpSecord
	$game_party.lose_gold(tmpSecord)
	
	#call_msg("$secord = #{tmpSecord}  SexySecord#{tmpSEXY}")
	
	#避免睡覺被卡死
	if $game_player.actor.sta > -100
		$game_player.animation = nil
		$game_player.call_balloon(0)
	end
	
$game_map.interpreter.chcg_background_color(0,0,0,255,-7)




############################################################get_reward from mama
$game_timer.off
tmpReward = tmpSecord/3

if $game_player.actor.sta<=-100
	return get_character(0).erase
elsif tmpSecord >1600
	call_msg("TagMapNoerTavern:Waifu/Opt_work_end_NoSummon2")
	optain_item_chain(tmpReward,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
elsif tmpSecord >1000
	call_msg("TagMapNoerTavern:Waifu/Opt_work_end_NoSummon1")
	optain_item_chain(tmpReward,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
	#normal
elsif tmpSecord >600
	call_msg("TagMapNoerTavern:Waifu/Opt_work_end_summon")
	optain_item_chain(tmpReward,["ItemCoin1","ItemCoin2","ItemCoin3"],true)
	#bad
elsif $game_player.player_slave?
	call_msg("TagMapNoerTavern:Waifu/WorkFailed0")
	call_msg("TagMapNoerTavern:Waifu/WorkFailed1")
	call_msg("TagMapNoerTavern:Waifu/WorkFailed2")
	call_msg("TagMapNoerTavern:Waifu/WorkFailed_slave")
else
	get_character(0).erase
	return load_script("Data/HCGframes/event/NoerTavernJobFailed.rb")
end


############################################################### chance rape?
$game_timer.off
if $game_player.actor.sta <= 0 || $game_player.player_slave?
	$game_player.actor.setup_state(161,10)
elsif tmpSexState >= 1
	$game_player.actor.setup_state(161,tmpSexState)
end

$game_player.actor.update_lonaStat
$game_player.update
tmpForward = true
tmpRape = false
$game_map.npcs.each do |event|
	next if event.summon_data == nil
	next if !event.summon_data[:customer]
	next if !event.summon_data[:ox]
	next if !event.summon_data[:oy]
	next if event.actor.action_state == :death
	next if event.actor.action_state == :stun
	next if event.actor.action_state == :sex
	next if event.actor.target != nil
	if tmpSexState >= 5
		event.npc.fucker_condition={"sex"=>[0, "="]}
		event.set_manual_move_type(8)
		event.move_type = 8 #move_search_player
		event.call_balloon([20,3,4].sample)
		tmpRape = true
	end
end
if tmpRape
	get_character($game_map.get_storypoint("UniqueGrayRat")[2]).delete if get_character($game_map.get_storypoint("UniqueGrayRat")[2]).npc?
	$game_map.npcs.each do |event|
		next if event.actor.action_state == :death
		next unless event.actor.sex == 0
		event.delete
	end
end



if $game_player.actor.sexy >= 60 && $game_player.actor.weak >= 110
call_msg("TagMapNoerTavern:Waifu/dance_low_sta_rape") if $game_player.actor.sta <= 0
call_msg("TagMapNoerTavern:Waifu/dance_rape1")
call_msg("TagMapNoerTavern:Waifu/dance_rape1_1")
tmpWaifuID = $game_map.get_storypoint("TavernWaifu")[2]
get_character(tmpWaifuID).moveto(1,1)
SndLib.ppl_CheerGroup(70)
call_msg("TagMapNoerTavern:Waifu/dance_rape1_2")
call_msg("TagMapNoerTavern:Waifu/dance_rape2")
end


tmpDdrBox=$game_map.get_storypoint("DdrBox")[2]
get_character(tmpDdrBox).delete
$game_timer.off



portrait_hide
get_character(0).erase
