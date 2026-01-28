 if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
tmpLeaderX,tmpLeaderY,tmpLeaderID=$game_map.get_storypoint("Leader")
tmpCoX,tmpCoY,tmpCoID=$game_map.get_storypoint("Cannon")
tmpCoBlkID=$game_map.get_storypoint("CannonBlk")[2]
if $story_stats["RecQuestSouthFLMain"] == 1
	abomAlive = $game_map.npcs.any?{
		|event| 
		next unless event.summon_data
		next unless event.summon_data[:AbomQuestObj]
		next if event.deleted?
		next if event.npc.action_state == :death
		true
	}
	if !abomAlive
		tmpOPquestCountID=$game_map.get_storypoint("OPquestCount")[2]
		set_event_force_page(tmpOPquestCountID,1)
		$story_stats["RecQuestSouthFLMain"] = 2
		call_msg("TagMapSouthFL:OpQuest/Win0")
		optain_item($data_items[50],6)
		wait(30)
		optain_exp(4000)
		call_msg("TagMapSouthFL:OpQuest/Win1")
	else
		call_msg("TagMapSouthFL:OpQuest/Begin_WTF1")
	end
	######################################################################################### 接受孵化池任務
elsif $story_stats["RecQuestSouthFLMain"] == 2
	call_msg("TagMapSouthFL:Qprog2/PoolQuest_0")
	call_msg("TagMapSouthFL:Qprog2/PoolQuest_1")
	call_msg("common:Lona/Decide_optB") #no , yes
	if $game_temp.choice == 1
		call_msg("TagMapSouthFL:Qprog2/PoolQuest_accept")
		$story_stats["RecQuestSouthFLMain"] = 3
	end
	
	######################################################################################### 完成孵化池
elsif $story_stats["RecQuestSouthFLMain"] == 5
	$story_stats["RecQuestSouthFLMainAmt"] = $game_date.dateAmt
	$story_stats["RecQuestSouthFLMain"] = 6
	call_msg("TagMapSouthFL:Qprog5/PoolQuest_Done")
	if $story_stats["RecQuestSouthFLKilledByLona"] == 1
		call_msg("TagMapSouthFL:Qprog5/PoolQuest_Done_Lona")
		GabeSDK.getAchievement("DefeatSpawnPoolWithoutDedOne")
	else
		call_msg("TagMapSouthFL:Qprog5/PoolQuest_Done_DedHalp")
	end
	call_msg("TagMapSouthFL:Qprog5/PoolQuest_Done_end")
	optain_exp(9000)
	
	######################################################################################### 接受右方交戰區任務
elsif $story_stats["RecQuestSouthFLMain"] == 6 && $game_date.dateAmt > $story_stats["RecQuestSouthFLMainAmt"]
	$story_stats["RecQuestSouthFLMainAmt"] = $game_date.dateAmt
	$story_stats["RecQuestSouthFLMain"] = 7
	call_msg("TagMapSouthFL:Qprog6/RaidOnEast_replay")
	
	######################################################################################### RAID QUEST
elsif $story_stats["RecQuestSouthFLMain"] == 7 && $game_date.dateAmt > $story_stats["RecQuestSouthFLMainAmt"]
	call_msg("TagMapSouthFL:Qprog7/RaidOnEast0")
	call_msg("TagMapSouthFL:Qprog7/RaidOnEast1")
	call_msg("common:Lona/Decide_optB") #no , yes
	if $game_temp.choice == 1
		call_msg("TagMapSouthFL:Qprog7/RaidOnEast_accept0") ; portrait_hide
		get_character(0).npc_story_mode(true)
		cam_center(0)
		2.times{
			$game_player.turn_toward_character(get_character(0))
			get_character(0).direction = 2 ; get_character(0).move_forward_force
			wait(25)
		}
		4.times{
			$game_player.turn_toward_character(get_character(0))
			get_character(0).direction = 6 ; get_character(0).move_forward_force
			wait(25)
		}
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character(0).delete
		chcg_background_color(0,0,0,255,-7)
		call_msg("TagMapSouthFL:Qprog7/RaidOnEast_accept1")
		$story_stats["RecQuestSouthFLMain"] = 8
	end
	
	
