if $game_map.threat
 SndLib.sys_buzzer
 $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
 return
end

tmpMamaX,tmpMamaY,tmpMamaID = $game_map.get_storypoint("mama")
tmpPapaX,tmpPapaY,tmpPapaID = $game_map.get_storypoint("papa")
tmpSonX,tmpSonY,tmpSonID = $game_map.get_storypoint("son")
tmpMcX,tmpMcY,tmpMcID = $game_map.get_storypoint("MapCont")
tmpMtX,tmpMtY,tmpMtID = $game_map.get_storypoint("MainTable")
tmpHtcX,tmpHtcY,tmpHtcID = $game_map.get_storypoint("HouseToOutC")
tmpFaX,tmpFaY,tmpFaID = $game_map.get_storypoint("FoodA")
tmpFbX,tmpFbY,tmpFbID = $game_map.get_storypoint("FoodB")

call_msg("TagMapDoomFarmA:Dinner/begin_0")
portrait_hide
chcg_background_color(0,0,0,0,7)
	call_msg("TagMapDoomFarmA:Dinner/begin_0_1")
	$game_map.set_fog(nil)
	weather_stop
	$game_player.moveto(tmpMtX+1,tmpMtY)
	get_character(tmpSonID).moveto(tmpMtX+1,tmpMtY-1)
	get_character(tmpPapaID).moveto(tmpMtX-1,tmpMtY-1)
	get_character(tmpMamaID).moveto(tmpMtX-1,tmpMtY)
	$game_player.direction = 4
	get_character(tmpSonID).direction = 4
	get_character(tmpPapaID).direction = 6
	get_character(tmpMamaID).direction = 6
	
	SndLib.sound_eat(90)
	wait(50+rand(20))
	SndLib.sound_eat(85)
	wait(50+rand(20))
	SndLib.sound_eat(90)
	wait(50+rand(20))
	$game_player.actor.sat += 100
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapDoomFarmA:Dinner/begin_1")
get_character(tmpMamaID).turn_toward_character(get_character(tmpPapaID))
call_msg("TagMapDoomFarmA:Dinner/begin_1_1")
get_character(tmpMamaID).turn_toward_character($game_player)
call_msg("TagMapDoomFarmA:Dinner/begin_1_2")
$game_player.turn_toward_character(get_character(tmpSonID))
get_character(tmpSonID).turn_toward_character($game_player)
call_msg("TagMapDoomFarmA:Dinner/begin_2")
$game_player.turn_toward_character(get_character(tmpMamaID))
get_character(tmpSonID).turn_toward_character(get_character(tmpMamaID))
call_msg("TagMapDoomFarmA:Dinner/begin_3") #[謝謝招待,繼續享用]
if $game_temp.choice == 0
	call_msg("TagMapDoomFarmA:Dinner/begin_3_opt_Leave")
	chcg_background_color(0,0,0,0,7)
		get_character(tmpMamaID).moveto(tmpMamaX,tmpMamaY)
		get_character(tmpSonID).moveto(tmpSonX,tmpSonY)
		get_character(tmpPapaID).moveto(tmpPapaX,tmpPapaY)
		$game_player.moveto(tmpHtcX,tmpHtcY)
		get_character(tmpMamaID).direction = 2
		get_character(tmpSonID).direction = 2
		get_character(tmpPapaID).direction = 2
		$game_player.direction = 2
	chcg_background_color(0,0,0,255,-7)
else
	call_msg("TagMapDoomFarmA:Dinner/begin_3_opt_Eat0")
	portrait_hide
	get_character(tmpFbID).moveto(1,1)
	get_character(tmpMamaID).npc_story_mode(true)
	get_character(tmpMamaID).direction = 4
	get_character(tmpMamaID).move_forward
	wait(60)
	get_character(tmpMamaID).direction = 8
	get_character(tmpMamaID).move_forward
	wait(60)
	6.times{
	get_character(tmpMamaID).direction = 4
	get_character(tmpMamaID).move_forward
	wait(60)
	}
	get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_atk_mh
	wait(60)
	get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_atk_sh
	get_character(tmpFaID).moveto(1,1)
	get_character(tmpFbID).moveto(tmpFaX,tmpFaY)
	wait(60)
	6.times{
	get_character(tmpMamaID).direction = 6
	get_character(tmpMamaID).move_forward
	wait(60)
	}
	get_character(tmpMamaID).direction = 2
	get_character(tmpMamaID).move_forward
	wait(60)
	get_character(tmpMamaID).direction = 6
	get_character(tmpMamaID).move_forward
	wait(60)
	get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_atk_mh
	get_character(tmpFaID).moveto(tmpMtX,tmpMtY)
	wait(30)
	get_character(tmpMamaID).npc_story_mode(false)
	call_msg("TagMapDoomFarmA:Dinner/begin_3_opt_Eat0")
	chcg_background_color(0,0,0,0,7)
		SndLib.sound_eat(90)
		wait(50+rand(20))
		SndLib.sound_eat(85)
		wait(50+rand(20))
		get_character(tmpFaID).erase
	chcg_background_color(0,0,0,255,-7)
	
	if $game_player.actor.empregnanted?
		$game_player.actor.itemUseBatch("ItemAbortion")
		$game_player.actor.itemUseBatch("ItemHiPotionLV5")
		$game_player.actor.itemUseBatch("ItemBluePotion")
		$game_player.actor.baby_health = 0
		$game_player.actor.refresh
		$game_player.actor.update_lonaStat
	end
	call_msg("TagMapDoomFarmA:Dinner/begin_3_opt_Eat1")
	check_half_over_event
	$game_player.actor.sta = -100
	player_force_update
	call_msg("TagMapDoomFarmA:Dinner/begin_3_opt_Eat2")
end


portrait_hide
cam_center(0)