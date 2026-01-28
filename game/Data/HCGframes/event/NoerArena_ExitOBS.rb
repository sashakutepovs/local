#@summon_data={
#:BoughtBet=>false,
#:HowMuch=>0,
#:PlayedOP=>false,
#:PlayedPrevX=>0,
#:PlayedPrevY=>0
#}

tmpBiosID = $game_map.get_storypoint("DualBios")[2]
tmpG1X,tmpG1Y,tmpG1ID=$game_map.get_storypoint("Gate1")
tmpG2X,tmpG2Y,tmpG2ID=$game_map.get_storypoint("Gate2")
tmpTsX,tmpTsY,tmpTsID=$game_map.get_storypoint("TicketSeller")
#tmpBoughtBet = get_character(tmpBiosID).summon_data[:BoughtBet]
tmpHowMuch = get_character(tmpBiosID).summon_data[:HowMuch]
tmpPlayedOP = get_character(tmpBiosID).summon_data[:PlayedOP]
tmpMultiple = get_character(tmpBiosID).summon_data[:Multiple]
tmpBetTarget = get_character(tmpBiosID).summon_data[:BetTarget]
tmpMatchEnd = get_character(tmpBiosID).summon_data[:MatchEnd]

$bg.erase
$cg.erase
$game_player.direction = 2
@cover_chcg.dispose if @cover_chcg
SndLib.sys_StepChangeMap
portrait_hide
@hint_sprite.dispose if @hint_sprite
chcg_background_color(0,0,0,0,7)
	portrait_off
	tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("CannonCur")
	tmpGOtoX = get_character(tmpBiosID).summon_data[:PlayedPrevX]
	tmpGOtoY = get_character(tmpBiosID).summon_data[:PlayedPrevY]
	$hudForceHide = false
	$balloonForceHide = false
	$game_player.force_update = true
	$game_system.menu_disabled = false
	$game_player.moveto(tmpGOtoX,tmpGOtoY)
	get_character(tmpCurID).move_type=0
	get_character(tmpCurID).set_manual_move_type(0)
	$game_player.direction = 2
	get_character(0).switch2_id = 0
	cam_center(0)
	if tmpPlayedOP == true && tmpHowMuch >= 1 && tmpMatchEnd == false
		get_character(tmpG1ID).call_balloon(28,-1)
		get_character(tmpG2ID).call_balloon(28,-1)
		
	elsif tmpPlayedOP == true && tmpHowMuch >= 1 && tmpMatchEnd == true
		get_character(tmpG1ID).call_balloon(0)
		get_character(tmpG2ID).call_balloon(0)
		get_character(tmpTsID).call_balloon(28,-1)
	end
	
	SndLib.bgs_stop
	SndLib.bgs_play("AMBIENCE_Public_Hall_Chatter_01_loop_stereo",50,100,RPG::BGS.last.pos)
	SndLib.bgm_play("/D/Arena-Western INSIDE LOOP",65,105,RPG::BGM.last.pos)
chcg_background_color(0,0,0,255,-7)
set_this_event_force_page(2)