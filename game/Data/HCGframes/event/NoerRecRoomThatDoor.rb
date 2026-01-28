if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end


SndLib.sys_DoorLock
ntrID=$game_map.get_storypoint("NTR")[2]
tmpHmX,tmpHmY,tmpHmID=$game_map.get_storypoint("HappyMerchant")
tmpTeX,tmpTeY,tmpTeID=$game_map.get_storypoint("teller")
tmpSAKAID=$game_map.get_storypoint("TellerSaka")[2]

if $story_stats["UniqueCharUniqueGangBoss"] != -1
	if $game_date.day? && get_character(0).switch1_id <5 && get_character(0).switch2_id == 0 && $story_stats["UniqueCharUniqueTeller"] != -1
		get_character(0).switch1_id +=1
		call_msg_popup("TagMapNoerRecRoom:DatDoor/NTR#{rand(5)}",ntrID)
		SndLib.sound_QuickDialog
	elsif $game_date.day? && get_character(0).switch1_id >=5 && get_character(0).switch2_id == 0 && $story_stats["UniqueCharUniqueTeller"] != -1
		get_character(0).switch2_id = 1
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			if $story_stats["RecQuestTellerThatDoorSucka"] == 0
				set_event_force_page(tmpSAKAID,1)
				$story_stats["RecQuestTellerThatDoorSucka"] = 1
				$game_map.get_storypoint("TellerSaka")
				call_StoryHevent("RecHevTellerSakaGBoss","HevTellerSakaGBoss")
			end
			call_msg("TagMapNoerRecRoom:DatDoor/NTR_end")
			get_character(ntrID).delete
			if $story_stats["UniqueCharUniqueHappyMerchant"] != -1 && !get_character(tmpHmID).deleted? && get_character(tmpHmID).x == tmpHmX && get_character(tmpHmID).y == tmpHmY
				get_character(tmpTeID).moveto(tmpTeX,tmpTeY)
			else
				get_character(tmpTeID).moveto(tmpHmX,tmpHmY)
			end
			portrait_hide
		chcg_background_color(0,0,0,255,-7)
		$game_portraits.setRprt("nil")
		$game_portraits.setLprt("nil")
	else
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
	end
else
	if $game_date.day? && get_character(0).switch1_id <5 && get_character(0).switch2_id == 0 && $story_stats["UniqueCharUniqueTeller"] != -1
		get_character(0).switch1_id +=1
		call_msg_popup("TagMapNoerRecRoom:DatDoor/NTR#{rand(5)}",ntrID)
		SndLib.sound_QuickDialog
	elsif $game_date.day? && get_character(0).switch1_id >=5 && get_character(0).switch2_id == 0 && $story_stats["UniqueCharUniqueTeller"] != -1
		get_character(0).switch2_id = 1
		portrait_hide
		chcg_background_color(0,0,0,0,7)
			portrait_off
			get_character(ntrID).delete
			if $story_stats["UniqueCharUniqueHappyMerchant"] != -1 && !get_character(tmpHmID).deleted? && get_character(tmpHmID).x == tmpHmX && get_character(tmpHmID).y == tmpHmY
				get_character(tmpTeID).moveto(tmpTeX,tmpTeY)
			else
				get_character(tmpTeID).moveto(tmpHmX,tmpHmY)
			end
		get_character(tmpTeID).moveto(tmpHmX,tmpHmY)
		chcg_background_color(0,0,0,255,-7)
	else
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
	end
end

			

eventPlayEnd