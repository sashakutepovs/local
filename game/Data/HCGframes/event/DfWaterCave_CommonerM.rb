if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpDualBiosID = $game_map.get_storypoint("DualBios")[2]
if $story_stats["Captured"] == 1 && get_character(tmpDualBiosID).summon_data[:BeginRaped] == true && get_character(0).summon_data[:NeedSex] == true
	get_character(0).animation = nil
	$game_player.animation = $game_player.animation_prayer
	get_character(0).summon_data[:SexActionRoll] = rand(4) if [nil,-1].include?(get_character(0).summon_data[:SexActionRoll])
	get_character(0).summon_data[:SexActionRoll] = 0 if $story_stats["Setup_UrineEffect"] == 0 && get_character(0).summon_data[:SexActionRoll] == 2
	#0 隨意的幹
	#1 舔雞雞
	#2 喝尿 #若關閉尿尿則轉0 
	#3 深喉
	call_msg("TagMapDfWaterCave:Mcommoner/RapeLoopPick_begin")
	call_msg("TagMapDfWaterCave:Mcommoner/RapeLoopPick_#{get_character(0).summon_data[:SexActionRoll]}")
	call_msg("TagMapDfWaterCave:actionRapeLoop/commoner_opt") #[算了,奉獻]
	$game_player.animation = nil
	if $game_temp.choice == 1
		call_msg("TagMapDfWaterCave:Mcommoner/RapeLoopPick_Start")
		$game_portraits.setLprt("nil")
		chcg_decider_basic_mouth(4)
		case get_character(0).summon_data[:SexActionRoll]
			when 0 #隨意的幹
				whole_event_end
				play_sex_service_menu(ev_target=get_character(0),plus=-1,sex_point=nil,tmp_auto=true,fetishLVL=rand(5),forceCumIn=true,noRefuse=true,noCumInOPT=true)
			when 1 #舔雞雞
				whole_event_end
				$game_player.actor.stat["EventMouthRace"] = "Human"
				load_script("Data/HCGframes/event/DfWaterCave_SuckDickCommoner.rb")
			when 2 #喝尿
				whole_event_end
				$game_player.actor.stat["EventMouthRace"] = "Human"
				load_script("Data/HCGframes/UniqueEvent_PeeonHeadNoOPT.rb")
			when 3 #深喉
				whole_event_end
				$game_player.actor.stat["EventMouthRace"] = "Human"
				load_script("Data/HCGframes/UniqueEvent_DeepThroat.rb")
		end
		whole_event_end
		call_msg("TagMapDfWaterCave:Mcommoner/RapeLoopPick_END")
		get_character(tmpDualBiosID).summon_data[:RapeLoopDoNothingAggroLevel] = 0
		get_character(0).summon_data[:NeedSex] = false
	end
	#######################################################若單位小於5 則任務結束
	tmpHowMany = 0
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:Heretic]
		next unless event.summon_data[:NeedSex] == true
		next if event.deleted?
		next if event.npc.action_state == :death
		next unless event.npc.sex == 1
		tmpHowMany += 1
		event.npc.fucker_condition={"sex"=>[65535, "="]}
		event.call_balloon(19,-1)
	}
	if tmpHowMany <= 5
		$game_map.npcs.each{|event|
			next unless event.summon_data
			next unless event.summon_data[:Heretic]
			next unless event.summon_data[:NeedSex] == true
			next if event.deleted?
			next if event.npc.action_state == :death
			next unless event.npc.sex == 1
			event.summon_data[:NeedSex] = false
			event.call_balloon(0)
		}
		get_character(tmpDualBiosID).summon_data[:SexWithSomeOne] = true
	end
else
	SndLib.sound_QuickDialog
	call_msg_popup("TagMapDfWaterCave:Mcommoner/Qmsg#{rand(3)}",get_character(0).id)
end
eventPlayEnd
