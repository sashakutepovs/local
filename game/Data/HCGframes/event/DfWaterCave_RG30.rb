return get_character(0).erase if $story_stats["Captured"] == 0
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
if get_character(tmpDualBiosID).summon_data[:BeginRaped] == true && $story_stats["Captured"] == 1
	call_msg("TagMapDfWaterCave:actionRapeLoop/Wall0_#{rand(4)}")
	call_msg("TagMapDfWaterCave:actionRapeLoop/Wall1_opt") #[算了,抵抗]
	if $game_temp.choice == 1
		$game_player.call_balloon(19)
		$game_player.actor.sta -= 20
		get_character(tmpDualBiosID).summon_data[:MindBlockHP] -= 1
		if get_character(tmpDualBiosID).summon_data[:MindBlockHP] > 0
			#$game_map.interpreter.screen.start_shake(5,10,20)
			SndLib.sound_punch_hit(100)
			$game_player.direction = 8
			$game_player.jump_reverse
			$game_player.actor.force_stun("Stun3") #Stun3
			call_msg("TagMapDfWaterCave:actionRapeLoop/Wall0_NotEnough")
		else
			$game_map.npcs.each{
			|event|
				next unless event.summon_data
				next unless event.summon_data[:Heretic]
				next if event.deleted?
				next if event.npc.action_state == :death
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
			get_character(0).erase
			call_msg("TagMapDfWaterCave:actionRapeLoop/Wall0_Break")
		end
	else
		#$game_map.interpreter.screen.start_shake(5,10,20)
		SndLib.sound_punch_hit(100)
		$game_player.direction = 8
		$game_player.jump_reverse
		$game_player.actor.force_stun("Stun3") #Stun3
		call_msg("TagMapDfWaterCave:actionRapeLoop/Blocked#{rand(3)}")
	end
end
