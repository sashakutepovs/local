get_character(0).set_summon_data({}) if !get_character(0).summon_data
move_to_1f = false

tmpCoconaID=$game_map.get_storypoint("Cocona")[2]
if cocona_in_group? && get_character(tmpCoconaID).region_id != 51
	SndLib.sys_buzzer
	call_msg_popup("CompCocona:cocona/RecQuestCocona_16_ExitQmsg")
	return
end
if cocona_in_group? && !get_character(0).summon_data[:checked]
	call_msg("TagMapNoerCatacombB1:Cocona/to1fBlock")
	#get_character(55).set_summon_data({"1fBlkObj"=>true})
	#get_character(50).set_summon_data({"1fBlkObj"=>true})
	#get_character(51).set_summon_data({"1fBow"=>true})
	#get_character(52).set_summon_data({"1fBow"=>true})
	#get_character(53).set_summon_data({"1fGuard"=>true})
	#get_character(54).set_summon_data({"1fGuard"=>true})
	#get_character(57).set_summon_data({"1fGuard"=>true})
	#get_character(58).set_summon_data({"1fGuard"=>true})
	#get_character(59).set_summon_data({"1fBow"=>true})
	#get_character(60).set_summon_data({"1fBow"=>true})
	$game_map.npcs.each do |event|
		next unless event.summon_data
		next unless event.summon_data["1fBlkObj"]
		next if event.deleted?
		next if event.actor.action_state == :death
		EvLib.sum("OrcClub",event.x,event.y,{:OrkArmy=>true})
		event.delete
	end
	$game_map.npcs.each do |event|
		next unless event.summon_data
		next unless event.summon_data["1fGuard"]
		next if event.deleted?
		next if event.actor.action_state == :death
		EvLib.sum("GoblinBow",event.x,event.y,{:OrkArmy=>true})
		tmpDel = [true,false].sample
		event.delete if tmpDel
		event.item_jump_to if !tmpDel
	end
	$game_map.npcs.each do |event|
		next unless event.summon_data
		next unless event.summon_data["1fBow"]
		next if event.deleted?
		next if event.actor.action_state == :death
		EvLib.sum("GoblinWarrior",event.x,event.y,{:OrkArmy=>true})
		tmpDel = [true,false].sample
		event.delete if tmpDel
		event.item_jump_to if !tmpDel
	end
	get_character(0).summon_data[:checked] = true
	eventPlayEnd
elsif cocona_in_group?
	call_msg("CompCocona:Cocona/RecQuestCocona_12_food3")
	eventPlayEnd
	move_to_1f = true
else
	move_to_1f = true
end
if move_to_1f
	moveto_teleport_point("TarB1")
	$game_player.direction = 8
end
