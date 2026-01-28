 if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpMobAlive = $game_map.npcs.any?{
|event| 
	next unless event.summon_data
	next unless event.summon_data[:Zombie]
	next if event.deleted?
	next if event.npc.action_state == :death
	true
}
tmpCannonX,tmpCannonY,tmpCannonID=$game_map.get_storypoint("Cannon")
tmpOfficerX,tmpOfficerY,tmpOfficerID=$game_map.get_storypoint("officer")
tmpRefugeeX,tmpRefugeeY,tmpRefugeeID=$game_map.get_storypoint("Refugee")
tmpGuardX,tmpGuardY,tmpGuardID=$game_map.get_storypoint("Guard")
tmpFirstBreedLingX,tmpFirstBreedLingY,tmpFirstBreedLingID=$game_map.get_storypoint("FirstBreedLing")
tmpCannonCurX,tmpCannonCurY,tmpCannonCurID=$game_map.get_storypoint("CannonCur")
tmpKillCountX,tmpKillCountY,tmpKillCountID=$game_map.get_storypoint("KillCount")
tmpStartPointX,tmpStartPointY,tmpStartPointID=$game_map.get_storypoint("StartPoint")
tmpPreCountX,tmpPreCountY,tmpPreCountID=$game_map.get_storypoint("PreCount")
	########################################################################### 火炮測試
if $story_stats["RecQuestLisa"] == 8 && $game_player.record_companion_name_ext == "CompExtUniqueLisa"
	$story_stats["RecQuestLisa"] = 9
	call_msg("CompLisa:Lisa9/Begin0")
	$game_map.npcs.each do |event| 
		next if event.summon_data == nil
		next if event.summon_data[:Zombie] == nil
		posi = Array.new
		posi += $game_map.region_map[18]
		posi = posi.sample
		event.moveto(posi[0],posi[1])
	end
	set_event_force_page(tmpPreCountID,1)
	get_character(tmpCannonID).call_balloon(19,-1)
elsif $story_stats["RecQuestLisa"] == 9 && $game_player.record_companion_name_ext == "CompExtUniqueLisa" && tmpMobAlive
	call_msg("CompLisa:Lisa9/NotYet")
	get_character(tmpCannonID).call_balloon(19,-1)
	
	########################################################################### 正規入侵開始
elsif $story_stats["RecQuestLisa"] == 9 && $game_player.record_companion_name_ext == "CompExtUniqueLisa" && !tmpMobAlive
	$story_stats["RecQuestLisa"] = 10
	call_msg("CompLisa:Lisa10/Begin0") ; portrait_hide
	get_character(tmpFirstBreedLingID).set_summon_data({:tarFish=>true})
	get_character(tmpFirstBreedLingID).npc_story_mode(true)
	get_character(tmpFirstBreedLingID).moveto(tmpCannonCurX,tmpCannonCurY-6)
	get_character(tmpRefugeeID).moveto(tmpCannonCurX,tmpCannonCurY)
	get_character(tmpRefugeeID).npc_story_mode(true)
	get_character(tmpGuardID).npc_story_mode(true)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(-1)).moveto(tmpCannonX-1,tmpCannonY+1)
		get_character(0).moveto(tmpCannonX-2,tmpCannonY+1)
		get_character(0).direction = 6
		get_character(tmpGuardID).moveto(tmpCannonX-3,tmpCannonY+1)
		get_character($game_player.get_followerID(-1)).direction = 4
		$game_player.moveto(tmpCannonX,tmpCannonY+1)
		$game_player.direction = 4
		get_character(tmpGuardID).moveto(tmpCannonX-3,tmpCannonY+1)
		get_character(tmpGuardID).direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompLisa:Lisa10/Begin1") ; portrait_hide
	get_character(tmpGuardID).call_balloon(8)
	wait(60)
	get_character(tmpGuardID).call_balloon(1)
	wait(60)
	call_msg("CompLisa:Lisa10/Begin2") ; portrait_hide
	get_character($game_player.get_followerID(-1)).direction = 4
	$game_player.direction = 4
	get_character(0).direction = 4
	get_character($game_player.get_followerID(-1)).call_balloon(1)
	$game_player.call_balloon(2)
	get_character(0).call_balloon(1)
	call_msg("CompLisa:Lisa10/Begin3") ; portrait_hide
	get_character($game_player.get_followerID(-1)).direction = 8
	$game_player.direction = 8
	get_character(0).direction = 8
	#SndLib.BreedlingSpot(60)
	cam_follow(tmpRefugeeID,0)
	call_msg("CompLisa:Lisa10/Begin4") ; portrait_hide
		get_character(tmpRefugeeID).direction = 2 ; get_character(tmpRefugeeID).move_forward_force ; wait(10)
		get_character(tmpFirstBreedLingID).direction = 2 ; get_character(tmpFirstBreedLingID).move_forward_force ; wait(10)
		get_character(tmpFirstBreedLingID).direction = 2 ; get_character(tmpFirstBreedLingID).move_forward_force ; wait(10)
		get_character(tmpRefugeeID).direction = 2 ; get_character(tmpRefugeeID).move_forward_force ; wait(10)
		get_character(tmpFirstBreedLingID).direction = 2 ; get_character(tmpFirstBreedLingID).move_forward_force ; wait(10)
		get_character(tmpFirstBreedLingID).direction = 2 ; get_character(tmpFirstBreedLingID).move_forward_force ; wait(10)
	call_msg("CompLisa:Lisa10/Begin5") ; portrait_hide
	3.times{
		get_character(tmpRefugeeID).direction = 2 ; get_character(tmpRefugeeID).move_forward_force ; wait(10)
		get_character(tmpFirstBreedLingID).direction = 2 ; get_character(tmpFirstBreedLingID).move_forward_force ; wait(10)
		get_character(tmpFirstBreedLingID).direction = 2 ; get_character(tmpFirstBreedLingID).move_forward_force ; wait(10)
	}
	get_character(tmpRefugeeID).direction = 8
	call_msg("CompLisa:Lisa10/Begin6") ; portrait_hide
	SndLib.BreedlingAtk
	get_character(tmpFirstBreedLingID).animation = get_character(tmpFirstBreedLingID).animation_atk_mh
	wait(8)
	SndLib.sound_punch_hit
	get_character(tmpRefugeeID).animation = get_character(tmpRefugeeID).overkill_animation
	wait(5)
	SndLib.sound_MaleWarriorDed
	wait(120)
	
	cam_center(0)
	call_msg("CompLisa:Lisa10/Begin7") ; portrait_hide
	SndLib.bgm_play("D/Heavy Riff 2 (looped)",80,80)
		$game_player.direction = 4
		get_character($game_player.get_followerID(-1)).direction = 6
		get_character(0).direction = 6
	call_msg("CompLisa:Lisa10/Begin8") ; portrait_hide
		get_character($game_player.get_followerID(-1)).direction = 4
		get_character(tmpGuardID).direction = 6
		$game_player.direction = 4
		get_character(0).direction = 4
	call_msg("CompLisa:Lisa10/Begin9") ; portrait_hide
		get_character($game_player.get_followerID(-1)).direction = 6
		$game_player.direction = 4
	call_msg("CompLisa:Lisa10/Begin10") ; portrait_hide
		get_character(0).direction = 8
	get_character(tmpFirstBreedLingID).moveto(tmpFirstBreedLingX,tmpFirstBreedLingY)
	get_character(tmpRefugeeID).moveto(tmpFirstBreedLingX,tmpFirstBreedLingY)
	get_character(tmpRefugeeID).animation = nil
	get_character(tmpFirstBreedLingID).npc_story_mode(false)
	get_character(tmpRefugeeID).npc_story_mode(false)
	get_character(tmpCannonID).call_balloon(19,-1)
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character($game_player.get_followerID(-1)).set_this_companion_disband
		get_character(tmpGuardID).npc_story_mode(false)
		get_character(tmpGuardID).moveto(tmpGuardX,tmpGuardY)
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompLisa:Lisa10/Begin10_board")
	set_event_force_page(tmpKillCountID,4)
