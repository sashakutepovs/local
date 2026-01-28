tmpQ1 = $story_stats["UniqueCharSMCloudVillage_BossAtk"] == -1
tmpQ2 = $story_stats["UniqueCharSMCloudVillage_Boss"] == -1
return get_character(0).set_region_trigger(65535) if tmpQ1 && tmpQ2
tmpDualBiosID=$game_map.get_storypoint("DualBios")[2]
tmpRG3ID=$game_map.get_storypoint("RG3")[2]
tmpBossID=$game_map.get_storypoint("Boss")[2]
if get_character(tmpDualBiosID).summon_data[:RG2aggro]
	tmpAggroID=$game_map.get_storypoint("aggro")[2]
	get_character(tmpAggroID).start
	$game_player.call_balloon(19)
##########################################################################################################完成任務 玩家想要離開時
elsif $story_stats["SMCloudVillage_KillTheKid"] == 2 && $story_stats["UniqueCharSMCloudVillage_Boss"] != -1
	get_character(tmpBossID).turn_toward_character($game_player)
	$game_player.turn_toward_character(get_character(tmpBossID))
	call_msg("TagMapSMCloudVillage:Boss/CatcheLona")
	tmpAggroID=$game_map.get_storypoint("aggro")[2]
	get_character(tmpAggroID).start
	$game_player.call_balloon(19)
	get_character(0).erase
	eventPlayEnd
	
elsif get_character(tmpDualBiosID).summon_data[:TalkedGuard] && $story_stats["SMCloudVillage_Aggroed"] == 0 && [1,2].include?($story_stats["SMCloudVillage_KillTheKid"])
	#do nothing
	return get_character(0).set_region_trigger(65535)
else
	tmpGateGuardX,tmpGateGuardY,tmpGateGuardID = $game_map.get_storypoint("GateGuard")
	if get_character(tmpGateGuardID).npc? && [:none,nil].include?(get_character(tmpGateGuardID).npc.action_state)
		portrait_hide
		
		get_character(tmpGateGuardID).npc_story_mode(true)
		get_character(tmpGateGuardID).jump_to(tmpGateGuardX-1,tmpGateGuardY)
		$game_player.jump_to(tmpGateGuardX,tmpGateGuardY)
		get_character(tmpGateGuardID).direction = 6
		SndLib.sound_equip_armor(100,150)
		wait(9)
		$game_player.direction = 4
		wait(9)
		get_character(tmpGateGuardID).npc_story_mode(false)
		$game_player.call_balloon(1)
		wait(60)
		call_msg("TagMapSMCloudVillage:BradgeGuard/Begin2")
		$game_player.direction = 6
		get_character($game_player.get_followerID(0)).moveto($game_player.x,$game_player.y) if $game_player.record_companion_name_back
		get_character($game_player.get_followerID(1)).moveto($game_player.x,$game_player.y) if $game_player.record_companion_name_front
		get_character($game_player.get_followerID(-1)).moveto($game_player.x,$game_player.y) if $game_player.record_companion_name_ext
		get_character(tmpRG3ID).set_region_trigger(3)
	end
end
eventPlayEnd
get_character(0).set_region_trigger(65535)