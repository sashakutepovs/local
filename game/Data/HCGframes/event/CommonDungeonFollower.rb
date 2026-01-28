
return if !get_character(0).npc?
tmpEV = get_character(0)

if tmpEV.move_type != 3
	tmpEV.animation = nil
	tmpEV.move_type = 3
	tmpEV.set_manual_move_type(3)
	tmpEV.npc.master = $game_player
	tmpEV.set_this_event_follower(0)
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