if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
if !get_character(tmpDualBiosID).summon_data[:DidBack]
	if $game_player.actor.weak <= 25 || $game_player.actor.stat["SlaveBrand"] == 1
		get_character(tmpDualBiosID).summon_data[:Aggro] = false
		get_character(tmpDualBiosID).summon_data[:ShouldDoBack] = true
		call_msg("TagMapAriseVillage:GateKeeper/NormalBegin0") ;portrait_hide
	else ################ too weak
		call_msg("TagMapAriseVillage:GateKeeper/TooWeakBegin0")
		
	end
else #
	call_msg("TagMapAriseVillage:GateKeeper/Enter0")
	get_character(tmpDualBiosID).summon_data[:ShouldDoBack] = true
end


##################需要後退  那就讓路吧
if get_character(tmpDualBiosID).summon_data[:ShouldDoBack] && !get_character(tmpDualBiosID).summon_data[:DidBack]
	get_character(tmpDualBiosID).summon_data[:DidBack] = true
	get_character(0).npc_story_mode(true)
	get_character(0).direction = 8 ; get_character(0).move_forward_force ; wait(40)
	get_character(0).direction = 6 ; get_character(0).move_forward_force ; wait(40)
	get_character(0).direction = 4
	get_character(0).npc_story_mode(false)
end
eventPlayEnd