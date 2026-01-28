if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpTableX,tmpTableY,tmpTableID=$game_map.get_storypoint("tableSGT")
tmpSgtX,tmpSgtY,tmpSgtID=$game_map.get_storypoint("SGT")
tmpDtX,tmpDtY,tmpDtID=$game_map.get_storypoint("DormTable")

####################################### Escape Slave ###############################
if $story_stats["Captured"] == 0 && $game_player.actor.stat["SlaveBrand"] == 1
	call_msg("TagMapDoomFortress:Gate/Enter_slave1")
	call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
	$story_stats["SlaveOwner"] = "DoomFortressR"
	$game_player.actor.add_state("MoralityDown30")
	$game_player.call_balloon(19)
	get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],600)
	cam_center(0)
	portrait_hide
	$game_temp.choice = -1 
	return

####################################### NightOrder ###############################
elsif $story_stats["Captured"] == 1 && $game_date.night?
	call_msg("TagMapDoomFortress:securityGuard/SlaveNight")
	cam_center(0)
	portrait_hide
	return
	

####################################### DayOrder ###############################
elsif $story_stats["Captured"] == 1 && $game_date.day?
	if get_character(tmpTableID).summon_data[:DayQuestAccept] ==  false && get_character(tmpTableID).summon_data[:WorkDone] == false
		get_character(tmpTableID).summon_data[:DayQuestAccept] = true
		
		call_msg("TagMapDoomFortress:securityGuard/SlaveDecideWork")
		#tmpWorkDone = get_character(tmpTableID).summon_data[:WorkDone]
		#tmpWorkPick = get_character(tmpTableID).summon_data[:WorkPick]
		#msgbox "tmpWorkDone  =>  #{tmpWorkDone}"   ##################################
		#msgbox "tmpWorkPick  =>  #{tmpWorkPick}"   ###################################
		
		############Check SGT alive?
		tmpSGTalive = $game_map.npcs.any?{
		|event| 
			next unless event.summon_data
			next unless event.summon_data[:SGThere] == true
			next if event.deleted?
			next if event.npc.action_state == :death
			true
		}
		
		############Check Jow Guard Alive?
		tmpGuardalive = $game_map.npcs.any?{
		|event| 
			next unless event.summon_data
			next unless event.summon_data[:JoyGuard] == true
			next if event.deleted?
			next if event.npc.action_state == :death
			true
		}
		
		if get_character(tmpTableID).summon_data[:WorkPick] == "Sandbag" && tmpSGTalive
			call_msg("TagMapDoomFortress:securityGuard/SlaveSandBag")
			get_character(tmpSgtID).call_balloon(28,-1)
			
		elsif get_character(tmpTableID).summon_data[:WorkPick] == "Joy" && tmpGuardalive
			call_msg("TagMapDoomFortress:securityGuard/SlaveJoyWork")
			get_character(tmpDtID).call_balloon(28,-1)
			
		else
			call_msg("TagMapDoomFortress:securityGuard/SlaveNoWork")
			get_character(tmpTableID).summon_data[:WorkDone] = true
		end
		
		
		call_msg("TagMapDoomFortress:securityGuard/SlaveFood")
		SndLib.sound_QuickDialog
		call_msg_popup("TagMapDoomFortress:securityGuard/SlaveFoodQmsg",get_character(0).id)
		get_character(0).animation = get_character(0).animation_atk_sh
		$game_map.reserve_summon_event("ItemBread",$game_player.x,$game_player.y)
		$game_map.reserve_summon_event("ItemBread",$game_player.x,$game_player.y)
		$game_map.reserve_summon_event("ItemBread",$game_player.x,$game_player.y)
		if $game_player.actor.wisdom_trait >= 15
			call_msg("TagMapDoomFortress:securityGuard/SlaveFood_AskMore")
			if $game_temp.choice == 1
				temp_roll_diff=rand(100)
				temp_roll_skill= $game_player.actor.wisdom+rand(120)
				if temp_roll_skill > temp_roll_diff  #唬爛成功
					call_msg("TagMapDoomFortress:securityGuard/SlaveFood_AskMore_win")
					optain_item($data_items[2],1)
				else
					call_msg("TagMapDoomFortress:securityGuard/SlaveFood_AskMore_fail")
				end
			end
		end
		#bread
	elsif get_character(tmpTableID).summon_data[:DayQuestAccept] ==  true && get_character(tmpTableID).summon_data[:WorkDone] == false
		call_msg("TagMapDoomFortress:securityGuard/SlaveDay")
	else
		call_msg("TagMapDoomFortress:securityGuard/SlaveWorkDone")
	end
	cam_center(0)
	portrait_hide
	$game_temp.choice = -1 
	return
	
####################################### East Cp quest ###############################
elsif $story_stats["RecQuestDF_Ecp"] == 1
	$story_stats["RecQuestDF_Ecp"] = 2
	call_msg("TagMapDoomFortEastCP:DFOfficer/overrunning_begin1")
	portrait_hide
	cam_center(0)
	chcg_background_color(0,0,0,0,7)
		get_character(0).delete
		get_character(0).moveto(1,1)
	chcg_background_color(0,0,0,255,-7)
	get_character($game_map.get_storypoint("SleepRoom")[2]).call_balloon(0)
	call_msg("TagMapDoomFortEastCP:DFOfficer/overrunning_begin1_board")
	change_map_tag_map_exit
	
####################################### Normal Whore ###############################
else
	call_msg("TagMapDoomFortress:securityGuard/NormalWhore") #[才不是！,我是]
	case $game_temp.choice
		when -1,0 ; 
			call_msg("TagMapDoomFortress:securityGuard/NormalWhore_No")
		when 1 ;
			get_character(tmpDtID).call_balloon(28,-1) if $game_date.day?
			call_msg("TagMapDoomFortress:securityGuard/NormalWhore_Yes")
	end
	cam_center(0)
	portrait_hide
	$game_temp.choice = -1 
	return
end
