if $game_map.threat
 SndLib.sys_buzzer
 $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
 return
end

get_character(0).call_balloon(0)

if $story_stats["RecQuestLeeruoiStatue"] == 0
	$story_stats["RecQuestLeeruoiStatue"] = 1
	call_msg("TagMapNoerRing:Rager/Quprog0")
	call_msg("TagMapNoerRing:lona/SorryToRager")
	call_msg("TagMapNoerRing:Rager/Quprog0_board")

elsif $story_stats["RecQuestLeeruoiStatue"] == 1
	call_msg("TagMapNoerRing:Rager/Quprog1")
	call_msg("TagMapNoerRing:lona/SorryToRager")
	call_msg("TagMapNoerRing:Rager/Quprog0_board")
	
elsif $story_stats["RecQuestLeeruoiStatue"] == 3
	$story_stats["RecQuestLeeruoiStatue"] = 4
	call_msg("TagMapNoerRing:Rager/return_quest0")
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		tmpRagerX,tmpRagerY = $game_map.get_storypoint("Rager")
		get_character(0).moveto(tmpRagerX,tmpRagerY)
		get_character(0).direction = 6
		$game_player.moveto(tmpRagerX+1,tmpRagerY)
		$game_player.direction = 4
		portrait_off
		call_msg("TagMapNoerRing:Rager/return_quest1")
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerRing:Rager/return_quest2")
	cam_center(0)
	$game_player.direction = 2
	get_character(0).npc_story_mode(true)
	get_character(0).move_type = 0
	get_character(0).direction = 2
	$game_player.direction = 2
	4.times{
		get_character(0).move_forward_force
		wait(35)
	}
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).npc_story_mode(false)
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapNoerRing:Rager/return_quest3")
	optain_morality(5)
	wait(30)
	optain_exp(7000)
else
	call_msg("wut bugged")
end
eventPlayEnd