

$game_player.actor.scoutcraft >=8			? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
$game_player.actor.wisdom_trait >=20		? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
$game_player.actor.stat["Prostitute"] == 1	? $story_stats["HiddenOPT3"] = "1" : $story_stats["HiddenOPT3"] = "0"

portrait_off
call_msg("TagMapDoomArmory:thisMap/OvermapEnter") #[沒事,進入,隱匿進入<r=HiddenOPT1>,唬爛進入<r=HiddenOPT2>,妓女<r=HiddenOPT3>]
if $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	call_msg("OvermapNoer:GateGuard/LonaIsTrueDeepone")
	return load_script("Data/HCGframes/encounter/NoerGuards.rb")
end
case $game_temp.choice 
when 1 #normal
	if $game_player.actor.weak < 25 && $story_stats["RecQuestAdam"] == 4 && $game_party.has_item?($data_items[117])
		call_msg("TagMapDoomArmory:thisMap/OvermapEnter_SGTenter")
		call_msg("TagMapDoomArmory:thisMap/OvermapEnter_SGTenter_pass")
		tmpEnter1f = true
	elsif  $game_player.actor.weak >=25 && $story_stats["RecQuestAdam"] == 4 && $game_party.has_item?($data_items[117])
		call_msg("TagMapDoomArmory:thisMap/OvermapEnter_SGTenter")
		call_msg("TagMapDoomArmory:thisMap/OvermapEnter_SGTenter_weak")
	else
		call_msg("TagMapDoomArmory:thisMap/OvermapEnter_enter")
	end

when 2 #隱匿進入
	call_msg("TagMapDoomArmory:thisMap/OvermapEnter_SNEAKenter")
	$game_player.actor.sta -= 3
	call_msg("OvermapNoer:GateGuard/enter_wait")
	temp_roll_diff=rand(100)
	temp_roll_skill= $game_player.actor.scoutcraft+rand(100)
	call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
	if temp_roll_skill >= temp_roll_diff #隱匿成功
		call_msg("OvermapNoer:GateGuard/enter_sneak_win")
		tmpEnter2f = true
	else #隱匿失敗
		if $game_player.actor.morality_lona >=30 && $game_player.actor.stat["SlaveBrand"] == 0  #失敗 扣MOR
			call_msg("TagMapDoomArmory:thisMap/OvermapEnter_SNEAKenter_failed")
			call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
			call_msg("OvermapNoer:GateGuard/enter_failed")
			optain_morality(-2)
		else
			call_msg("OvermapNoer:GateGuard/enter_sneak_failed")
			call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
			optain_morality(-2)
				$story_stats["OverMapEvent_saw"] =1
				load_script("Data/HCGframes/encounter/NoerGuards.rb")
		end
	end
	
when 3 #唬爛進入
			call_msg("TagMapDoomArmory:thisMap/OvermapEnter_WISenter")
			$game_player.actor.sta -= 3
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(100) * ($story_stats["RapeLoop"] +1)
			temp_roll_skill= $game_player.actor.wisdom+rand(120)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff
				load_script("Data/HCGframes/event/CommonGateKeeperBluffAnswer.rb")
				tmpEnter1f = true
			else #隱匿失敗
				if $game_player.actor.morality_lona >=30 && $game_player.actor.stat["SlaveBrand"] == 0  #失敗 扣MOR
					call_msg("OvermapNoer:GateGuard/enter_failed")
					optain_morality(-1)
				else
					call_msg("OvermapNoer:GateGuard/enter_sneak_failed")
					optain_morality(-1)
						$story_stats["OverMapEvent_saw"] =1
						load_script("Data/HCGframes/encounter/NoerGuards.rb")
				end
			end
			
when 4 #妓女
	$game_temp.choice == 0
	call_msg("TagMapDoomArmory:thisMap/OvermapEnter_WISenter")
	call_msg("commonNPC:RandomNpc/WhoreWork#{talk_style}")
	call_msg("commonNPC:RandomNpc/choosed")
	$game_player.actor.sta -=3 #WhoreWorkCost
	temp_vs1=20+rand(20) #校交易難度
	if $game_player.actor.sexy > temp_vs1
	$game_player.actor.mood +=10
	call_msg("TagMapDoomArmory:thisMap/OvermapEnter_WhoreEnter_win")
	tmpEnter1f = true
	else
	$game_player.actor.mood -=3
	call_msg("TagMapDoomArmory:thisMap/OvermapEnter_WhoreEnter_failed")
	end

end

$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT3"] = "0"
$cg.erase
portrait_hide
$game_temp.choice = -1

if tmpEnter1f
	$story_stats["TagSubTrans"] = "StartPoint"
	$story_stats["TagSubForceDir"] = 8
	change_map_enter_tag("DoomArmory")
elsif tmpEnter2f
	$story_stats["TagSubTrans"] = "StartPoint2"
	$story_stats["TagSubForceDir"] = 2
	change_map_enter_tag("DoomArmory")
end

