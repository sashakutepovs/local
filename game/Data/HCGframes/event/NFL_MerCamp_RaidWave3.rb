if $story_stats["UniqueChar_NFL_MerCamp_Leader"] != -1
 tmpID = $game_map.get_storypoint("Leader")[2]
 vol = get_character(tmpID).report_distance_to_vol_close
 SndLib.sound_QuickDialog(vol)
 $game_map.popup(tmpID,"TagMapNFL_MerCamp:Invade/3_wave3",0,0)
end

#SndLib.sound_OrcSpot
#$game_portraits.setLprt("OrcSlaveMaster_mask")
#$game_portraits.lprt.shake
portrait_hide

tmpInvadePTTX,tmpInvadePTTY=$game_map.get_storypoint("InvadePTT")
tmpInvadePTDX,tmpInvadePTDY=$game_map.get_storypoint("InvadePTD")
tmpInvadePTLX,tmpInvadePTLY=$game_map.get_storypoint("InvadePTL")
tmpInvadePTRX,tmpInvadePTRY=$game_map.get_storypoint("InvadePTR")
$game_map.npcs.each{|ev|
 next unless ev.summon_data
 next unless ev.summon_data[:Wave3]
 next unless [nil,:none].include?(ev.npc.action_state)
 ev.summon_data[:WildnessNapEvent] = "Goblin"
 case ev.summon_data[:Loc]
  when "T" ; ev.moveto(tmpInvadePTTX,tmpInvadePTTY)
  when "D" ; ev.moveto(tmpInvadePTDX,tmpInvadePTDY)
  when "L" ; ev.moveto(tmpInvadePTLX,tmpInvadePTLY)
  else ; ev.moveto(tmpInvadePTRX,tmpInvadePTRY)
 end
 ev.set_manual_move_type(3)
 ev.move_type = 3
 next unless ev.summon_data[:Wave3Boss]
 3.times{EvLib.sum("GoblinSlaveWarrior",ev.x,ev.y+2,{:master=>ev,:Wave3=>true})}
 3.times{EvLib.sum("GoblinSlaveSpear",ev.x,ev.y+1,{:master=>ev,:Wave3=>true})}
 4.times{EvLib.sum("GoblinSlaveClub",ev.x,ev.y-1,{:master=>ev,:Wave3=>true})}
} 

call_msg("TagMapNFL_MerCamp:OrcSlaveMaster/begin")
	eventPlayEnd
