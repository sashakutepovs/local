tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
tmpStartPointX,tmpStartPointY,tmpStartPointID = $game_map.get_storypoint("StartPoint")
portrait_hide
chcg_background_color(0,0,0,255)
	eventPlayStart
	portrait_off
	get_character(0).npc_story_mode(true)
	get_character(0).moveto(tmpWakeUpX,tmpWakeUpY+3)
	$game_player.moveto(tmpWakeUpX,tmpWakeUpY+4)
	$game_player.animation = nil
	$game_player.direction = 8
	$game_player.actor.take_skill_cancel($data_arpgskills["BasicNormal"])
	$game_player.actor.cancel_holding
chcg_background_color(0,0,0,255,-3)
call_msg("CompCocona:T1_end/0")
portrait_off
$game_player.call_balloon(8)
wait(60)
2.times{
	$game_player.animation = $game_player.animation_atk_mh
	wait(8)
	get_character(0).jump_to(get_character(0).x,get_character(0).y,10)
	SndLib.sound_punch_hit(100)
	wait(30)
	$game_player.animation = $game_player.animation_atk_sh
	wait(8)
	get_character(0).jump_to(get_character(0).x,get_character(0).y,10)
	SndLib.sound_punch_hit(100)
	wait(45)
}

call_msg("CompCocona:T1_end/1")
portrait_hide
cam_center(0)
$game_player.jump_to($game_player.x,$game_player.y+1)
$game_player.direction = 8
EvLib.sum("EffectOverKill",get_character(0).x+1,get_character(0).y)
wait(1+rand(5))
EvLib.sum("EffectOverKill",get_character(0).x,get_character(0).y+1)
wait(1+rand(5))
EvLib.sum("EffectOverKill",get_character(0).x,get_character(0).y)
wait(1+rand(5))
EvLib.sum("EffectOverKill",get_character(0).x,get_character(0).y-1)
wait(1+rand(5))
EvLib.sum("EffectOverKill",get_character(0).x-1,get_character(0).y)
wait(1+rand(5))
EvLib.sum("UniqueBossMamaT2",get_character(0).x,get_character(0).y,{:StoryMode=>true})
get_character(0).opacity = 0
get_character(0).npc_story_mode(false)
wait(60)
get_character(0).delete