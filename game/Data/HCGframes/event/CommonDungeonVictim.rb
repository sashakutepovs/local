tmpEV = get_character(0)
if get_character(0).npc?
	if $story_stats["Captured"] == 1
		SndLib.sound_QuickDialog
		return $game_map.popup(tmpEV.id,"QuickMsg:NPC/F_OrkindMeatToilet#{rand(12)}",0,0)
	elsif tmpEV.follower[0] == 0
		tmpEV.animation = nil
		tmpEV.npc.master = $game_player
		tmpEV.move_type = 3
		tmpEV.set_manual_move_type(3)
		tmpEV.set_this_event_follower(0)
		tmpEV.npc.no_aggro= true
		tmpEV.through = false
	end
	if tmpEV.follower[1] == 0
		tmpEV.follower[1] = 1
	elsif tmpEV.follower[1] == 1
		tmpEV.follower[1] = 0
	end
	tmpEV.process_npc_DestroyForceRoute
	tmpMsg = tmpEV.follower[1] == 0 ? "NPC/CommandWait" : "NPC/CommandFollow"
	SndLib.sound_QuickDialog
	$game_map.popup(get_character(0).id,"QuickMsg:#{tmpMsg}#{rand(2)}",0,0)
else
	if $game_player.actor.stat["Cannibal"] >=1
		popup(0,:item,45,+5)    # -10 Potions (with icon) above event 4
		SndLib.sys_MeatGain
		get_character(-1).animation = get_character(-1).animation_mc_pick_up
		$game_party.gain_item($data_items[45], 5)
		get_character(0).delete
	else
		get_character(0).trigger = -1
	end
end