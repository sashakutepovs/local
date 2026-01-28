

$game_player.actor.scoutcraft >=10		? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
$game_player.actor.wisdom_trait >=10	? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"



portrait_off
call_msg("OvermapNoer:GateGuard/begin1")
if $game_player.actor.stat["RaceRecord"] == "TrueDeepone"
	call_msg("OvermapNoer:GateGuard/LonaIsTrueDeepone")
	return load_script("Data/HCGframes/encounter/NoerGuards.rb")
end
case $game_temp.choice
	when 0 ,-1
			$game_portraits.lprt.hide
			$game_portraits.rprt.hide
	when 1 #通行證
			call_msg("OvermapNoer:GateGuard/enter_wait")
			if $game_player.direction == 2
				if $game_party.has_item_type("NoerPassport")
					if $game_player.actor.morality_lona >=30 && $game_player.actor.stat["SlaveBrand"] == 0 
						call_msg("OvermapNoer:GateGuard/enter_with_passport")
						$game_player.jump_forward(2)
					else
						call_msg("OvermapNoer:GateGuard/enter_LowMorality")
						$story_stats["OverMapEvent_saw"] =1
						load_script("Data/HCGframes/encounter/NoerGuards.rb")
					end
				else #沒票
					if $game_player.actor.morality_lona >=30 && $game_player.actor.stat["SlaveBrand"] == 0 
						call_msg("OvermapNoer:GateGuard/enter_no_passport_dir4")
					else
						call_msg("OvermapNoer:GateGuard/enter_LowMorality")
						call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
						$story_stats["OverMapEvent_saw"] =1
						load_script("Data/HCGframes/encounter/NoerGuards.rb")
					end
				end
			elsif $game_player.direction == 8
				if $game_party.has_item_type("NoerPassport")
					if $game_player.actor.morality_lona >=30 && $game_player.actor.stat["SlaveBrand"] == 0 
						call_msg("OvermapNoer:GateGuard/enter_no_passport_dir6")
						$game_player.jump_forward(2)
					else
						call_msg("OvermapNoer:GateGuard/enter_LowMorality")
						$story_stats["OverMapEvent_saw"] =1
						load_script("Data/HCGframes/encounter/NoerGuards.rb")
					end
				else #沒票
					if $game_player.actor.morality_lona >=30 && $game_player.actor.stat["SlaveBrand"] == 0 
						call_msg("OvermapNoer:GateGuard/enter_no_passport_dir6")
						$game_player.jump_forward(2)
					else
						call_msg("OvermapNoer:GateGuard/enter_LowMorality")
						$story_stats["OverMapEvent_saw"] =1
						load_script("Data/HCGframes/encounter/NoerGuards.rb")
					end
				end
			end
	when 2 #隱匿
			$game_player.actor.sta -= 3
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(100)
			temp_roll_skill= $game_player.actor.scoutcraft+rand(100)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff #隱匿成功
				call_msg("OvermapNoer:GateGuard/enter_sneak_win")
				$game_player.jump_forward(2)
			else #隱匿失敗
				if $game_player.actor.morality_lona >=30 && $game_player.actor.stat["SlaveBrand"] == 0  #失敗 扣MOR
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
	when 3 #唬爛
			$game_player.actor.sta -= 3
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(100)
			temp_roll_skill= $game_player.actor.wisdom+rand(120)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff
				load_script("Data/HCGframes/event/CommonGateKeeperBluffAnswer.rb")
				$game_player.jump_forward(2)
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
end
$story_stats["OnRegionMap_Regid"] = $game_player.region_id
$game_temp.choice =-1
$game_player.actor.update_lonaStat
portrait_hide

$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
