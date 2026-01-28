if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
if get_character(0).summon_data == nil
 get_character(0).set_summon_data({:SexTradeble => true})
elsif get_character(0).summon_data[:SexTradeble] == nil
 get_character(0).summon_data[:SexTradeble] = true
end



if $story_stats["#{map_id}DailyWorkAmt"] != $game_date.dateAmt && get_character(0).summon_data[:jobstage] == 0
	#can accept job
	$game_temp.choice = -1
	
	call_msg("TagMapPirateBane:Sanders/MyCock0")
	call_msg("TagMapPirateBane:Sanders/MyCock1")
	call_msg("common:Lona/Decide_optB")
	#started job
	if $game_temp.choice == 1
		$story_stats["#{map_id}DailyWorkAmt"] = $game_date.dateAmt
		get_character(0).summon_data[:jobstage] = 1
		call_timer(60,60)
		camEV = get_character(0)
		$game_map.events.each{|tmpEV|
			next unless tmpEV[1].summon_data
			next unless tmpEV[1].summon_data[:chickenQuest]
			posi=$game_map.region_map[13].sample
			tmpEV[1].opacity = 255
			tmpEV[1].moveto(posi[0],posi[1])
			tmpEV[1].call_balloon(19,-1)
			tmpEV[1].move_type = 3
			camEV = tmpEV[1]
		}
		$game_map.npcs.each {|tmpEV|
			next unless tmpEV.summon_data
			next unless tmpEV.summon_data[:Chicken]
			tmpEV.delete
		}
		cam_follow(camEV.id,0)
		call_msg("TagMapPirateBane:Sanders/MyCock2")
		
	end
	
	
	#job working
elsif get_character(0).summon_data[:jobstage] == 1
	all_IN = $game_map.events.any?{|tmpEV|
		next unless tmpEV[1].summon_data
		next unless tmpEV[1].summon_data[:chickenQuest]
		next if tmpEV[1].region_id == 17
		true
	}
	
	#if false quest win
	if all_IN == false && $game_timer.count > 1
		#in time. double reward
		call_timer_off
		call_msg("TagMapPirateBane:Sanders/MyCock_done")
		get_character(0).summon_data[:jobstage] = 2
		optain_item($data_items[50],4)
		wait(30)
		optain_exp(1000)
	elsif all_IN == false && $game_timer.count <= 1
		#not in time, less reward
		call_timer_off
		call_msg("TagMapPirateBane:Sanders/MyCock_done")
		get_character(0).summon_data[:jobstage] = 2
		optain_item($data_items[50],2)
		wait(30)
		optain_exp(500)
	else
		camEV = get_character(0)
		$game_map.events.any?{|tmpEV|
			next unless tmpEV[1].summon_data
			next unless tmpEV[1].summon_data[:chickenQuest]
			next if tmpEV[1].region_id == 17
			camEV = tmpEV[1]
		}
		cam_follow(camEV.id,0)
		call_msg("TagMapPirateBane:Sanders/MyCock_working")
	end
else
	call_msg("TagMapPirateBane:Sanders/MyCock_done")
	
end

eventPlayEnd