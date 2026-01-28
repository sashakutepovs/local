p "Playing HCGframe : NoerDockFishTrader.rb"
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
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT1"] = "1" if $game_player.actor.stat["Prostitute"] ==1 && get_character(0).summon_data[:SexTradeble]
call_msg("TagMapNoerDock:FrogmanTrader/begin") #\optB[離他遠點,交易]

case $game_temp.choice
	when 0,-1;	
	when 1;
		if $game_temp.choice == 1
			manual_barters("NoerDockFishTrader")
		end
	when 2
		if $game_temp.choice == 2 && get_character(0).summon_data[:SexTradeble]
			get_character(0).summon_data[:SexTradeble] = false
			$game_temp.choice == 0
			call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
			call_msg("commonNPC:RandomNpc/choosed")
			$game_player.actor.sta -=1 #WhoreWorkCost
			#fishkind rule
			temp_vs1=rand(100)
			temp_fishkind_vs2= $game_player.actor.weak + (100*(($game_player.actor.state_preg_rate-10) + $game_player.actor.get_preg_rate_on_date($game_player.actor.currentDay))) #魚類特化性交易難度
			#no m
			if temp_fishkind_vs2 > temp_vs1
				$game_player.actor.mood +=10
				$story_stats["sex_record_whore_job"] +=1
				$game_player.actor.record_lona_title = "WhoreJob/title_hooker" if $story_stats["sex_record_whore_job"] % 10 == 0
				call_msg("TagMapNoerDock:FrogmanTrader/begin_WhoreWorkWin")
				call_msg("commonNPC:RandomNpc/WhoreWork_win")
				prev_gold = $game_party.gold
				play_sex_service_menu(get_character(0),0.6,"closest",false,fetishLVL=3)
				tmpReward = ["ItemFish"]
				tmpReward << "ItemCoin2" if $game_player.actor.stat["SlaveBrand"] != 1
				play_sex_service_items(get_character(0),tmpReward,prev_gold)
			else
				$game_player.actor.mood -=3
				call_msg("TagMapNoerDock:FrogmanTrader/begin_WhoreWorkFail")
				call_msg("commonNPC:RandomNpc/WhoreWork_failed")
			end
		end
	end
	
eventPlayEnd
$story_stats["HiddenOPT1"] = "0" 

