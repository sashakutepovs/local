if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

if [0,1].include?($story_stats["RecQuestSeaWitch"])
	$story_stats["RecQuestSeaWitch"] = 2
	call_msg("CompSeaWitch:1to2/begin0")
	
elsif $story_stats["RecQuestSeaWitch"] == 2
	$story_stats["RecQuestSeaWitch"] = 3
	call_msg("CompSeaWitch:2to3/begin0")
	get_character(0).call_balloon(8,-1)
	
elsif $story_stats["RecQuestSeaWitch"] == 3
	tmpFetishMan = $game_player.record_companion_name_ext == "FishTownInnCompExtConvoy"
	tmpSemen	 = $game_party.item_PotData_HowMany("Semen") >= 10
	tmpProtein	 = $game_party.item_PotData_HowMany("SemenProtein") >= 5
	tmpFetishMan			 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	tmpSemen || tmpProtein && !tmpFetishMan	 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
	$game_temp.choice = -1
	call_msg("CompSeaWitch:3to4/begin_opt") #[算了,男人<r=HiddenOPT0>,精液<r=HiddenOPT1>,食物]
	case $game_temp.choice
		when 1
			tmpExtID=$game_player.get_followerID(-1)
			if tmpExtID
				tmpRang = get_character(0).report_range(get_character(tmpExtID))
				if tmpRang <= 5
					portrait_hide
					chcg_background_color(0,0,0,0,7)
						$story_stats["RecQuestSeaWitcKilledFurry"] = 1
						portrait_off
						get_character(0).npc_story_mode(true)
						get_character(tmpExtID).npc_story_mode(true)
						get_character(tmpExtID).move_type = 0
						get_character(tmpExtID).moveto(get_character(0).x,get_character(0).y+1)
						get_character(tmpExtID).direction = 8
						$game_player.moveto(get_character(0).x+1,get_character(0).y+1)
						$game_player.direction = 8
					chcg_background_color(0,0,0,255,-7)
					call_msg("CompSeaWitch:3to4/ManSucker_win0")
					$game_player.direction = 4
					get_character(tmpExtID).direction = 6
					call_msg("CompSeaWitch:3to4/ManSucker_win1")
					get_character(tmpExtID).animation = get_character(tmpExtID).animation_peeing
					call_msg("CompSeaWitch:3to4/ManSucker_win2")
					get_character(tmpExtID).animation = get_character(tmpExtID).animation_atk_sh
					optain_item("ItemCoin2", 2)
					call_msg("CompSeaWitch:3to4/ManSucker_win3")
					get_character(0).animation = nil
					get_character(0).direction = 2
					get_character(0).call_balloon(8)
					wait(40)
					get_character(0).animation = get_character(0).animation_grabber_qte(get_character(tmpExtID))
					get_character(tmpExtID).animation = get_character(tmpExtID).animation_grabbed_qte
					call_msg("CompSeaWitch:3to4/ManSucker_win4")
					SndLib.sound_chs_buchu
					get_character(tmpExtID).moveto(get_character(0).x,get_character(0).y)
					npc_sex_service_main(get_character(tmpExtID),get_character(0),"vag",1,0)
					call_msg("CompSeaWitch:3to4/ManSucker_win5")
					$game_player.direction = 8
					call_msg("CompSeaWitch:3to4/ManSucker_win6")
					cam_follow(tmpExtID,0)
					portrait_hide
					wait(4)
					portrait_off
					$game_player.direction = 2
					10.times{
						SndLib.sound_chs_buchu
						wait(30)
					}
					SndLib.sound_MaleWarriorDed
					call_msg("CompSeaWitch:3to4/ManSucker_win7")
					3.times{
						$game_map.reserve_summon_event("EfxSpeamHit",get_character(tmpExtID).x,get_character(tmpExtID).y,-1)
						$game_map.reserve_summon_event("WasteSemenHuman",get_character(tmpExtID).x-1+rand(3),get_character(tmpExtID).y-1+rand(3))
						wait(40)
						SndLib.sound_MaleWarriorDed
					}
					get_character(0).npc_story_mode(false)
					get_character(tmpExtID).npc_story_mode(false)
					call_msg("CompSeaWitch:3to4/ManSucker_win8")
					get_character(0).npc_story_mode(true)
					get_character(tmpExtID).npc_story_mode(true)
					call_msg("CompSeaWitch:3to4/ManSucker_win9")
					npc_sex_service_main(get_character(tmpExtID),get_character(0),"vag",4,1)
					call_msg("CompSeaWitch:3to4/ManSucker_win10")
					20.times{
						SndLib.sound_chs_buchu
						wait(15)
					}
					SndLib.sound_MaleWarriorDed
					call_msg("CompSeaWitch:3to4/ManSucker_win11")
					3.times{
						$game_map.reserve_summon_event("EfxSpeamHit",get_character(tmpExtID).x,get_character(tmpExtID).y,-1)
						$game_map.reserve_summon_event("WasteSemenHuman",get_character(tmpExtID).x-1+rand(3),get_character(tmpExtID).y-1+rand(3))
						wait(40)
						SndLib.sound_MaleWarriorDed
					}
					#npc_sex_service_main(get_character(tmpExtID),get_character(0),"vag",0,2)
					chcg_background_color(0,0,0,0,7)
						call_msg("CompSeaWitch:3to4/ManSucker_win12")
						call_StoryHevent("RecHevSeaWitchReverseRape","HevSeaWitchReverseRape")
						chcg_background_color(0,0,0,255)
						get_character(0).unset_event_chs_sex
						get_character(0).npc_story_mode(false)
						get_character(tmpExtID).unset_event_chs_sex
						get_character(tmpExtID).npc_story_mode(false,true)
						3.times{
							$game_map.reserve_summon_event("EfxSpeamHit",get_character(tmpExtID).x,get_character(tmpExtID).y,-1)
							$game_map.reserve_summon_event("WasteSemenHuman",get_character(tmpExtID).x-1+rand(3),get_character(tmpExtID).y-1+rand(3))
							wait(40)
							SndLib.sound_MaleWarriorDed
						}

						get_character(tmpExtID).moveto(get_character(tmpExtID).x-1,get_character(tmpExtID).y+1)
						get_character(tmpExtID).setup_dead_event(0)
						$game_player.record_companion_name_ext = nil
						$game_player.record_companion_ext_date= nil
						get_character(tmpExtID).forced_x = 12
						get_character(tmpExtID).forced_y = -12
						get_character(tmpExtID).mirror = false
						wait(120)
					chcg_background_color(0,0,0,255,-7)
					call_msg("CompSeaWitch:3to4/ManSucker_win12_1")
					$game_player.direction = 8
					call_msg("CompSeaWitch:3to4/ManSucker_win13")
					tmpQuestDone = true
					#EvLib.sum("EffectOverKill",get_character(tmpExtID).x,get_character(tmpExtID).y)
				else
					call_msg("CompSeaWitch:3to4/ManSucker_closer")
				end
			end
		when 2
			tmpTotalSemen = 0
			tmpTotalProtein = 0
			SceneManager.goto(Scene_ItemStorage)
			SceneManager.scene.prepare(System_Settings::STORAGE_TEMP)
			call_msg("CompSeaWitch:3to4/ItemTransfer")
			tmpTotalSemen = $game_boxes.itemPotDataOnBoxNum?(System_Settings::STORAGE_TEMP,"Semen")
			tmpTotalProtein = $game_boxes.itemPotDataOnBoxNum?(System_Settings::STORAGE_TEMP,"SemenProtein")
			$game_boxes.box(System_Settings::STORAGE_TEMP).clear
			 if tmpTotalSemen >= 10 || tmpTotalProtein >= 5
				tmpQuestDone = true
				$game_player.animation = $game_player.animation_atk_sh
				SndLib.sound_equip_armor
				wait(30)
				SndLib.sound_eat
				wait(30)
				SndLib.sound_eat
				wait(30)
				SndLib.sound_eat
				call_msg("CompSeaWitch:3to4/ItemTransfer_Win")
				optain_exp(7500)
				wait(30)
			else
				$game_player.animation = $game_player.animation_atk_sh
				SndLib.sound_equip_armor
				wait(30)
				SndLib.sound_eat
				call_msg("CompSeaWitch:3to4/ItemTransfer_Failed")
			end
		when 3
			call_msg("CompSeaWitch:3to4/begin_other0")
			call_msg("CompSeaWitch:3to4/begin_other1")
		else
			tmpQ0 = $game_party.item_PotData_HowMany("Semen") >= 10
			tmpQ1 = $game_party.item_PotData_HowMany("SemenProtein") >= 5
			tmpQ2 = $story_stats["RecQuestSeaWitch"] == 3
			tmpQ3 = $game_player.record_companion_name_ext == "FishTownInnCompExtConvoy"
			tmpQ4 = $story_stats["UniqueCharUniqueSeaWitch"] != -1
			get_character(0).call_balloon(28,-1)if tmpQ2 && tmpQ4 && (tmpQ0||tmpQ1|| tmpQ3)
	end
	if tmpQuestDone
		$story_stats["RecQuestSeaWitch"] = 4
		get_character(0).animation = nil
		get_character(0).set_npc("UniqueSeaWitch")
		get_character(0).balloon_XYfix = 0
		call_msg("CompSeaWitch:3to4/Done0")
		GabeSDK.getAchievement("RecQuestSeaWitch_4")
		optain_exp(15000)
	end
