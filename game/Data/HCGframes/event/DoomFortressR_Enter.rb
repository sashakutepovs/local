if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmp_aggro = 0
tmp_pass = 0
$game_player.actor.sta > 0 && $game_player.actor.scoutcraft >=10 	? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
$game_player.actor.sta > 0 && $game_player.actor.wisdom >=10 		? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
#choose pass: normal pass or wis pass or sneak pass
call_msg("TagMapDoomFortress:Gate/Begin0") #[算了,進入,隱匿進入<r=HiddenOPT1>,唬爛進入<r=HiddenOPT2>]
case $game_temp.choice
when 0,-1
when 1 #進入
	if $game_player.record_companion_name_back == "UniqueCecily"
		call_msg("TagMapDoomFortress:Gate/Enter_normal1")
		call_msg("CompCecily:Cecily/DoomFortFuckOff")
		call_msg("TagMapDoomFortress:Gate/Enter_Cecily")
		tmp_pass = 1
	
	elsif $game_player.actor.stat["SlaveBrand"] == 1
		call_msg("TagMapDoomFortress:Gate/Enter_slave0")
		call_msg("TagMapDoomFortress:Gate/Enter_slave1")
		tmp_aggro = 1
		
	else #not slave
		$game_player.actor.stat["Prostitute"] ==1 || $game_player.actor.stat["Nymph"] ==1 ? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		call_msg("TagMapDoomFortress:Gate/Enter_normal1")
		call_msg("TagMapDoomFortress:Gate/Enter_normal2") #[沒事,逛逛,慰安婦<r=HiddenOPT1>]
		if $game_temp.choice == 1 #normal pass
			if $game_player.actor.sexy >=24 || $game_player.actor.weak >= 24
				$game_temp.choice = 0
				call_msg("TagMapDoomFortress:Gate/Enter_normal_walk") #[算了,好吧]
				#commonH:Lona/MilkSpray#{rand(5)
				if $game_temp.choice == 1
					call_msg("TagMapDoomFortress:Gate/Enter_normal_walk_okay0")
						$game_player.actor.stat["EventVagRace"] =  "Human"
						$game_player.actor.stat["EventAnalRace"] = "Human"
						$game_player.actor.stat["EventExt1Race"] = "Human"
						portrait_hide
						chcg_background_color(0,0,0,0,7)
							load_script("Data/HCGframes/Grab_EventAnal_AnalTouch.rb")
							call_msg("commonH:Lona/MilkSpray#{rand(5)}")
							call_msg("TagMapDoomFortress:Gate/Enter_normal_search_butt")
							half_event_key_cleaner
							
							load_script("Data/HCGframes/Grab_EventVag_VagTouch.rb")
							call_msg("commonH:Lona/MilkSpray#{rand(5)}")
							call_msg("TagMapDoomFortress:Gate/Enter_normal_search_vag")
							half_event_key_cleaner
							
							load_script("Data/HCGframes/Grab_EventExt1_BoobTouch.rb")
							call_msg("commonH:Lona/MilkSpray#{rand(5)}")
							call_msg("TagMapDoomFortress:Gate/Enter_normal_search_boob")
							half_event_key_cleaner
						chcg_background_color(0,0,0,255,-7)
					call_msg("TagMapDoomFortress:Gate/Enter_normal_walk_okay1")
					#==========================================清稿設定====================================
					check_half_over_event
					whole_event_end
					tmp_pass = 1
				end
			else
				call_msg("TagMapDoomFortress:GateR/Leave_passed")
				tmp_pass = 1
			end
		elsif $game_temp.choice == 2 # Prostitute pass
			call_msg("TagMapDoomFortress:Gate/Enter_normal_whore")
			tmp_pass = 1
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
					call_msg("OvermapNoer:GateGuard/enter_failed")
					optain_morality(-2)
				else
					call_msg("OvermapNoer:GateGuard/enter_sneak_failed")
					optain_morality(-2)
					call_msg("TagMapDoomFortress:Gate/Enter_slave0") if $game_player.actor.stat["SlaveBrand"] == 1
					call_msg("TagMapDoomFortress:Gate/Enter_slave1") if $game_player.actor.stat["SlaveBrand"] == 1
					tmp_aggro = 1
				end
			end
when 3 #唬爛進入
			$game_player.actor.sta -= 3
			call_msg("TagMapDoomFortress:Gate/Enter_normal1")
			call_msg("OvermapNoer:GateGuard/enter_wait")
			temp_roll_diff=rand(100) * ($story_stats["RapeLoop"] +1)
			temp_roll_skill= $game_player.actor.wisdom+rand(120)
			call_msg("\\narr #{temp_roll_skill.round} VS #{temp_roll_diff.round}")
			if temp_roll_skill >= temp_roll_diff  #唬爛成功
				load_script("Data/HCGframes/event/CommonGateKeeperBluffAnswer.rb")
				tmp_pass = 1
			else #唬爛失敗
				if $game_player.actor.morality >=30 && $game_player.actor.stat["SlaveBrand"] == 0  #失敗 扣MOR
					call_msg("OvermapNoer:GateGuard/enter_failed")
					optain_morality(-1)
				else
					call_msg("OvermapNoer:GateGuard/enter_sneak_failed")
					optain_morality(-1)
					call_msg("TagMapDoomFortress:Gate/Enter_slave0") if $game_player.actor.stat["SlaveBrand"] == 1
					call_msg("TagMapDoomFortress:Gate/Enter_slave1") if $game_player.actor.stat["SlaveBrand"] == 1
					tmp_aggro = 1
				end
			end
			
			
			
end# case

if tmp_aggro == 1
		$story_stats["SlaveOwner"] = "DoomFortressR" if $game_player.actor.stat["SlaveBrand"] != 0
		$story_stats["RapeLoopTorture"] =1 if $game_player.actor.stat["SlaveBrand"] != 0
		$story_stats["OnRegionMapSpawnRace"] = "HumanGuard"
		tmpX = $game_player.x
		tmpY = $game_player.y
		$game_map.reserve_summon_event("RandomHuman",tmpX-1,tmpY)
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

change_map_tag_sub("DoomFortressR","StartPoint",6,false,true) if tmp_pass ==1
