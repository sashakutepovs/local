
$game_map.npcs.each{
|event|
	next unless event.summon_data
	next unless event.summon_data[:Heretic]
	next if event.deleted?
	next if event.npc.action_state == :death
	next if [:stun,:death].include?(event.npc.action_state)
	if event.npc.sex == 1
		#event.npc.fucker_condition={"weak"=>[50, ">"],"sex"=>[0, "="]}
		event.npc.fucker_condition={"sex"=>[65535, "="]}
		event.npc.killer_condition={"sex"=>[65535, "="]}
		event.npc.assaulter_condition={"health"=>[0, ">"]}
	end
	event.npc.fraction_mode = 4
	event.npc.set_fraction(15)
	event.npc.refresh
}
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
get_character(tmpDualBiosID).summon_data[:AggroLevel] +=1
if $story_stats["Captured"] == 1
	$story_stats["RapeLoopTorture"] = 1 if get_character(tmpDualBiosID).summon_data[:AggroLevel] >= 2
	call_msg("TagMapDfWaterCave:thisMap/Aggro_captured")
else
	$story_stats["RapeLoop"] = 0
	$story_stats["RapeLoopTorture"] = 0
	$story_stats["Captured"] = 1
	call_msg("TagMapDfWaterCave:thisMap/Aggro")
	call_msg("TagMapDfWaterCave:aggro/Cocona#{rand(2)}") if cocona_in_group?
end
portrait_hide
call_timer(40,60)