elsif $story_stats["RecQuestSeaWitch"] == 4
		load_script("Data/HCGframes/event/CompSeaWitchCheckUniqueDialog.rb")
		$game_temp.choice = -2
		$story_stats["RecQuestDedOne"] == 5 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		tmpDeeponeSkillLearn = $game_player.actor.skill_learn?($data_SkillsName["BasicDeepone"]) #65
		tmpDeeponeRace = ["PreDeepone","TrueDeepone"].include?($game_player.actor.stat["RaceRecord"])
		!tmpDeeponeSkillLearn && tmpDeeponeRace ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		#call_msg("CompSeaWitch:4to5/Question_beginNormal")
		until [-1,0,3].include?($game_temp.choice)
			if tmpDeeponeRace
				call_msg("CompSeaWitch:4to5/Question_beginDeepone")
			else
				call_msg("CompSeaWitch:4to5/Question_beginNormal")
			end
			call_msg("CompSeaWitch:4to5/Question") #[沒事,關於妳,假海巫,有人找妳<r=HiddenOPT0>,妳的孩子<r=HiddenOPT1>]
			case $game_temp.choice
				when 1
					call_msg("CompSeaWitch:4to5/Question_AboutU")
				when 2
					call_msg("CompSeaWitch:4to5/Question_AboutFake")
				when 3
					tmpDoX,tmpDoY,tmpDoID=$game_map.get_storypoint("DedOne")
					tmpSwX,tmpSwY,tmpSwID=$game_map.get_storypoint("SeaWitch")
					$story_stats["RecQuestSeaWitch"] = 5
					call_msg("CompSeaWitch:4to5/Question_Some1Look0")
					#set_event_force_page(tmpDoID,1)
					get_character(tmpDoID).npc_story_mode(true)
					get_character(0).npc_story_mode(true)
					get_character(tmpDoID).moveto(tmpSwX,tmpSwY-10)
					call_msg("CompSeaWitch:4to5/Question_Some1Look1")
					get_character(0).jump_to(tmpSwX,tmpSwY)
					get_character(0).direction = 2
					$game_player.jump_to(tmpSwX+1,tmpSwY)
					$game_player.direction = 2
					get_character(tmpDoID).jump_to(tmpSwX,tmpSwY+4)
					get_character(tmpDoID).direction = 8
					wait(30)
					$game_player.call_balloon(1)
					get_character(0).call_balloon(1)
					call_msg("CompSeaWitch:4to5/Question_Some1Look2")
					get_character(tmpDoID).move_forward
					wait(40)
					$game_player.jump_to(tmpSwX,tmpSwY+1)
					SndLib.sound_equip_armor
					wait(10)
					$game_player.direction = 2
					$game_player.animation = $game_player.animation_hold_mh
					call_msg("CompSeaWitch:4to5/Question_Some1Look3")
					get_character(tmpDoID).animation =  get_character(tmpDoID).animation_atk_mh
					SndLib.buff_life
					$game_player.zoom_x = 0.8
					$game_player.zoom_y = 0.8
					wait(5)
					$game_player.zoom_x = 0.6
					$game_player.zoom_y = 0.6
					wait(5)
					$game_player.zoom_x = 0.4
					$game_player.zoom_y = 0.4
					wait(5)
					$game_player.zoom_x = 0.2
					$game_player.zoom_y = 0.2
					wait(5)
					$game_player.transparent = true
					wait(20)
					get_character(tmpDoID).move_forward
					wait(40)
					call_msg("CompSeaWitch:4to5/Question_Some1Look4")
					get_character(tmpDoID).animation =  get_character(tmpDoID).animation_atk_mh
					SndLib.buff_life
					$game_player.transparent = false
					wait(5)
					$game_player.zoom_x = 0.4
					$game_player.zoom_y = 0.4
					wait(5)
					$game_player.zoom_x = 0.6
					$game_player.zoom_y = 0.6
					wait(5)
					$game_player.zoom_x = 0.8
					$game_player.zoom_y = 0.8
					wait(5)
					$game_player.zoom_x = 1
					$game_player.zoom_y = 1
					call_msg("CompSeaWitch:4to5/Question_Some1Look5")
					get_character(tmpDoID).animation =  get_character(tmpDoID).animation_atk_sh
					wait(10)
					optain_exp(12000)
					wait(30)
					optain_item("ItemShTalkie",1) #ItemShTalkie
					wait(30)
					$game_player.animation = nil
					call_msg("CompSeaWitch:4to5/Question_Some1Look6")
					portrait_hide
					chcg_background_color(0,0,0,0,7)
						portrait_off
						$game_player.transparent = false
						$game_player.zoom_x = 1
						$game_player.zoom_y = 1
						get_character(0).npc_story_mode(false)
						get_character(tmpDoID).npc_story_mode(false)
						get_character(0).delete
						get_character(tmpDoID).erase
					chcg_background_color(0,0,0,255,-7)
					call_msg("CompSeaWitch:4to5/Question_Some1Look7")
					GabeSDK.getAchievement("RecQuestSeaWitch_5")
				when 4 #妳的孩子
					tmpDoDeeponeAwaken = true
					break
			end
		end
