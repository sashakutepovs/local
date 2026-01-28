if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if get_character(0).summon_data[:QuestPicked] == true
	tmpMCid = $game_map.get_storypoint("MapCont")[2]
	get_character(0).call_balloon(0)
	#doQuest
	$cg = TempCG.new(["event_WhoreWork"])
	call_msg("common:Lona/lure#{talk_style}#{rand(2)}")
	$cg.erase
	$game_player.animation = nil
	get_character(0).animation = get_character(0).animation_hold_sh
	cam_follow(get_character(0).id,0)
	get_character(0).call_balloon(20)
	call_msg("TagMapFishTown:Guards/OfferSex0_#{rand(2)}")
	wait(10)
	play_sex_service_menu(get_character(0),0,tmpPoint=nil,true,fetishLVL=3,forceCumIn=true)
	whole_event_end
	
	if get_character(tmpMCid).summon_data[:JobPick] == "House1"
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:House1OutTag]
				event[1].call_balloon(28,-1)
			}
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:House1InTag]
				event[1].call_balloon(0)
			}
	elsif get_character(tmpMCid).summon_data[:JobPick] == "House2"
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:House2OutTag]
				event[1].call_balloon(28,-1)
			}
		$game_map.events.each{|event|
				next if !event[1].summon_data
				next if !event[1].summon_data[:House2InTag]
				event[1].call_balloon(0)
				cam_follow(event[1].id,0)
			}
	end
		get_character(0).summon_data[:QuestDone] = true
		call_msg("TagMapFishTown:wakeUpRape/begin4_#{rand(3)}")
		call_msg("TagMapFishTown:wakeUpRape/begin5")
else
	SndLib.sound_QuickDialog
	$game_map.popup(get_character(0).id,"TagMapNoerDock:FrogmanPrayer/Pray#{rand(3)}",0,0)
end
eventPlayEnd

