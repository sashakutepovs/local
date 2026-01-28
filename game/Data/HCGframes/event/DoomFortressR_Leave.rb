if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmp_aggro = 0
tmp_pass = 0

$game_player.actor.sta > 0 && $game_player.actor.scoutcraft >= 10 && $game_player.actor.stat["SlaveBrand"] ==1 	? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
tmpBluff = $game_player.actor.sta > 0 && $game_player.actor.wisdom_trait >=10
tmpBluff ? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
#choose pass: normal pass or wis pass or sneak pass
call_msg("TagMapDoomFortress:GateR/LeaveBegin0") #[算了,進入,隱匿進入<r=HiddenOPT1>,唬爛進入<r=HiddenOPT2>]
case $game_temp.choice
when 0,-1
when 1 #進入
	if $game_player.record_companion_name_back == "UniqueCecily"
		call_msg("TagMapDoomFortress:Gate/Enter_normal1")
		call_msg("CompCecily:Cecily/DoomFortFuckOff")
		call_msg("TagMapDoomFortress:Gate/Enter_Cecily")
		tmp_pass = 1
	
	elsif $game_player.actor.stat["SlaveBrand"] == 1
		call_msg("TagMapDoomFortress:GateR/Leave_slave0")
		$cg.erase
		SndLib.sound_punch_hit(100)
		lona_mood "p5crit_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.force_stun("Stun1")
		call_msg("TagMapDoomFortress:GateR/Leave_slave1")
	
	else #not slave
		call_msg("TagMapDoomFortress:GateR/Leave_passed")
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
				if $game_player.actor.morality >=30 && $game_player.actor.stat["SlaveBrand"] == 0  #失敗 扣MOR
					call_msg("OvermapNoer:GateGuard/enter_failed")
					optain_morality(-2)
				else
					call_msg("OvermapNoer:GateGuard/enter_sneak_failed")
					optain_morality(-2)
					tmp_aggro = 1
				end
			end
when 3 #唬爛進入
			call_msg("TagMapDoomArmory:thisMap/OvermapEnter_WISenter")
			$game_player.actor.sta -= 3
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(100)
			temp_roll_skill= $game_player.actor.wisdom+rand(120)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff
				load_script("Data/HCGframes/event/CommonGateKeeperBluffAnswer.rb")
				tmp_pass = 1
			else #隱匿失敗
				call_msg("OvermapNoer:GateGuard/enter_sneak_failed")
				optain_morality(-2)
				tmp_aggro = 1
			end

end # case

if tmp_aggro ==1
		$story_stats["SlaveOwner"] = "DoomFortressR" if $game_player.actor.stat["SlaveBrand"] != 0
		$story_stats["RapeLoopTorture"] =1 if $game_player.actor.stat["SlaveBrand"] != 0
		$story_stats["OnRegionMapSpawnRace"] = "HumanGuard"
		tmpX = $game_player.x
		tmpY = $game_player.y
		$game_map.reserve_summon_event("RandomHuman",tmpX+1,tmpY)
		$game_map.reserve_summon_event("RandomHuman",tmpX,tmpY+1)
		$game_map.reserve_summon_event("RandomHuman",tmpX,tmpY-1)
		call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
		$game_player.actor.add_state("MoralityDown30")
		$game_player.call_balloon(19)
end

$cg.erase
cam_center(0)
portrait_hide
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$game_temp.choice = -1

change_map_tag_sub("DoomFortressL","StartPoint2",4,false,true) if tmp_pass ==1
