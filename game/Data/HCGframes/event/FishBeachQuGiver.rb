if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
if $game_player.player_slave? || $game_player.actor.weak >= 50
	call_msg("TagMapFishBeach:QuGiver/Begin0_Slave")
	eventPlayEnd
	return
end
################################################################################################ 逮捕交還
if $story_stats["RecQuestFishBeach"] == 4 && $story_stats["RecQuestFishCeramic"] == 2
	tmpDetectiveX,tmpDetectiveY,tmpDetectiveID=$game_map.get_storypoint("Detective")
	tmpDeGuardX,tmpDeGuardY,tmpDeGuardID=$game_map.get_storypoint("DeGuard")
	tmpQuGiverX,tmpQuGiverY,tmpQuGiverID=$game_map.get_storypoint("QuGiver")
	tmpStX,tmpStY,tmpStD=$game_map.get_storypoint("StartPoint")
	call_msg("TagMapFishBeach:QuGiver/done0") ; portrait_hide
	chcg_background_color(0,0,0,0,7)
		$game_player.moveto(tmpQuGiverX+1,tmpQuGiverY+2)
		$game_player.direction = 4
		get_character(0).moveto(tmpQuGiverX,tmpQuGiverY+2)
		get_character(0).direction = 6
		get_character(0).npc_story_mode(true)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapFishBeach:QuGiver/done1") ; portrait_hide
	get_character(0).animation = get_character(0).animation_atk_sh
	optain_lose_item($data_items[127],$game_party.item_number($data_items[127])) #ItemQuestFbFormula
	call_msg("TagMapFishBeach:QuGiver/done2") ; portrait_hide
	call_msg("TagMapFishBeach:QuGiver/done3") ; portrait_hide
	cam_center(0)
	get_character(tmpDeGuardID).moveto(tmpStX+8,tmpStY)
	get_character(tmpDetectiveID).moveto(tmpStX+8,tmpStY+1)
	get_character(tmpDeGuardID).npc_story_mode(true)
	get_character(tmpDetectiveID).npc_story_mode(true)
	get_character(tmpQuGiverID).npc_story_mode(true)
	8.times{
	get_character(tmpDeGuardID).direction = 4  ; get_character(tmpDeGuardID).move_forward_force 
	get_character(tmpDetectiveID).direction = 4; get_character(tmpDetectiveID).move_forward_force;wait(32) ; $game_player.turn_toward_character(get_character(tmpDetectiveID))
	}
	get_character(tmpDeGuardID).direction = 8
	get_character(tmpDetectiveID).direction = 4; get_character(tmpDetectiveID).move_forward_force;wait(32) ; $game_player.turn_toward_character(get_character(tmpDetectiveID))
	get_character(tmpDetectiveID).direction = 8; get_character(tmpDetectiveID).move_forward_force;wait(32) ; $game_player.turn_toward_character(get_character(tmpDetectiveID))
	get_character(tmpDetectiveID).direction = 8; get_character(tmpDetectiveID).move_forward_force 
	get_character(tmpDeGuardID).direction = 8; get_character(tmpDeGuardID).move_forward_force;wait(32); $game_player.turn_toward_character(get_character(tmpDetectiveID))
	get_character(tmpDeGuardID).direction = 8; get_character(tmpDeGuardID).move_forward_force; $game_player.turn_toward_character(get_character(tmpDetectiveID))
	$game_player.jump_to($game_player.x+1,$game_player.y) ; $game_player.direction = 4 ; SndLib.sound_punch_hit
	lona_mood "p5sta_damage"
	$game_player.actor.portrait.shake
	wait(48)
	get_character(tmpDeGuardID).direction = 4
	 portrait_hide
	get_character(0).direction = 2
	call_msg("TagMapFishBeach:QuGiver/done4") ; portrait_hide
	cam_center(0)
	get_character(tmpDeGuardID).direction = 4; get_character(tmpDeGuardID).move_forward_force
	get_character(tmpQuGiverID).direction = 2; get_character(tmpQuGiverID).move_forward_force
	get_character(tmpDetectiveID).direction = 2; get_character(tmpDetectiveID).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(tmpDetectiveID))
	get_character(tmpDeGuardID).direction = 2; get_character(tmpDeGuardID).move_forward_force
	get_character(tmpQuGiverID).direction = 2; get_character(tmpQuGiverID).move_forward_force
	get_character(tmpDetectiveID).direction = 6; get_character(tmpDetectiveID).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(tmpDetectiveID))
	get_character(tmpDeGuardID).direction = 2; get_character(tmpDeGuardID).move_forward_force
	get_character(tmpQuGiverID).direction = 6; get_character(tmpQuGiverID).move_forward_force
	get_character(tmpDetectiveID).direction = 6; get_character(tmpDetectiveID).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(tmpDetectiveID))
	4.times{
		get_character(tmpDeGuardID).direction = 6; get_character(tmpDeGuardID).move_forward_force
		get_character(tmpQuGiverID).direction = 6; get_character(tmpQuGiverID).move_forward_force
		get_character(tmpDetectiveID).direction = 6; get_character(tmpDetectiveID).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(tmpDetectiveID))
	}
	get_character(tmpDeGuardID).direction = 6; get_character(tmpDeGuardID).move_forward_force
	get_character(tmpQuGiverID).direction = 6; get_character(tmpQuGiverID).move_forward_force
	get_character(tmpDetectiveID).direction = 6; get_character(tmpDetectiveID).move_forward_force ;$game_player.turn_toward_character(get_character(tmpDetectiveID))
	
	chcg_background_color(0,0,0,0,7)
		get_character(tmpDetectiveID).delete
		get_character(tmpDeGuardID).delete
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapFishBeach:QuGiver/done_end") ; portrait_hide
	optain_exp(8000)
	$story_stats["RecQuestFishBeach"] = 6
	
