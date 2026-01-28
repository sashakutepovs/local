#$game_map.interpreter.screen.start_shake(1,7,20)
SndLib.sound_FlameCast(60,180)
SndLib.sound_equip_armor(80,70)
$game_player.animation = $game_player.animation_atk_sh
$game_player.actor.sta -= 1

tmpEV = get_character(0)
tmpGP = $game_player
return if tmpEV.moving?
case tmpGP.direction
	when 8 ;tarX = tmpEV.x   ; tarY = tmpEV.y-1
	when 2 ;tarX = tmpEV.x   ; tarY = tmpEV.y+1
	when 4 ;tarX = tmpEV.x-1 ; tarY = tmpEV.y
	when 6 ;tarX = tmpEV.x+1 ; tarY = tmpEV.y
end
return if !tmpGP.passable?(tmpEV.x,tmpEV.y,tmpGP.direction) || ![3,4].include?($game_map.region_id(tarX,tarY))
tmpEV.jump_to(tarX,tarY,5)

tmpTB1ID=$game_map.get_storypoint("TopB1")[2]
tmpTB2ID=$game_map.get_storypoint("TopB2")[2]
tmpTB3ID=$game_map.get_storypoint("TopB3")[2]
tmpTB4ID=$game_map.get_storypoint("TopB4")[2]
tmpTG1X,tmpTG1Y,=$game_map.get_storypoint("TopG1")
tmpTG2X,tmpTG2Y,=$game_map.get_storypoint("TopG2")
tmpTG3X,tmpTG3Y,=$game_map.get_storypoint("TopG3")
tmpTG4X,tmpTG4Y,=$game_map.get_storypoint("TopG4")
tmpTmainID=$game_map.get_storypoint("TopMAIN")[2]
tmpBmainID=$game_map.get_storypoint("BotMAIN")[2]

tmpTB1X = get_character(tmpTB1ID).x
tmpTB2X = get_character(tmpTB2ID).x
tmpTB3X = get_character(tmpTB3ID).x
tmpTB4X = get_character(tmpTB4ID).x

tmpTB1Y = get_character(tmpTB1ID).y
tmpTB2Y = get_character(tmpTB2ID).y
tmpTB3Y = get_character(tmpTB3ID).y
tmpTB4Y = get_character(tmpTB4ID).y

tmpResult1 = tmpTB1X == tmpTG1X && tmpTB1Y == tmpTG1Y
tmpResult2 = tmpTB2X == tmpTG2X && tmpTB2Y == tmpTG2Y
tmpResult3 = tmpTB3X == tmpTG3X && tmpTB3Y == tmpTG3Y
tmpResult4 = tmpTB4X == tmpTG4X && tmpTB4Y == tmpTG4Y
p "========="
p tmpResult1
p tmpResult2
p tmpResult3
p tmpResult4
if tmpResult1 && tmpResult2 && tmpResult3 && tmpResult4
	get_character(tmpTmainID).forced_z = -10
	$game_map.interpreter.screen.start_shake(5,10,60)
	set_event_force_page(tmpTmainID,2)
	set_event_force_page(tmpBmainID,1)
	botEv = get_character(tmpBmainID)
	topEv = get_character(tmpTmainID)
	$game_map.events.each{|id,ev|
		next unless ev.x == topEv.x && ev.y == topEv.y
		next unless ev.id != topEv.id
		#ev.moveto(botEv.x,botEv.y)
		ev.item_jump_to
	}
	get_character(tmpTB1ID).trigger = -1
	get_character(tmpTB2ID).trigger = -1
	get_character(tmpTB3ID).trigger = -1
	get_character(tmpTB4ID).trigger = -1
end