elsif $story_stats["RecQuestSouthFLMain"] == 9
	call_msg("TagMapSouthFL:Qprog9/RaidOnEast_reward")
	$story_stats["RecQuestSouthFLMain"] = 10
	$story_stats["RecQuestSouthFLMainAmt"] = $game_date.dateAmt
	get_character($game_map.get_storypoint("toR")[2]).call_balloon(28,-1) if $story_stats["QuProgSybBarn"] == 0
	get_character(0).call_balloon(8)
	wait(60)
	call_msg("TagMapSouthFL:Qprog8/WaitingAMT_wait")
	optain_exp(9000)
################################################################################################### Lisa Quest
elsif $story_stats["RecQuestSouthFLMain"] == 10 && $game_date.dateAmt > $story_stats["RecQuestSouthFLMainAmt"] && $story_stats["RecQuestLisa"] == 5 && $story_stats["UniqueCharUniqueLisa"] != -1
	call_msg("TagMapSouthFL:Qprog11/LisaLine_0")
	call_msg("TagMapSouthFL:Qprog11/LisaLine_1")
	call_msg("common:Lona/Decide_optB") #no , yes
	if $game_temp.choice == 1
		$story_stats["RecQuestSouthFLMain"] = 11
		call_msg("TagMapSouthFL:Qprog11/LisaLine_accept0")
		call_msg("TagMapSouthFL:Qprog11/LisaLine_accept1")
		call_msg("TagMapSouthFL:Qprog11/LisaLine_accept2")
	else
		call_msg("TagMapSouthFL:Qprog11/LisaLine_No")
	end
################################################################################################### Lisa Quest - arrived
elsif $story_stats["RecQuestLisa"] == 7 && $game_player.record_companion_name_ext == "CompExtUniqueLisa"
	$story_stats["RecQuestLisa"] = 8
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character(0).moveto(tmpLeaderX,tmpLeaderY)
			get_character(0).direction = 2
			get_character($game_player.get_followerID(-1)).moveto(tmpLeaderX-1,tmpLeaderY+1)
			get_character($game_player.get_followerID(-1)).direction = 8
			get_character($game_player.get_followerID(-1)).forced_x = 16
			get_character($game_player.get_followerID(-1)).npc_story_mode(true)
			get_character($game_player.get_followerID(-1)).move_type = 0
			$game_player.moveto(tmpLeaderX,tmpLeaderY+1)
			$game_player.direction = 8
			$game_player.forced_x = 16
		chcg_background_color(0,0,0,255,-7)
		call_msg("CompLisa:Lisa8/Begin1") ; portrait_hide
		get_character(0).call_balloon(20,-1)
		$game_player.call_balloon(6,-1)
		get_character($game_player.get_followerID(-1)).direction = 6
		get_character($game_player.get_followerID(-1)).call_balloon(8)
		wait(50)
		get_character($game_player.get_followerID(-1)).direction = 4
		get_character($game_player.get_followerID(-1)).call_balloon(8)
		wait(50)
		get_character($game_player.get_followerID(-1)).direction = 2
		get_character($game_player.get_followerID(-1)).call_balloon(8)
		wait(50)
		call_msg("CompLisa:Lisa8/Begin2") ; portrait_hide
		optain_lose_item($data_items[130],1) #ItemQuestC130Part
		get_character($game_player.get_followerID(-1)).direction = 2 ; get_character($game_player.get_followerID(-1)).move_forward_force ; wait(30)
		get_character($game_player.get_followerID(-1)).direction = 4 ; get_character($game_player.get_followerID(-1)).move_forward_force ; wait(30)
		get_character($game_player.get_followerID(-1)).direction = 4 ; get_character($game_player.get_followerID(-1)).move_forward_force ; wait(30)
		get_character($game_player.get_followerID(-1)).direction = 4 ; get_character($game_player.get_followerID(-1)).move_forward_force ; wait(30)
		chcg_background_color(0,0,0,0,7)
			get_character($game_player.get_followerID(-1)).npc_story_mode(false)
			get_character($game_player.get_followerID(-1)).forced_x = 0
			get_character($game_player.get_followerID(-1)).direction = 2
			get_character($game_player.get_followerID(-1)).move_type = 3
			get_character($game_player.get_followerID(-1)).moveto(tmpCoX,tmpCoY-2)
			get_character(0).call_balloon(0)
			$game_player.call_balloon(0)
		chcg_background_color(0,0,0,255,-7)
		get_character(0).direction = 2
		call_msg("CompLisa:Lisa8/Begin3") ; portrait_hide
		$game_player.direction = 2
		call_msg("CompLisa:Lisa8/Begin4") ; portrait_hide
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			$game_player.forced_x = 0
			$game_player.direction = 2
			$game_player.moveto(tmpCoX+1,tmpCoY-2)
			$game_player.moveto(tmpCoX+1,tmpCoY-2)
			get_character(0).moveto(tmpCoX-1,tmpCoY-2)
			get_character(0).direction = 2
			set_event_force_page(tmpCoID,3)
			get_character(tmpCoBlkID).delete
		chcg_background_color(0,0,0,255,-7)
		call_msg("CompLisa:Lisa8/Begin5") ; portrait_hide
		get_character(0).direction = 6
		call_msg("CompLisa:Lisa8/Begin6") ; portrait_hide
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			call_msg("CompLisa:Lisa8/Begin7") ; portrait_hide
			#get_character(0).moveto(tmpLeaderX,tmpLeaderY)
			#get_character(0).direction = 2
			#get_character($game_player.get_followerID(-1)).set_this_companion_disband
			get_character(0).delete
		chcg_background_color(0,0,0,255,-7)
		
			$story_stats["HiddenOPT1"] = ($game_player.record_companion_ext_date-$game_date.dateAmt)/2
			call_msg("CompLisa:Lisa8/Begin8_board") ; portrait_hide #before leave
			$story_stats["HiddenOPT1"] = "0"
		optain_exp(7000)
		wait(30)
		optain_item($data_items[20],4) #ItemDryFood
		wait(30)
		optain_morality(1)
		
		#詢問認不認識LISA   假設LISA任務線還沒解
