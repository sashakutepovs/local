if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmp_aggro = 0
tmp_pass = 0

$game_player.actor.sta > 0 && $game_player.actor.scoutcraft >=10 && $game_player.actor.stat["SlaveBrand"] ==1 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
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
		call_msg("TagMapFishTown:Gate/NormalEnter")
		tmp_pass = 1
		
	end
when 2 #隱匿進入
			$game_player.actor.sta -= 3
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(200) * ($story_stats["RapeLoop"] +1)
			temp_roll_skill= $game_player.actor.scoutcraft+rand(100)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff #隱匿成功
				call_msg("OvermapNoer:GateGuard/enter_sneak_win")
				tmp_pass = 1
			else #隱匿失敗
				call_msg("TagMapFishTown:GateGuard/enter_sneak_failed") if $game_player.actor.stat["SlaveBrand"] != 1
				optain_morality(-2)
				call_msg("TagMapFishTown:Gate/Enter_slave1") if $game_player.actor.stat["SlaveBrand"] == 1
				tmp_aggro = 1
			end
when 3 #唬爛進入
			
			
			
end # case

if tmp_aggro == 1
		$story_stats["SlaveOwner"] = "FishTownR" if $game_player.actor.stat["SlaveBrand"] != 0
		$story_stats["RapeLoopTorture"] = 1 if $game_player.actor.stat["SlaveBrand"] != 0
		$story_stats["OnRegionMapSpawnRace"] = "FishPPL"
		tmpX = $game_player.x
		tmpY = $game_player.y
		$game_map.reserve_summon_event("DeeponeBowGuard",tmpX+1,tmpY)
		$game_map.reserve_summon_event("DeeponeSpearGuard",tmpX,tmpY+1)
		$game_map.reserve_summon_event("DeeponeSpearGuard",tmpX,tmpY-1)
		call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
		$game_player.actor.add_state("MoralityDown30")
		$game_player.call_balloon(19)
end
eventPlayEnd
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"

change_map_tag_map_exit(true,false) if tmp_pass ==1
