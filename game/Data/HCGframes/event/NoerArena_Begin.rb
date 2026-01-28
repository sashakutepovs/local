if $story_stats["RapeLoop"] == 1
	tmpBiosID = $game_map.get_storypoint("DualBios")[2]
	get_character(tmpBiosID).summon_data[:PlayedOP] = false
	get_character(tmpBiosID).summon_data[:PlayerMatch] = true
	get_character(tmpBiosID).summon_data[:MatchEnd] = true
	get_character(tmpBiosID).summon_data[:PlayerScore] = 0
	get_character(tmpBiosID).summon_data[:HowMuch] = 100
	load_script("Data/HCGframes/event/NoerArena_EnterArena.rb")
	
elsif $story_stats["RecQuestNoerArena"] == 0
	return if [25,26].include?($story_stats["RecQuestCocona"])
	portrait_hide
	$story_stats["RecQuestNoerArena"] = 1
	tmpBiosID = $game_map.get_storypoint("DualBios")[2]
	get_character(tmpBiosID).summon_data[:HowMuch] = 2000
	get_character(tmpBiosID).summon_data[:Multiple] = 3
	get_character(tmpBiosID).summon_data[:LosMultiple] = 1
	get_character(tmpBiosID).summon_data[:BoughtBet] = true
	get_character(tmpBiosID).summon_data[:MatchEnd] = false
	get_character(tmpBiosID).summon_data[:PlayedOP] = false
	get_character(tmpBiosID).summon_data[:BetTarget] = "ArenaEastColossus"
	tmpStX,tmpStY,tmpStID=$game_map.get_storypoint("StartPoint")
	tmpTgX,tmpTgY,tmpTgID=$game_map.get_storypoint("TricketGiver")
	tmpTsX,tmpTsY,tmpTsID=$game_map.get_storypoint("TicketSeller")
	tmpG1X,tmpG1Y,tmpG1ID=$game_map.get_storypoint("Gate1")
	tmpG2X,tmpG2Y,tmpG2ID=$game_map.get_storypoint("Gate2")
	set_event_force_page(tmpTgID,1)
	get_character(tmpTgID).moveto(tmpStX,tmpStY-5)
	get_character(tmpTgID).npc_story_mode(true)
	$game_player.moveto(tmpStX,tmpStY)
	$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	portrait_off
	$game_player.direction = 4
	$game_player.call_balloon(8)
	wait(60)
	$game_player.direction = 6
	$game_player.call_balloon(8)
	wait(60)
	call_msg("TagMapNoerArena:firstTime/begin_1") ; portrait_hide
	4.times{
		get_character(tmpTgID).direction = 2 ; get_character(tmpTgID).move_forward_force
		wait(35)
	}
	$game_player.direction = 8
	SndLib.sound_MaleWarriorSpot
	call_msg("TagMapNoerArena:firstTime/begin_2") ; portrait_hide
	SndLib.sound_MaleWarriorAtk(70)
	get_character(tmpTgID).set_animation("animation_atk_sh")
	optain_item($data_items[123]) #BetTricket
	$game_player.jump_to(tmpStX,tmpStY)
	wait(60)
	call_msg("TagMapNoerArena:firstTime/begin_3") #yes no
	
	get_character(tmpTgID).direction = 8
	SndLib.sound_MaleWarriorSpot
	call_msg("TagMapNoerArena:firstTime/begin_4") ; portrait_hide
	cam_center(0)
	
	get_character(tmpTgID).direction = 4 ; get_character(tmpTgID).move_forward_force
	$game_player.turn_toward_character(get_character(tmpTgID))
	wait(35)
	2.times{
		get_character(tmpTgID).direction = 2 ; get_character(tmpTgID).move_forward_force
		$game_player.turn_toward_character(get_character(tmpTgID))
		wait(35)
	}
	get_character(tmpTgID).opacity = 250
	25.times{
		get_character(tmpTgID).opacity -= 10
		wait(2)
	}
	call_msg("TagMapNoerArena:firstTime/begin_5")
	chcg_background_color(0,0,0,0,7)
	get_character(tmpTgID).npc_story_mode(false)
	get_character(tmpTgID).moveto(0,0)
	get_character(tmpG1ID).call_balloon(28,-1)
	get_character(tmpG2ID).call_balloon(28,-1)
	eventPlayEnd
end
