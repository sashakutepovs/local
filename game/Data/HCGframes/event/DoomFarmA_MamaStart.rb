if $game_map.threat
 SndLib.sys_buzzer
 $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
 return
end

tmpMamaX,tmpMamaY,tmpMamaID = $game_map.get_storypoint("mama")
tmpPapaX,tmpPapaY,tmpPapaID = $game_map.get_storypoint("papa")
tmpSonX,tmpSonY,tmpSonID = $game_map.get_storypoint("son")
tmpMcX,tmpMcY,tmpMcID = $game_map.get_storypoint("MapCont")
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUpSexBed")
tmpMaBedX,tmpMaBedY,tmpMaBedID = $game_map.get_storypoint("MamaBed")
tmpTorX,tmpTorY,tmpTorID = $game_map.get_storypoint("torturePT")
tmpMtX,tmpMtY,tmpMtID = $game_map.get_storypoint("MainTable")
tmpHtcX,tmpHtcY,tmpHtcID = $game_map.get_storypoint("HouseToOutC")


tmp_aggro = false
get_character(0).animation =  nil
get_character(0).call_balloon(0)

#check family count
tmpTodoCount = 0
$game_map.npcs.each{
|event|
	next unless event.summon_data
	next unless event.summon_data[:family]
	next if event.npc.action_state == :death
	next if event.deleted?
	tmpTodoCount +=1
}

#if ne1 dead
if tmpTodoCount < 3
	tmp_aggro = true
end

tmpPapaRaped	=	get_character(tmpMcID).summon_data[:PapaRaped]
tmpBreakfast	=	get_character(tmpMcID).summon_data[:Breakfast]
tmpWorked		=	get_character(tmpMcID).summon_data[:Worked]
tmpWorkType		=	get_character(tmpMcID).summon_data[:WorkType]
tmpNeedWork		=	get_character(tmpMcID).summon_data[:NeedWork]
if tmp_aggro == false && $story_stats["Captured"] == 0 
	call_msg("TagMapDoomFarmA:mama/begin1")
	get_character(tmpPapaID).turn_toward_character($game_player)
	call_msg("TagMapDoomFarmA:mama/begin2") #[算了吧,好,關於]
	get_character(tmpPapaID).direction = 2
	if $game_temp.choice == 1
		load_script("Data/HCGframes/event/DoomFarmA_Dinner.rb")
	elsif $game_temp.choice == 2
		call_msg("TagMapDoomFarmA:mama/about_1")
	else
		call_msg("TagMapDoomFarmA:mama/begin_nope")
	end
	
#吃過飯了?
elsif tmp_aggro == false && $story_stats["Captured"] == 1 && tmpNeedWork && tmpBreakfast && tmpWorked && tmpWorkType == nil
	call_msg("TagMapDoomFarmA:breakFast/begin_0")
	get_character(tmpMtID).call_balloon(28,-1)
	
#以亂數產生工作項目 並告知工作
elsif tmp_aggro == false && $story_stats["Captured"] == 1 && tmpNeedWork && !tmpBreakfast && tmpWorked && tmpWorkType == nil
	get_character(tmpMcID).summon_data[:WorkType] = ["grass","suck","feed"].sample
	case get_character(tmpMcID).summon_data[:WorkType]
		when "grass"
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if event[1].summon_data[:grass] != true
				posi=$game_map.region_map[17].sample
				event[1].moveto(posi[0],posi[1])
				event[1].call_balloon(19)
			}
		call_msg("TagMapDoomFarmA:JobGrass/begin_1")
		call_timer(30,60)
		when "suck"
			get_character(tmpMamaID).summon_data[:suck_job] = false
			get_character(tmpPapaID).summon_data[:suck_job] = false
			get_character(tmpMamaID).npc_story_mode(true)
			get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_peeing
			call_msg("TagMapDoomFarmA:JobSuck/begin_1")
			get_character(tmpMamaID).npc_story_mode(false)
			get_character(tmpMamaID).call_balloon(28,-1)
			get_character(tmpPapaID).call_balloon(28,-1)
		when "feed"
			get_character(tmpMcID).summon_data[:CarryFood] = false
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if event[1].summon_data[:chicken] != true
				event[1].summon_data[:feeded] = false
				event[1].call_balloon(19)
			}
			$game_map.events.each{|event|
				next if !event[1].summon_data
				next if event[1].summon_data[:food] != true
				event[1].call_balloon(28,-1)
			}
		call_msg("TagMapDoomFarmA:JobFeed/begin_1")
		call_timer(53,60)
	end
	
