if $game_map.threat && $story_stats["Setup_Hardcore"] >= 1
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmp_aggro = 0
tmp_pass = 0
tmpSneak = $game_player.actor.sta > 0 && $game_player.actor.scoutcraft_trait >=10 && ($game_player.actor.stat["SlaveBrand"] ==1 || $game_player.player_slave? || $game_player.actor.morality < 1)
tmpBluff = $game_player.actor.sta > 0 && $game_player.actor.wisdom_trait >=10
tmpSneak ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
tmpBluff ? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
call_msg("TagMapNorthFL:Exit/Begin") #[算了,進入,隱匿進入<r=HiddenOPT1>,唬爛進入<r=HiddenOPT2>]
case $game_temp.choice
when 0,-1
when 1 #進入
	if $game_player.actor.stat["SlaveBrand"] == 1 || $game_player.player_slave? || $game_player.actor.morality < 1
		call_msg("TagMapNoerArena:Guard/NapSlave1IsSlave")
		tmp_aggro = 1
		
	else #not slave
		call_msg("TagMapDoomFortress:GateR/Leave_passed")
		tmp_pass = 1
	end
when 2 #隱匿進入
			$game_player.actor.sta -= 3
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(200)
			temp_roll_skill= $game_player.actor.scoutcraft+rand(100)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff #隱匿成功
				call_msg("OvermapNoer:GateGuard/enter_sneak_win")
				tmp_pass = 1
			else #隱匿失敗
				call_msg("TagMapNoerArena:1fExit/SneakFailed")
				optain_morality(-2)
				tmp_aggro = 1
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
				tmp_pass = 1
			else #隱匿失敗
				call_msg("OvermapNoer:GateGuard/enter_sneak_failed")
				optain_morality(-2)
				tmp_aggro = 1
			end
			
end # case

if tmp_aggro ==1
	call_msg("OvermapNoer:GateGuard/enter_failed#{talk_persona}")
	SndLib.sound_punch_hit(100)
	lona_mood "p5crit_damage"
	$game_player.actor.portrait.shake
	$game_player.actor.force_stun("Stun1")
	$game_player.jump_to($game_player.x,$game_player.y-1)
	$story_stats["SlaveOwner"] = "NorthFL_INN"
	$story_stats["RapeLoopTorture"] = 1
	tmpX = $game_player.x
	tmpY = $game_player.y
	$game_map.reserve_summon_event("RandomHuman",tmpX,tmpY-1)
	$game_player.actor.add_state("MoralityDown30")
	$game_player.call_balloon(19)
end

$cg.erase
cam_center(0)
portrait_hide
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT3"] = "0"
$game_temp.choice = -1

if tmp_pass ==1
	$story_stats["Captured"] = 0
	change_map_tag_sub("NorthFL_Dock","StartPoint2",2,true,true,false)
end
