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
tmpWakeUpX,tmpWakeUpY,tmpWakeUpID = $game_map.get_storypoint("WakeUp")
get_character(0).call_balloon(0)
	call_msg("commonNPC:MaleHumanRandomNpc/HoboM_begin1#{npc_talk_style}")
	tmp_Prostitution = $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
	tmp_Begging = $game_player.actor.weak >= 50 && get_character(0).summon_data[:SexTradeble]
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]				,"Cancel"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Barter"]				,"Barter"]
	tmpTarList << [$game_text["commonNPC:commonNPC/Prostitution"]		,"Prostitution"] if tmp_Prostitution
	tmpTarList << [$game_text["commonNPC:commonNPC/Begging"]			,"Begging"] if tmp_Begging
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	$game_temp.choice = -1
				
	case tmpPicked
		when "Barter"
			manual_barters("BanditCamp1CommonPPL")
		when "Prostitution"
		#make store [算了,交易,賣身<r=HiddenOPT1>]
			get_character(0).summon_data[:SexTradeble] = false
			$game_temp.choice == 0
			call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
			call_msg("commonNPC:RandomNpc/choosed")
			$game_player.actor.sta -=1 #WhoreWorkCost
			temp_vs1=0 #性交易難度
			call_msg("\\narr #{$game_player.actor.weak.round} VS #{temp_vs1.round}")
			if $game_player.actor.weak > temp_vs1
				get_character(tmpWakeUpID).switch2_id[2] +=1 if get_character(tmpWakeUpID).switch2_id[2] !=0
				$game_player.actor.mood +=10
				$story_stats["sex_record_whore_job"] +=1
				$game_player.actor.record_lona_title = "WhoreJob/title_hooker" if $story_stats["sex_record_whore_job"] % 10 == 0
				call_msg("commonNPC:RandomNpc/WhoreWork_win")
				prev_gold = $game_party.gold
				play_sex_service_menu(get_character(0),0.25,nil)
				tmpReward = [
					"ItemApple",		"ItemBread",
					"ItemCheese",		"ItemMushroom",
					"ItemSausage",		"ItemGrapes",
					"ItemOrange",		"ItemNuts",
					"ItemOnion",		"ItemPepper",
					"ItemBlueBerry",		"ItemFish",
					"ItemCarrot",		"ItemTomato",
					"ItemCherry",		"ItemPotato",
					"ItemDryFood"
					]
				play_sex_service_items(get_character(0),tmpReward.sample(3),prev_gold)
			else
				$game_player.actor.mood -=3
				call_msg("commonNPC:RandomNpc/WhoreWork_failed")
			end
			
		when "Begging"
			load_script("Data/HCGframes/event/BanditCamp_Begging.rb")
	end
	
tmpMcX,tmpMcY,tmpMcID =  $game_map.get_storypoint("MapCont")
#若性交單位超過4位以上時 將Balloon 28的單位設成 balloon 0
if get_character(tmpMcID).summon_data[:Whore] == true && get_character(tmpWakeUpID).switch2_id[2] >= 5
	get_character($game_map.get_storypoint("WakeUp")[2]).call_balloon(28,-1)
	get_character($game_map.get_storypoint("Door1")[2]).call_balloon(28,-1)
	get_character($game_map.get_storypoint("Door2")[2]).call_balloon(28,-1)
	get_character($game_map.get_storypoint("Door3")[2]).call_balloon(28,-1)
	get_character($game_map.get_storypoint("Out1")[2]).call_balloon(0)
	get_character($game_map.get_storypoint("Out2")[2]).call_balloon(0)
	get_character($game_map.get_storypoint("Out3")[2]).call_balloon(0)
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:customer] && !event.summon_data[:NapFucker]
		next if event.actor.action_state == :death
		next if event.balloon_id != 28
		event.call_balloon(0)
	end
elsif get_character(tmpMcID).summon_data[:Whore] == true
	$game_map.npcs.each do |event|
		next if event.summon_data == nil
		next if !event.summon_data[:customer] && !event.summon_data[:NapFucker]
		next if event.actor.action_state == :death
		event.call_balloon(28,-1)
	end
end

eventPlayEnd