#快去工作 含完成檢查
elsif tmp_aggro == false && $story_stats["Captured"] == 1 && tmpNeedWork && !tmpBreakfast && tmpWorked && tmpWorkType != nil
	case get_character(tmpMcID).summon_data[:WorkType]
		when "grass"
			workAmtChk = $game_map.events.any?{
			|event| 
			next unless event[1].summon_data
			next unless event[1].summon_data[:grass]
			next if event[1].deleted?
			true
			}
			if $game_timer.count >= 1 && !workAmtChk
				$story_stats["RapeLoopTorture"] = 0
				get_character(tmpMcID).summon_data[:Worked] = false
				get_character(tmpMcID).summon_data[:WorkType] = nil
				call_timer_off
				call_msg("TagMapDoomFarmA:JobGrass/win")
			elsif !workAmtChk
				$story_stats["RapeLoopTorture"] = 1
				get_character(tmpMcID).summon_data[:Worked] = false
				get_character(tmpMcID).summon_data[:WorkType] = nil
				call_msg("TagMapDoomFarmA:JobGrass/failed")
			else
				$game_map.events.each{|event|
					next if !event[1].summon_data
					next if event[1].summon_data[:grass] != true
					posi=$game_map.region_map[17].sample
					event[1].moveto(posi[0],posi[1])
					event[1].call_balloon(19)
				}
				call_msg("TagMapDoomFarmA:JobGrass/NotFinish")
			end
		when "suck"
			tmpMamaSucked = get_character(tmpMamaID).summon_data[:suck_job]
			tmpPapaSucked = get_character(tmpPapaID).summon_data[:suck_job]
			if tmpMamaSucked == false
				get_character(tmpMamaID).npc_story_mode(true)
				get_character(tmpMamaID).animation = get_character(tmpMamaID).animation_masturbation
				load_script("Data/HCGframes/event/DoomFarmA_SuckMama.rb")
				get_character(tmpMamaID).animation = nil
				call_msg("TagMapDoomFarmA:JobSuck/Mama_doneButPapa") if tmpPapaSucked == false
				get_character(tmpMamaID).npc_story_mode(false)
				get_character(tmpMamaID).summon_data[:suck_job] = true
				if get_character(tmpPapaID).summon_data[:suck_job] == true && get_character(tmpMamaID).summon_data[:suck_job] == true
					get_character(0).call_balloon(28,-1)
				end
			elsif tmpPapaSucked == false
				call_msg("TagMapDoomFarmA:JobSuck/Mama_PapaNotDone")
			elsif tmpPapaSucked == true && tmpMamaSucked == true
				call_msg("TagMapDoomFarmA:JobSuckw/win")
				$story_stats["RapeLoopTorture"] = 0
				get_character(tmpMcID).summon_data[:Worked] = false
				get_character(tmpMcID).summon_data[:WorkType] = nil
			end
		when "feed"
			feedAMT = 0
			$game_map.events.each{|event|
			next if !event[1].summon_data
			next if event[1].deleted?
			next unless event[1].summon_data[:chicken] == true
			next unless event[1].summon_data[:feeded] == true
			feedAMT += 1
			}
			if $game_timer.count >= 1 && feedAMT >= 3
				call_msg("TagMapDoomFarmA:JobFeed/win")
				get_character(tmpMcID).summon_data[:Worked] = false
				get_character(tmpMcID).summon_data[:WorkType] = nil
				call_timer_off
			elsif feedAMT >= 3
				$story_stats["RapeLoopTorture"] = 1
				get_character(tmpMcID).summon_data[:Worked] = false
				get_character(tmpMcID).summon_data[:WorkType] = nil
				call_msg("TagMapDoomFarmA:JobGrass/failed")
			else
				call_msg("TagMapDoomFarmA:JobFeed/NotFinish")
			end
	end #work case
	
	
#結過婚又回來的情況
elsif tmp_aggro == false && $story_stats["Captured"] == 0 && $story_stats["RecQuestDoomFarmAWaifu"] == 1
	call_msg("TagMapDoomFarmA:mama/begin_return")
	
#不需要工作的情況(第一次被抓 或剛被抓,或工作完成)
elsif tmp_aggro == false && $story_stats["Captured"] == 1 #&& $story_stats["RapeLoop"] == 1
	call_msg("TagMapDoomFarmA:mama/Capture0")
	
	
end


if tmp_aggro == true
	$game_map.npcs.each{
	|event|
		next unless event.summon_data
		next unless event.summon_data[:family]
		next if event.npc.action_state == :death
		next if event.deleted?
		event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
		event.call_balloon(1)
	}
	portrait_hide
	cam_center(0)
	return
end
portrait_hide
cam_center(0)
