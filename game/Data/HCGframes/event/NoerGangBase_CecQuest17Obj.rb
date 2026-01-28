get_character(0).call_balloon(0)


tmpGangX,tmpGangY,tmpGangID=$game_map.get_storypoint("GangBoss")
tmpMaaniX,tmpMaaniY,tmpMaaniID=$game_map.get_storypoint("Maani")
tmpStartPointX,tmpStartPointY,tmpStartPointID=$game_map.get_storypoint("StartPoint")
tmpMaaniGuardID=$game_map.get_storypoint("MaaniGuard")[2]
tmpGangEliteID=$game_map.get_storypoint("GangElite")[2]

call_msg("CompCecily:QuProg/17to18_1") ; portrait_hide
$game_player.call_balloon(8)
wait(60)
call_msg("CompCecily:QuProg/17to18_2") ; portrait_hide
set_this_event_force_page(1)
$game_player.animation = $game_player.animation_mc_pick_up
SndLib.sound_equip_armor(100)
optain_item("ItemQuestCecilyProg17") #102
wait(60)


################################################################## Spot player if gang boss and manni still alive. if not? steal success.
if $story_stats["UniqueCharUniqueMaani"] != -1 && $story_stats["UniqueCharUniqueGangBoss"] != -1 && $story_stats["UniqueCharUniqueMilo"] != -1
	get_character(tmpMaaniID).npc_story_mode(true)
	get_character(tmpMaaniID).call_balloon(20)
	wait(30)
	wait(30)
	$game_player.direction = 6
	wait(60)
	$game_player.call_balloon(8)
	call_msg("CompCecily:QuProg/17to19_1")
	call_msg("CompCecily:QuProg/17to19_2") ; portrait_hide
	get_character(tmpMaaniID).direction = 4
	get_character(tmpMaaniGuardID).direction = 2
	get_character(tmpMaaniID).move_forward_force
	get_character(tmpMaaniID).call_balloon(2)
	wait(60)
	get_character(tmpMaaniGuardID).direction = 4
	call_msg("CompCecily:QuProg/17to19_3") ; portrait_hide
	cam_follow(tmpMaaniID,0)
	get_character(tmpMaaniID).call_balloon(8)
	wait(60)
	SndLib.sound_Reload
	get_character(tmpMaaniID).animation = get_character(tmpMaaniID).animation_hold_casting_mh
	wait(60)
	SndLib.sound_GunSingle
	get_character(tmpMaaniID).animation = get_character(tmpMaaniID).animation_casting_musket
	SndLib.sound_combat_sword_hit_sword(100,180)
	wait(5)
	$game_player.animation = $game_player.animation_stun
	$game_player.jump_to($game_player.x-1,$game_player.y)
	wait(5)
	call_msg("CompCecily:QuProg/17to19_4") ; portrait_hide
	get_character(tmpMaaniID).call_balloon(8)
	wait(60)
	call_msg("CompCecily:QuProg/17to19_5"); portrait_hide
	get_character(tmpGangEliteID).direction = 2
	$game_player.animation = nil
	$game_player.direction = 6
	call_msg("CompCecily:QuProg/17to19_6") ; portrait_hide
	get_character(tmpGangEliteID).direction = 4
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:StoryAggroEV]
		event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
	end
	get_character(tmpMaaniID).npc_story_mode(false)
	$story_stats["QuProgSaveCecily"] = 19
else
	$story_stats["QuProgSaveCecily"] = 18
end
call_msg("CompCecily:QuProg/17to18_END")
get_character(tmpStartPointID).call_balloon(28,-1)
eventPlayEnd