portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	$cg.erase
	#summon npcs
	if $story_stats["UniqueCharUniqueGangBoss"] == 0
		asdX,asdY,asdID=$game_map.get_storypoint("UniqueGangBoss")
	else
		asdX,asdY,asdID=$game_map.get_storypoint("FishSpearGuard")
	end
	get_character(asdID).npc_story_mode(true)
	get_character(asdID).moveto($game_player.x,$game_player.y)
	get_character(asdID).move_forward_passable_dir
	get_character(asdID).turn_toward_character($game_player)
	until !get_character(asdID).moving? && !get_character(asdID).moving?
		wait(1)
	end

	if $game_player.player_slave? && $story_stats["SlaveOwner"] != "NoerBackStreet"
		gang_attack_lona = true
	else
		gang_attack_lona = false
	end
	if $story_stats["UniqueCharUniqueGangBoss"] == 0
		call_msg("TagMapNoerBackStreet:NotCapture/begin_withGangBoss0")
	else
		call_msg("TagMapNoerBackStreet:NotCapture/begin_FishKindMode0")
	end
chcg_background_color(0,0,0,255,-7)
get_character(asdID).turn_toward_character($game_player)
get_character(asdID).call_balloon([1,5,7,15].sample)
$game_player.turn_toward_character(get_character(asdID))
if gang_attack_lona
	if $story_stats["UniqueCharUniqueGangBoss"] == 0
		call_msg("TagMapNoerBackStreet:NotCapture/begin_withGangBoss1_slaveMode")
	else
		call_msg("TagMapNoerBackStreet:NotCapture/begin_FishKindMode1_slaveMode")
	end
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] = 1
	$story_stats["RapeLoopTorture"] = 1
	$story_stats["SlaveOwner"] = "NoerBackStreet"
	tmpMCid = $game_map.get_storypoint("MapCont")[2]
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Guard]
		next if [:death].include?(event.npc.action_state)
		next if event.deleted?
		event.set_manual_move_type(:move_search_player)
		event.npc.add_fated_enemy([0])
		tmpQ1 = event.move_type == 0
		next unless [:none,nil].include?(event.npc.action_state) && tmpQ1
		event.move_type = :move_search_player
	}

	get_character(asdID).npc_story_mode(false)
	get_character(asdID).npc.add_fated_enemy([0])
	get_character(asdID).move_type = :move_search_player
	get_character(asdID).set_manual_move_type(:move_search_player)
	get_character(asdID).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
	get_character(asdID).actor.ai_state = :assaulter
	$game_player.call_balloon(19)
	$game_player.actor.add_state("MoralityUp30")
	set_event_force_page(tmpMCid,2) #load_script("Data/HCGframes/event/NoerBackStreetEscapeTrigger.rb")
	eventPlayEnd
else
	if $story_stats["UniqueCharUniqueGangBoss"] == 0
		call_msg("TagMapNoerBackStreet:NotCapture/begin_withGangBoss1")
	else
		call_msg("TagMapNoerBackStreet:NotCapture/begin_FishKindMode1")
	end
	eventPlayEnd
	portrait_hide
	chcg_background_color(0,0,0,0,7)
	portrait_off
	call_msg("common:Lona/NarrDriveAway")
	portrait_hide
	change_map_leave_tag_map
end