elsif $story_stats["RecQuestLisa"] == 10
	call_msg("CompLisa:Lisa10/NotYet")

	########################################################################### 成功防禦
elsif $story_stats["RecQuestLisa"] == 11 && $story_stats["UniqueCharUniqueLisa"] != -1
	$story_stats["RecQuestLisa"] = 12
	$story_stats["RecQuestSouthFLMain"] = 13
	$story_stats["RecQuestLisaAmt"] = 6 + $game_date.dateAmt
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(0).moveto(tmpOfficerX,tmpOfficerY)
		get_character(0).direction = 4
		$game_player.moveto(tmpOfficerX-1,tmpOfficerY)
		$game_player.direction = 6
	chcg_background_color(0,0,0,255,-7)
	if $story_stats["RecQuestLisaSaintCall"] == 0
		call_msg("CompLisa:Lisa12/begin0_Win")
	else
		call_msg("CompLisa:Lisa12/begin0_Lose")
	end
	portrait_hide
	get_character(tmpGuardID).moveto(tmpStartPointX+2,tmpStartPointY+4)
	get_character(tmpGuardID).npc_story_mode(true)
	4.times{
		get_character(tmpGuardID).direction = 8 ; get_character(tmpGuardID).move_forward_force
		wait(30)
	}
	get_character(tmpGuardID).direction = 6 ; get_character(tmpGuardID).move_forward_force ; wait(30)
	get_character(tmpGuardID).direction = 8 ; get_character(tmpGuardID).move_forward_force ; wait(30)
	get_character(0).direction = 2
	$game_player.direction = 2
	call_msg("CompLisa:Lisa12/begin1")
	if $story_stats["RecQuestLisaSaintCall"] == 0
		call_msg("CompLisa:Lisa12/begin2_Win")
		optain_item($data_items[125],2) #ItemSouthFL_INN_Key
		wait(30)
		optain_item($data_items[51],4) #BigCopper
	else
		call_msg("CompLisa:Lisa12/begin2_Lose")
	end
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpGuardID).npc_story_mode(false)
		get_character(tmpGuardID).delete
		get_character(0).direction = 8
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompLisa:Lisa12/begin3_Board")
	optain_exp(10000)
	wait(30)
	optain_morality(1)
	wait(30)
	call_msg("CompLisa:Lisa12/begin4")
	########################################################################### 其他
else
	
	if $story_stats["RecQuestLisaSaintCall"] == 0
		call_msg("TagMapSouthFL_Warfare:Officer/Common_basic")
	else
		call_msg("TagMapSouthFL_Warfare:Officer/Common_Saint")
	end
end
eventPlayEnd
get_character(0).call_balloon(0)
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestLisa"] == 8 || ($story_stats["RecQuestLisa"] == 9 && tmpMobAlive)
#Lisa SouthFL Quest
tmpQ2 = $story_stats["RecQuestLisa"] == 11
tmpQ1 = $story_stats["UniqueCharUniqueLisa"] != -1
return get_character(0).call_balloon(28,-1) if tmpQ2 && tmpQ1