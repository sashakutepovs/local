tmpDoTricketX,tmpDoTricketY,tmpDoTricketID=$game_map.get_storypoint("DoTricket")
tmpBirthEVWakeUpX,tmpBirthEVWakeUpY,tmpBirthEVWakeUpID=$game_map.get_storypoint("BirthEVWakeUp")
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
elsif $game_player.record_companion_name_ext == "CompExtUniqueElise"
	$game_map.popup(get_character(0).id,"TagMapNoerTavern:Nap/NotMyBed",0,0)
	return SndLib.sys_buzzer
elsif ([16,17].include?($story_stats["RecQuestLisa"]) && $story_stats["UniqueCharUniqueLisa"] != -1) && !(get_character(tmpBirthEVWakeUpID) == get_character(0) && get_character(tmpDoTricketID).summon_data[:BirthLockedRoom] == true)
	$game_map.popup(get_character(0).id,"TagMapNoerTavern:Nap/NotMyBed",0,0)
	return SndLib.sys_buzzer
elsif get_character(tmpDoTricketID).summon_data[:canSleep] == true || get_character(tmpDoTricketID).summon_data[:BirthLockedRoom] == true
	load_script("Data/HCGframes/Command_AreaNap.rb")
elsif get_character(tmpDoTricketID).summon_data[:canSleep] == false
	$game_map.popup(get_character(0).id,"QuickMsg:EliseGynecology/EmptyBed",0,0)
	return SndLib.sys_buzzer
else
	return SndLib.sys_buzzer
end
