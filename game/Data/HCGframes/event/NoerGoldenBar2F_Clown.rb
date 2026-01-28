if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpDirAniArr = [[3,4+get_character(0).direction_offset,-1,0,0]]
get_character(0).animation = get_character(0).aniCustom(tmpDirAniArr,-1)
portrait_hide
tmpMove_Type = get_character(0).move_type
get_character(0).move_type = 0
get_character(0).npc_story_mode(true)
if get_character(0).summon_data[:triggered] == 0
	chcg_background_color(0,0,0,0,7)
		$game_player.moveto(get_character(0).x,get_character(0).y+1)
		$game_player.direction = 8
	chcg_background_color(0,0,0,255,-7)
	SndLib.balloon_rub
	tmpAniArr = [[6,0,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(60)
	SndLib.balloon_rub
	tmpAniArr = [[7,0,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(60)
	SndLib.balloon_rub
	tmpAniArr = [[8,0,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(60)
	
	SndLib.balloon_zoom
	tmpAniArr = [[6,1,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(15)
	tmpAniArr = [[7,1,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(15)
	tmpAniArr = [[8,1,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(15)
	tmpAniArr = [[6,2,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(40)
	
	SndLib.balloon_rub
	get_character(0).jump_to(get_character(0).x,get_character(0).y)
	tmpAniArr = [[7,2,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(60)
	
	call_msg("confused okay....")
	10.times{
		SndLib.balloon_rub
		tmpAniArr = [[8,2,-1,0,-5]]
		get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
		wait(5)
		tmpAniArr = [[6,3,-1,0,-5]]
		get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
		wait(5)
	}
	
	get_character(0).jump_to(get_character(0).x,get_character(0).y)
	tmpAniArr = [[7,3,-1,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	wait(60)
	SndLib.BadClap(90,130)
	$game_player.animation = $game_player.animation_ClapFast
	$game_player.jump_to($game_player.x,$game_player.y)
	call_msg("done")
	$game_player.jump_to($game_player.x,$game_player.y)
	$game_player.animation = $game_player.animation_stun
	$game_player.actor.addCums("CumsHead",1000,"Human")
	EvLib.sum("EfxSpeamHit",get_character(0).x,get_character(0).y)
	EvLib.sum("EfxSpeamHit",get_character(0).x,get_character(0).y)
	lona_mood "p5shame"
	SndLib.sound_chcg_full(rand(100)+50)
	$game_portraits.rprt.shake
	$game_map.interpreter.flash_screen(Color.new(255,255,255,25),8,true)
	$game_map.reserve_summon_event("WasteSemenHuman",$game_player.x,$game_player.y)
	$game_map.reserve_summon_event("WasteSemenHuman",$game_player.x-1+rand(3),$game_player.y-1+rand(3))
	$game_map.reserve_summon_event("WasteSemenHuman",$game_player.x-1+rand(3),$game_player.y-1+rand(3))
	SndLib.sound_ShockBomb(100,200)
	get_character(0).jump_to(get_character(0).x,get_character(0).y)
	tmpAniArr = [[8,3,2,1,-5],[8,3,2,0,-5]]
	get_character(0).animation = get_character(0).aniCustom(tmpAniArr,-1)
	player_force_update
	wait(60)
	call_msg("bomb")
	get_character(0).summon_data[:triggered] = 1
else
	call_msg("angry")
	get_character(0).forced_y = 0
	tmpPlus = 1
	until get_character(0).forced_y < -200
		case tmpPlus
			when 0..10   ; get_character(0).forced_y -= 1
			when 11..30  ; get_character(0).forced_y -= 2
			when 31..200  ; get_character(0).forced_y -= 3
		end
		tmpPlus += 1
		wait(1)
	end
	call_msg("done")
	get_character(0).delete
end
$game_player.animation = nil
get_character(0).npc_story_mode(false)
get_character(0).move_type = tmpMove_Type
get_character(0).animation = get_character(0).aniCustom(get_character(0).summon_data[:aniArr],-1)

eventPlayEnd