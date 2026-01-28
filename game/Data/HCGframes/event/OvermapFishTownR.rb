tmp_aggro = 0
tmp_pass = 0
tmp_slave = 0
$game_player.actor.sta > 0 && $game_player.actor.scoutcraft_trait >=10 	? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
$game_player.actor.sta > 0 && $game_player.actor.wisdom_trait >=10 		? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
#choose pass: normal pass or wis pass or sneak pass
call_msg("TagMapFishTown:Gate/Begin0") #[算了,進入,隱匿進入<r=HiddenOPT1>,唬爛進入<r=HiddenOPT2>]
case $game_temp.choice
when 0,-1
when 1 #進入
	if $game_player.actor.stat["SlaveBrand"] == 1
		call_msg("TagMapFishTown:Gate/Enter_slave0")
		call_msg("TagMapFishTown:Gate/Enter_slave1")
		tmp_aggro = 1
		
	else #not slave
		call_msg("TagMapFishTown:Gate/Enter_normal1")
		$game_temp.choice = -1
		call_msg("TagMapFishTown:Gate/Enter_normal2") #[算了,成為奴隸]
		if $game_temp.choice == 1 #becomeSlave
			call_msg("TagMapFishTown:Gate/Enter_SlaveChoose")
			if $game_player.actor.weak > 25
				$game_temp.choice = -1
				$cg.erase
				call_msg("TagMapFishTown:Gate/Enter_SlaveChoose_win") #[算了,好吧]
				tmp_slave = 1 if $game_temp.choice == 1
			else
				call_msg("TagMapFishTown:Gate/Enter_SlaveChoose_lose")
			end
		end
		
	end
when 2 #隱匿進入
			$game_player.actor.sta -= 3
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(100)
			temp_roll_skill= $game_player.actor.scoutcraft+rand(100)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff #隱匿成功
				call_msg("OvermapNoer:GateGuard/enter_sneak_win")
				tmp_pass = 1
			else #隱匿失敗
				if $game_player.actor.morality >=30 && $game_player.actor.stat["SlaveBrand"] == 0  #失敗 扣MOR
					call_msg("TagMapFishTown:GateGuard/enter_failed")
					optain_morality(-2)
				else
					call_msg("TagMapFishTown:GateGuard/enter_sneak_failed")
					optain_morality(-2)
					call_msg("TagMapFishTown:Gate/Enter_slave1") if $game_player.actor.stat["SlaveBrand"] == 1
					tmp_aggro = 1
				end
			end
when 3 #唬爛進入
			$game_player.actor.sta -= 3
			call_msg("TagMapFishTown:Gate/Enter_normal1")
			call_msg("TagMapFishTown:Gate/enter_wisdom")
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(100) * ($story_stats["RapeLoop"] +1)
			temp_roll_skill= $game_player.actor.wisdom+rand(120)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff  #唬爛成功
				call_msg("TagMapFishTown:GateGuard/enter_wisdom_win")
				tmp_pass = 1
			else #唬爛失敗
				if $game_player.actor.morality >=30 && $game_player.actor.stat["SlaveBrand"] == 0  #失敗 扣MOR
					call_msg("TagMapFishTown:GateGuard/enter_failed")
					optain_morality(-1)
				else
					call_msg("TagMapFishTown:GateGuard/enter_sneak_failed")
					optain_morality(-1)
					call_msg("TagMapFishTown:Gate/Enter_slave1") if $game_player.actor.stat["SlaveBrand"] == 1
					tmp_aggro = 1
				end
			end
			
			
			
end# case

if tmp_aggro == 1
#####################3333333 TODO
		call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
		$story_stats["OverMapEvent_saw"] =1
		load_script("Data/HCGframes/encounter/FishPPL.rb")
end
if tmp_slave == 1
	if $game_player.actor.stat["SlaveBrand"] !=1
		$game_player.actor.stat["EventExt1Race"] = "Fishkind"
		$game_player.actor.stat["EventExt1"] ="Grab"
		call_msg("TagMapFishTown:Gate/Enter_SlaveChoose_brand")
		$game_player.actor.mood = -100
		$game_player.actor.add_state("SlaveBrand") #51
		whole_event_end
	end

	$story_stats["SlaveOwner"] = "FishTownR"
	load_script("Data/Batch/Put_BondageItemsON.rb")
	$story_stats["dialog_collar_equiped"] =0
	rape_loop_drop_item(false,false)
	call_msg("TagMapBanditCamp1:Trans/begin2")
	#傳送主角至定點
	$game_player.move_normal
	SndLib.sound_equip_armor(125)
	tmp_pass = 1
end

eventPlayEnd
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
change_map_enter_tag("FishTownR") if tmp_pass ==1
if tmp_slave == 1
	$story_stats["Captured"] = 1
	$story_stats["RapeLoop"] = 1
end
