if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


	############Check Jow Guard Alive?
	tmpGuardalive = $game_map.npcs.any?{
	|event| 
		next unless event.summon_data
		next unless event.summon_data[:JoyGuard] == true
		next if event.deleted?
		next if event.npc.action_state == :death
		true
	}
tmpReward = 0
tmpAggro = 0
tmpQuit = 0
tmpRape = 0
tmpDoDance = 0
dance_score = 0
tmpPoX= $game_player.x
tmpPoy= $game_player.y
tmpTableX,tmpTableY,tmpTableID=$game_map.get_storypoint("tableSGT")
tmpDtX,tmpDtY,tmpDtID=$game_map.get_storypoint("DormTable")
tmpQ1 = get_character(tmpTableID).summon_data[:DayQuestAccept] == true
tmpQ2 = get_character(tmpTableID).summon_data[:WorkDone] == false
tmpQ3 = get_character(tmpTableID).summon_data[:WorkPick] == "Joy"
event_list = [
			"AnalTouch",
			"BoobTouch",
			"VagTouch",
			"Kiss"
]


$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT1"] = "1" if $story_stats["Captured"] != 1 || $game_player.actor.wisdom_trait >= 20

#################################################### Slave Dance ############################################
if $story_stats["Captured"] == 1 && tmpQ1 && tmpQ2 && tmpQ3 && tmpGuardalive
	get_character(0).call_balloon(0)
	call_msg("TagMapDoomFortress:JoyTable/JobBegin0_slave")
	call_msg("TagMapDoomFortress:JoyTable/JobBegin1")
	if $game_temp.choice == 0
		$game_player.forced_y = -24
		$game_player.jump_to(tmpDtX,tmpDtY)
		$game_player.direction = 2
		wait(45)
		cam_center(0)
		4.times{
			$game_map.npcs.each do |event|
				next if event.deleted?
				next if event.actor.action_state == :death
				next if event.summon_data == nil
				next if !event.summon_data[:JoyGuard]
				event.npc_story_mode(true)
				event.move_goto_xy($game_player.x,$game_player.y)
				event.turn_toward_character($game_player)
			end
			wait(30)
			cam_center(0)
		}
		call_msg("TagMapDoomFortress:JoyTable/JobBegin2")
		if $game_temp.choice == 0
			tmpDoDance =1
			call_msg("TagMapDoomFortress:JoyTable/JobBegin3")
		end
		$game_player.forced_y = 0
	end

	$game_temp.choice != 0 ? tmpAggro = 1 : tmpAggro = 0
	
#################################################### Normal Whore Dance ############################################
elsif $game_date.day? && $story_stats["Captured"] == 0 && $story_stats["#{map_id}DailyWorkAmt"] != $game_date.dateAmt && get_character(tmpTableID).summon_data[:WorkDone] == false && tmpGuardalive
	get_character(tmpTableID).summon_data[:WorkDone] = true
	$story_stats["#{map_id}DailyWorkAmt"] = $game_date.dateAmt
	get_character(0).call_balloon(0)
	call_msg("TagMapDoomFortress:JoyTable/JobBegin0_whore")
	call_msg("TagMapDoomFortress:JoyTable/JobBegin1")
	if $game_temp.choice == 0
		$game_player.forced_y = -24
		$game_player.jump_to(tmpDtX,tmpDtY)
		$game_player.direction = 2
		cam_center(0)
		wait(45)
		5.times{
			$game_map.npcs.each do |event|
				next if event.deleted?
				next if event.actor.action_state == :death
				next if event.summon_data == nil
				next if !event.summon_data[:JoyGuard]
				event.npc_story_mode(true)
				event.move_goto_xy($game_player.x,$game_player.y) if event.report_range($game_player) > 1
				event.turn_toward_character($game_player)
			end
			wait(30)
			cam_center(0)
		}
		call_msg("TagMapDoomFortress:JoyTable/JobBegin2")
		if $game_temp.choice == 0
			tmpDoDance =1
			call_msg("TagMapDoomFortress:JoyTable/JobBegin3")
		end
		$game_player.forced_y = 0
	end
	$game_temp.choice != 0 ? tmpQuit = 1 : tmpQuit = 0
	
else
	get_character(0).call_balloon(0)
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapDoomFortress:JoyTable/NothingQmsg#{rand(3)}",0)
end
#################################################### end CHk ############################################

