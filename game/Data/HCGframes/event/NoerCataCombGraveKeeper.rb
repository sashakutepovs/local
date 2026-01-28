if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

#不死族務農任務
if $story_stats["QuProgCataUndeadHunt"] == 2
	call_msg("TagMapNoerCatacomb:Necropolis/CataUndeadHunt_done2")
	$story_stats["QuProgCataUndeadHunt"] =3
	get_character(0).call_balloon(0)
	eventPlayEnd
	
#調查地下墓穴
elsif $story_stats["QuProgCataUndeadHunt2"] == 1
	$story_stats["QuProgCataUndeadHunt2"] = 2
	get_character(0).call_balloon(0)
	get_character(0).npc_story_mode(true)
	call_msg("TagMapNoerCatacomb:Keeper/UndeadHunt2_1")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		tmpX,tmpY,tmpID=$game_map.get_storypoint("Qprog2PT")
		$game_player.moveto(tmpX,tmpY)
		get_character(0).moveto(tmpX,tmpY-1)
		$game_player.direction = 8
		get_character(0).direction = 8
	chcg_background_color(0,0,0,255,-7)
	
	call_msg("TagMapNoerCatacomb:Keeper/UndeadHunt2_2") ; portrait_hide
	3.times{
		$game_player.move_normal
		$game_player.move_speed= 3
		$game_player.move_forward_force
		get_character(0).move_speed= 3
		get_character(0).move_forward_force
		wait(35)
	}
	$game_player.move_forward_force
	get_character(0).direction = 4
	get_character(0).move_speed= 3
	get_character(0).move_forward_force
	wait(35)
	get_character(0).direction = 6
	call_msg("TagMapNoerCatacomb:Keeper/UndeadHunt2_3")
	$game_player.direction = 4
	call_msg("TagMapNoerCatacomb:Keeper/UndeadHunt2_4")
	
	get_character(0).npc_story_mode(false)
	get_character($game_map.get_storypoint("b1enter")[2]).call_balloon(28,-1) #gate set balloon
	$game_player.direction = 8
	eventPlayEnd
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapNoerCatacomb:Keeper/talk#{rand(3)}",get_character(0).id)
end