################################################################################################ 一般交還
elsif $story_stats["RecQuestFishBeach"] == 4 && $story_stats["RecQuestFishCeramic"] != 2
	tmpQuGiverX,tmpQuGiverY,tmpQuGiverID=$game_map.get_storypoint("QuGiver")
	call_msg("TagMapFishBeach:QuGiver/done0") ; portrait_hide
	chcg_background_color(0,0,0,0,7)
		$game_player.moveto(tmpQuGiverX,tmpQuGiverY+3)
		$game_player.direction = 8
		get_character(0).moveto(tmpQuGiverX,tmpQuGiverY+2)
		get_character(0).direction = 2
		get_character(0).npc_story_mode(true)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapFishBeach:QuGiver/done1") ; portrait_hide
	get_character(0).animation = get_character(0).animation_atk_sh
	optain_lose_item($data_items[127],$game_party.item_number($data_items[127])) #ItemQuestFbFormula
	call_msg("TagMapFishBeach:QuGiver/done2") ; portrait_hide
	get_character(0).direction = 2; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	$game_player.jump_to($game_player.x+1,$game_player.y) ; $game_player.direction = 4 ; SndLib.sound_punch_hit
	lona_mood "p5sta_damage"
	$game_player.actor.portrait.shake
	get_character(0).direction = 2; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	portrait_hide
	get_character(0).direction = 6; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 6; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 6; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 6; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 6; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 6; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	get_character(0).direction = 6; get_character(0).move_forward_force ; wait(32) ;$game_player.turn_toward_character(get_character(0))
	chcg_background_color(0,0,0,0,7)
		get_character(0).delete
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapFishBeach:QuGiver/done_end") ; portrait_hide
	get_character(0).delete
	optain_exp(4000)
	$story_stats["RecQuestFishBeach"] = 5
	
################################################################################################ 前置任務
else
	tmpFestival = false
	tmpFragment = false
	tmpOutControl = false
	until false
		$story_stats["RecQuestFishBeach"] >= 2 || tmpFestival ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		$story_stats["RecQuestFishBeach"] >= 2 || tmpFragment ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		$story_stats["RecQuestFishBeach"] == 2 ? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		call_msg("TagMapFishBeach:QuGiver/Begin0") #沒事,祭典,碎片<r=HiddenOPT0>],失控<r=HiddenOPT1,幫助<r=HiddenOPT2>
		case $game_temp.choice
			when 0,-1
				break
			when 1 #祭典
				tmpFestival = true
				call_msg("TagMapFishBeach:QuGiver/Festival0")
			when 2 #碎片
				tmpFragment = true
				call_msg("TagMapFishBeach:QuGiver/Fragment0")
			when 3 #失控
				tmpOutControl = true
				$story_stats["RecQuestFishBeach"] = 2 if $story_stats["RecQuestFishBeach"] == 1
				call_msg("TagMapFishBeach:QuGiver/tmpOutControl")
			when 4 #幫助
				if $story_stats["RecQuestFishBeach"] == 2
					call_msg("TagMapFishBeach:QuGiver/help0")
					call_msg("TagMapFishBeach:QuGiver/help_board")
					call_msg("common:Lona/Decide_optB") #[算了,決定]
					if $game_temp.choice == 1
						$story_stats["RecQuestFishBeach"] = 3
						call_msg("TagMapFishBeach:QuGiver/help_accept")
						break
					else
						call_msg("TagMapFishBeach:QuGiver/help_cancel")
					end
				end
		end
	end
end
$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
get_character(0).call_balloon(28,-1) if $story_stats["RecQuestFishBeach"] != 3
eventPlayEnd