elsif $story_stats["RecQuestSouthFLMain"] == 10 && $story_stats["RecQuestLisa"] < 5
	if [true,false].sample
		call_msg("TagMapSouthFL:Qprog8/WaitingAMT_wait")
	else
		call_msg("TagMapSouthFL:Qprog10/WaitingAMT_noLisa")
	end
	#通用回復  解到一半
elsif $story_stats["RecQuestSouthFLMain"] == 6
	call_msg("TagMapSouthFL:Qprog6/WaitingAMT")
	
	#通用回復  左右孵化池解完
elsif $story_stats["RecQuestSouthFLMain"] >= 9
	call_msg("TagMapSouthFL:Qprog8/WaitingAMT_wait")
	call_msg("TagMapSouthFL:Qprog11/LisaLine_accept2") if $story_stats["RecQuestSouthFLMain"] == 12 && $game_player.record_companion_name_ext == "CompExtUniqueLisa"
else
	
	call_msg("TagMapSouthFL:MainGuard/Begin")
end
eventPlayEnd

#check balloon
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSouthFLMain"] == 2
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSouthFLMain"] == 5
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSouthFLMain"] == 6 && $game_date.dateAmt > $story_stats["RecQuestSouthFLMainAmt"]
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestSouthFLMain"] == 7 && $game_date.dateAmt > $story_stats["RecQuestSouthFLMainAmt"]
#找Lisa
tmpQ1 = $story_stats["RecQuestLisa"] == 5 #解完lisa c130
tmpQ2 = $story_stats["RecQuestSouthFLMain"] == 10 #解完東方巢穴
tmpQ3 = $story_stats["UniqueCharUniqueLisa"] != -1 #Lisa沒死
tmpQ4 = $game_date.dateAmt > $story_stats["RecQuestSouthFLMainAmt"]
return get_character(0).call_balloon(28,-1) if tmpQ1 && tmpQ2 && tmpQ3&& tmpQ4
#Lisa SouthFL Quest
tmpQ2 = $story_stats["RecQuestLisa"] == 7
tmpQ3 = $game_player.record_companion_name_ext == "CompExtUniqueLisa"
tmpQ5 = $story_stats["UniqueCharUniqueLisa"] != -1
return get_character(0).call_balloon(28,-1) if tmpQ2 && tmpQ3 && tmpQ5
