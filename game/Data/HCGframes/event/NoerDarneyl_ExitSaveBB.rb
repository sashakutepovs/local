
tmpDuabBiosID=$game_map.get_storypoint("DualBios")[2]
tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("CannonCur")
tmpGameCoreID=$game_map.get_storypoint("GameCore")[2]


 $bg.erase
 $cg.erase
@cover_chcg.dispose if @cover_chcg
@hint_sprite.dispose if @hint_sprite

################# check win or lost
######################LOSE
if get_character(0).summon_data[:hp] <= 0
	msgbox "do lost"
	###################### win
else
	msgbox "do win"
end
$story_stats["RecQuestDarneyl_BabyAMT"] = $game_date.dateAmt
chcg_background_color(0,0,0,0,7)
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next unless event[1].summon_data[:BB]
		event[1].delete
	}
	$game_player.moveto(get_character(tmpDuabBiosID).summon_data[:CBToX],get_character(tmpDuabBiosID).summon_data[:CBToY])
	get_character(tmpCurID).call_balloon(0)
	get_character(tmpCurID).set_manual_move_type(0)
	get_character(tmpCurID).move_type = 0
	#get_character(tmpCurID).force_update = false
	$hudForceHide = false
	$balloonForceHide = false
	$game_player.force_update = true
	$game_system.menu_disabled = false
	$game_player.transparent = false
	$game_player.light_check
	#get_character(tmpCBTvictimID).move_type = 0
	#set_event_force_page(tmpCBTvictimID,get_character(tmpCurVictimID).summon_data[:hp]+1)
	#set_event_force_page(tmpCBTvictimGrapID,get_character(tmpCurVictimID).summon_data[:hp]+1)
	#tmpPattern = get_character(tmpCBTvictimID).x - tmpCBTvictimX
	#get_character(tmpCBTvictimGrapID).pattern = tmpPattern
	#et_character(0).switch2_id = 0
	cam_center(0)
	
	#if get_character(tmpCurVictimID).summon_data[:hp] >0
	set_this_event_force_page(2)
	#else
	#	set_this_event_force_page(1)
	#end
chcg_background_color(0,0,0,255,-7)
SndLib.bgm_play_prev




eventPlayEnd