if tmpDoDance == 1
	$game_player.forced_y = -24
	round = 0
	3.times{
		$game_player.actor.sta -= 5+rand(2)

		$game_player.animation = $game_player.animation_dance
		call_msg("TagMapDoomFortress:JoyTable/JobBegin4_#{round}")
		cam_center(0)
		score = mini_game_ddr
		score = -1 if score == 0
		dance_score += score
		round += 1

		event_pick = event_list.sample
		tmpARY = Array.new
		$game_map.npcs.each do |event|
			next if event.deleted?
			next if event.actor.action_state == :death
			next if event.summon_data == nil
			next if !event.summon_data[:JoyGuard]
			tmpARY += [event.id]
			#event.animation = event.animation_atk_mh
		end
		call_msg("TagMapDoomFortress:JoyTable/Touch_Opt") #[隨便他<t=2>,躲開]
		if $game_temp.choice == 0
			if !tmpARY.empty?
				tmpChar = get_character(tmpARY.sample)
				tmpChar.animation = tmpChar.animation_atk_charge
				case event_pick
					when "AnalTouch"
								event_Grab_AnalTouch("Human")
					when "BoobTouch"
								event_Grab_BoobTouch("Human")
					when "VagTouch"
								event_Grab_VagTouch("Human")
					when "Kiss"
								event_Grab_Kissed("Human")
				end
				$game_player.actor.sta -=1
				$game_player.actor.add_state("DoormatUp20")
				call_msg_popup("TagMapDoomFortress:JoyTable/#{event_pick}_Qmsg",tmpChar.id)
				cam_center(0)
				get_character(tmpChar.id).call_balloon(4)
			end
		else
			if !tmpARY.empty?
				tmpChar = get_character(tmpARY.sample)
				tmpChar.animation = tmpChar.animation_atk_mh
				call_msg_popup("TagMapDoomFortress:JoyTable/Escape_Qmsg",tmpChar.id)
				cam_center(0)
			end
		end

		
		wait(120)
		whole_event_end
	}#times
	$game_player.forced_y = 0
	get_character(tmpTableID).summon_data[:WorkDone] = true
	$game_player.animation = nil
	if $story_stats["Captured"] == 1
		if $game_player.actor.sexy >= 110
			call_msg("TagMapDoomFortress:JoyTable/JobBegin_slave_reward")
			optain_item("ItemBread")
			#$game_map.reserve_summon_event("ItemBread",$game_player.x,$game_player.y)
		end
		if dance_score >= 6
			tmpRape = 1
		elsif dance_score >= 6
			tmpRape = 0
		else
			tmpRape = 1
		end
	elsif $game_player.actor.sexy >= 110
		tmpReward = 200+((6+dance_score)*$game_player.actor.sexy)
		call_msg("TagMapDoomFortress:JoyTable/JobBegin_whore_end")
		optain_item_chain(tmpReward,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
		if dance_score >= 6
			tmpRape = 1
		else
			tmpRape = 0
		end
	else
		tmpReward = 200+(6*$game_player.actor.sexy)
		call_msg("TagMapDoomFortress:JoyTable/JobBegin_whore_end")
		optain_item_chain(tmpReward,["ItemCoin1","ItemCoin2","ItemCoin3"],false)
	end
end

$game_map.npcs.each do |event|
	next if event.deleted?
	next if event.actor.action_state == :death
	next if event.summon_data == nil
	next if !event.summon_data[:JoyGuard]
	event.npc_story_mode(false)
end

if tmpRape == 1
	call_msg("TagMapDoomFortress:JoyTable/JobBegin_rape")
	tmpAggro = 0
	$game_map.npcs.each do |event|
		next if event.deleted?
		next if event.actor.action_state == :death
		next if event.summon_data == nil
		next if !event.summon_data[:JoyGuard]
		event.actor.fucker_condition={"sex"=>[0, "="]}
		if [true,false].sample
			event.actor.launch_skill($data_arpgskills["NpcMasturbationMale"],true)
		elsif [true,false].sample
			event.actor.launch_skill($data_arpgskills["NpcHarassAnalTouch"],true)
		else
			event.actor.launch_skill($data_arpgskills["NpcHarassBoobTouch"],true)
		end
	end
	
elsif tmpAggro == 1
	call_msg("TagMapDoomFortress:JoyTable/JobBegin_beat")
	$game_map.npcs.each do |event|
		next if event.deleted?
		next if event.actor.action_state == :death
		next if event.summon_data == nil
		next if !event.summon_data[:JoyGuard]
		event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
	end
elsif tmpQuit == 1
	call_msg("TagMapDoomFortress:JoyTable/JobBegin_quit")
end

$game_temp.choice = -1
$story_stats["HiddenOPT1"] = "0"
cam_center(0)
portrait_hide