else
		load_script("Data/HCGframes/event/CompSeaWitchCheckUniqueDialog.rb")
		$game_temp.choice = -2
		$story_stats["HiddenOPT0"] = "0"
		tmpDeeponeSkillLearn = $game_player.actor.skill_learn?($data_SkillsName["BasicDeepone"]) #65
		tmpDeeponeRace = ["PreDeepone","TrueDeepone"].include?($game_player.actor.stat["RaceRecord"])
		!tmpDeeponeSkillLearn && tmpDeeponeRace ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		until [-1,0,3].include?($game_temp.choice)
			if tmpDeeponeRace
				call_msg("CompSeaWitch:4to5/Question_beginDeepone")
			else
				call_msg("CompSeaWitch:4to5/Question_beginNormal")
			end
			call_msg("CompSeaWitch:4to5/Question") #[沒事,關於妳,假海巫,有人找妳<r=HiddenOPT0>,妳的孩子<r=HiddenOPT1>]
			case $game_temp.choice
				when 1
					call_msg("CompSeaWitch:4to5/Question_AboutU")
				when 2
					call_msg("CompSeaWitch:4to5/Question_AboutFake")
				when 4 #妳的孩子
					tmpDoDeeponeAwaken = true
					break
			end
		end
end

if tmpDoDeeponeAwaken
	call_msg("CompSeaWitch:4to5/Question_BloodLine0")
	get_character(0).npc_story_mode(true)
		portrait_hide
		get_character(0).animation = get_character(0).animation_hold_casting_sh
		SndLib.sound_FlameCast(80)
		wait(60)
		SndLib.sound_FlameCast(80)
		wait(60)
		EvLib.sum("EffectLifeBuffRev",$game_player.x,$game_player.y)
		SndLib.buff_life(80)
		get_character(0).animation = get_character(0).animation_casting_mh
		wait(60)
		$game_player.call_balloon(8)
		wait(60)
	get_character(0).npc_story_mode(false)
	call_msg("CompSeaWitch:4to5/Question_BloodLine1")
	$game_player.actor.learn_skill("BasicDeepone") #65
end

$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
eventPlayEnd


return get_character(0).call_balloon(28,-1) if [0,1,2].include?($story_stats["RecQuestSeaWitch"])
tmpQ0 = $game_party.item_PotData_HowMany("Semen") >= 10
tmpQ1 = $game_party.item_PotData_HowMany("SemenProtein") >= 5
tmpQ2 = $story_stats["RecQuestSeaWitch"] == 3
tmpQ3 = get_character(0).balloon_id != 2
return get_character(0).call_balloon(28,-1) if tmpQ2 && tmpQ3 && (tmpQ0 || tmpQ1)
return get_character(0).call_balloon(28,-1) if $story_stats["RecQuestDedOne"] == 5
