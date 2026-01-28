
if $story_stats["RecQuestSouthFLMain"] == 0
	SndLib.bgs_play("forest_wind",80,100)
	SndLib.bgm_play("D/7-Dark Fantasy Studio- The forest",70,100, RPG::BGM.last.pos)
	$game_map.shadows.set_color(50, 120, 70) if $game_date.day?
	$game_map.shadows.set_opacity(100)  if $game_date.day?
	$game_map.shadows.set_color(50, 120, 70) if $game_date.night?
	$game_map.shadows.set_opacity(160)  if $game_date.night?
	map_background_color(200,40,150,40,0)
	$game_map.interpreter.weather("snow", 5, "redDot",true)
	$game_map.set_fog("infested_fallSM")

	fadeout=$story_stats["ReRollHalfEvents"] == 1
	enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
	summon_companion

	tmpLeaderX,tmpLeaderY,tmpLeaderID=$game_map.get_storypoint("Leader")
	tmpPriestX,tmpPriestY,tmpPriestID=$game_map.get_storypoint("Priest")
	tmpOPquestCountID=$game_map.get_storypoint("OPquestCount")[2]
	$story_stats["RecQuestSouthFLMain"] = 1
	tmpStartPointX,tmpStartPointY=$game_map.get_storypoint("StartPoint")
	$game_player.moveto(tmpStartPointX,tmpStartPointY)
	$game_player.direction = 4
	get_character(tmpLeaderID).moveto(tmpLeaderX-1,tmpLeaderY+2)
	#chcg_background_color(0,0,0,255,-7)
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:ppl] == true
		next if event.actor.action_state == :death
		event.npc_story_mode(true)
	end
	portrait_hide ; call_msg("TagMapSouthFL:OpQuest/Begin0") ; portrait_hide 
	3.times{
		$game_player.move_forward_force
		wait(15)
	}
	call_msg("TagMapSouthFL:OpQuest/Begin1") ; portrait_hide 
	$game_player.direction = 8
	$game_player.call_balloon(8) ; wait(50)
	$game_player.direction = 2
	$game_player.call_balloon(8) ; wait(50)
	call_msg("TagMapSouthFL:OpQuest/Begin2") ; portrait_hide 
	call_msg("TagMapSouthFL:OpQuest/Begin_INC0")
	$game_player.direction = 8
	call_msg("TagMapSouthFL:OpQuest/Begin_INC1")
	###################################################################### Summon Enemy Wave1
	call_msg("TagMapSouthFL:OpQuest/Begin_INC2")
	4.times{
		posi=$game_map.region_map[10].sample
		EvLib.sum("AbomCreatureBat",posi[0],posi[1]-8,{:AbomQuestObj=>true})
	}
	$game_player.direction = 8
	$game_player.call_balloon(1)
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:ppl] == true
		next if event.actor.action_state == :death
		event.move_speed = 3
		event.move_type = 0
		event.direction = 8
		event.call_balloon(1)
	end
	get_character(tmpPriestID).direction = 6
	SndLib.bgm_play("CB_Rise of the Fallen_looped",80,100)
	call_msg("TagMapSouthFL:OpQuest/Begin_INC3") ; portrait_hide 
	get_character(tmpPriestID).direction = 8
	get_character(tmpLeaderID).npc_story_mode(true)
	4.times{
		get_character(tmpLeaderID).direction = 6 ; get_character(tmpLeaderID).move_forward_force
		wait(25)
	}
	get_character(tmpLeaderID).moveto(get_character(tmpLeaderID).x,get_character(tmpLeaderID).y)
	$game_player.direction = 4
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:ppl] == true
		next if event.actor.action_state == :death
		event.turn_toward_character(get_character(tmpLeaderID))
	end
	call_msg("TagMapSouthFL:OpQuest/Begin_RUN0") ; portrait_hide 
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:ppl] == true
		next if event.actor.action_state == :death
		event.direction = 4
		event.move_forward_force
	end
	get_character(tmpLeaderID).direction = 6 ; get_character(tmpLeaderID).move_forward_force
	wait(25)
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:ppl] == true
		next if event.actor.action_state == :death
		event.direction = 4
		event.move_forward_force
	end
	get_character(tmpLeaderID).direction = 6 ; get_character(tmpLeaderID).move_forward_force
	wait(25)
	3.times{
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next unless event.summon_data[:ppl] == true
			next if event.actor.action_state == :death
			event.direction = 4
			event.move_forward_force
		end
		wait(30)
	}
	chcg_background_color(0,0,0,0,7)
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next unless event.summon_data[:ppl] == true
			next if event.actor.action_state == :death
			event.delete
		end
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next unless event.summon_data[:pplObj] == true
			next if event.actor.action_state == :death
			event.delete
		end
		get_character(tmpLeaderID).npc_story_mode(false)
		get_character(tmpLeaderID).moveto(get_character(tmpLeaderID).x,get_character(tmpLeaderID).y)
		$game_player.direction = 4
		get_character(tmpPriestID).direction = 2
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapSouthFL:OpQuest/Begin_WTF0") ; portrait_hide
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:AbomQuestObj] == true
		next if event.actor.action_state == :death
		event.npc_story_mode(true)
		event.move_type = 0
	end
	$game_player.direction = 8
	get_character(tmpLeaderID).direction = 8
	get_character(tmpPriestID).direction = 8
	SndLib.AbomBatSpot(60)
	8.times{
		$game_map.npcs.each do |event|
			next if event.summon_data == nil
			next unless event.summon_data[:AbomQuestObj] == true
			next if event.actor.action_state == :death
			event.direction = 2
			event.move_forward_force
		end
	wait(10)
	}
	$game_player.turn_random
	get_character(tmpLeaderID).turn_random
	get_character(tmpPriestID).direction=2
	get_character(tmpPriestID).set_manual_trigger(-1)
	get_character(tmpPriestID).trigger = -1
	get_character(tmpLeaderID).npc.no_aggro = true
	get_character(tmpPriestID).npc.no_aggro = true
	SndLib.AbomBatSpot(90)
	wait(30)
	SndLib.AbomBatSpot(90)
	wait(30)
	call_msg("TagMapSouthFL:OpQuest/Begin_WTF1") ; portrait_hide
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next unless event.summon_data[:AbomQuestObj] == true
		next if event.actor.action_state == :death
		event.npc_story_mode(false)
		event.move_type = 1
	end
	eventPlayEnd
	get_character(tmpLeaderID).direction = 6
	get_character(tmpPriestID).direction = 2
	set_event_force_page(tmpOPquestCountID,2) ########### Set quest page to 2
elsif $story_stats["RecQuestSouthFLMain"] == 1
		weather_batch_r6_SouthFL
		tmpLP = RPG::BGM.last.pos
		SndLib.bgm_play("D/7-Dark Fantasy Studio- The forest",70,100,tmpLP)
		$story_stats["BG_EFX_data"] = get_BG_EFX_data

	fadeout=$story_stats["ReRollHalfEvents"] == 1
	enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
	summon_companion

	$story_stats["RecQuestSouthFLMain"] = 2
	tmpLeaderX,tmpLeaderY,tmpLeaderID=$game_map.get_storypoint("Leader")
	get_character(tmpLeaderID).call_balloon(28,-1)
else
		weather_batch_r6_SouthFL
		tmpLP = RPG::BGM.last.pos
		SndLib.bgm_play("D/7-Dark Fantasy Studio- The forest",70,100,tmpLP)
		$story_stats["BG_EFX_data"] = get_BG_EFX_data

	fadeout=$story_stats["ReRollHalfEvents"] == 1
	enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
	summon_companion

end
eventPlayEnd
get_character(0).erase
