tmpNpcCount = 0
tmpMobAlive = $game_map.npcs.any?{
|event|
	next unless event.summon_data
	next unless event.summon_data[:watcher]
	tmpNpcCount +=1
	next if event.deleted?
	next if event.npc.action_state == :death
	if event.actor.battle_stat.get_stat("health") != event.actor.battle_stat.get_stat("health",2)
		false
	else
		true
	end
}

if tmpNpcCount == 1 && tmpMobAlive
	wis_check=false
	$game_temp.choice = -1
	call_msg("TagMapAbanHouse1:Adam/SupLona0")   #\optD[只是路過,亞當]
	case $game_temp.choice
	when 0 ;call_msg("TagMapAbanHouse1:Adam/SupLona_ans_pass")
	when 1 ;
			$game_temp.choice = -1
			$game_player.actor.wisdom_trait >= 15 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
			$story_stats["RecQuestAdam"] >= 2 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
			call_msg("TagMapAbanHouse1:Adam/SupLona_ans_adam") #optD[唉嘿嘿,美祿,說謊<r=HiddenOPT0>]
			case $game_temp.choice 
			when 0 ; call_msg("TagMapAbanHouse1:Adam/SupLona_ans_hehe")
			when 1 ; call_msg("TagMapAbanHouse1:Adam/SupLona_ans_milo")
			when 2 ; call_msg("TagMapAbanHouse1:Adam/SupLona_ans_lie0")
					wis_check=true
			when 3 ; call_msg("TagMapAbanHouse1:Adam/SupLona_ans_work0")
					just_skip = true
			end
	end
end

if wis_check == true
	$story_stats["RecQuestMilo"] = 6
	call_msg("TagMapAbanHouse1:Adam/SupLona_ans_lie1")
	chcg_background_color(0,0,0,0,7)
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:watcher]
		next if event.deleted?
		event.delete
	}
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
	portrait_off
	call_msg("TagMapAbanHouse1:Adam/SupLona_ans_lie2")
	
elsif just_skip
	$story_stats["RecQuestMilo"] = 6
	call_msg("TagMapAbanHouse1:Adam/SupLona_ans_work1")
	call_msg("TagMapAbanHouse1:Adam/SupLona_ans_lie1")
	chcg_background_color(0,0,0,0,7)
	$game_map.npcs.each{|event|
		next unless event.summon_data
		next unless event.summon_data[:watcher]
		next if event.deleted?
		event.delete
	}
	portrait_hide
	chcg_background_color(0,0,0,255,-7)
	portrait_off
	call_msg("TagMapAbanHouse1:Adam/SupLona_ans_lie2")
	
else
	call_msg("TagMapAbanHouse1:Adam/SupLona_Kill0")
	call_msg("TagMapAbanHouse1:Adam/SupLona_Kill1#{talk_persona}")
end


$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
eventPlayEnd