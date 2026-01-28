#tmpSgtX,tmpSgtY,tmpSgtID=$game_map.get_storypoint("SGT")
#tmpSgX,tmpSgY,tmpSgID=$game_map.get_storypoint("securityGuard")
#

#get_character(tmpTableID).summon_data[:DayQuestAccept] == true
#get_character(tmpTableID).summon_data[:WorkDone] == false
#get_character(tmpTableID).summon_data[:WorkPick] == "Sandbag"     #"Joy"

if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpTableX,tmpTableY,tmpTableID=$game_map.get_storypoint("tableSGT")
tmpSscX,tmpSscY,tmpSscID=$game_map.get_storypoint("SuvSlaveCount")

tmpQ1 = get_character(tmpTableID).summon_data[:DayQuestAccept] == true
tmpQ2 = get_character(tmpTableID).summon_data[:WorkDone] == false
tmpQ3 = get_character(tmpTableID).summon_data[:WorkPick] == "Sandbag"
#################################################### SandBagWork ############################################
if $story_stats["Captured"] == 1 && tmpQ1 && tmpQ2 && tmpQ3
	get_character(0).call_balloon(0)
	call_msg("TagMapDoomFortress:SGT/SlaveSuvival")
	get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
	get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
	get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
	$game_map.npcs.each do |event|
		next if event.deleted?
		next if event.actor.action_state == :death
		next if event.summon_data == nil
		next if !event.summon_data[:trainingGuard]
		event.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],1800)
	end
	SndLib.bgm_play("CB_Epic Drums (Looped)",70)
	call_timer(20,60)
	portrait_hide
	cam_center(0)
	set_event_force_page(tmpSscID,3)
	
#################################################### NORMAL ############################################
elsif $story_stats["RecQuestSGT"] == 0 && $game_player.actor.stat["SlaveBrand"] == 0
	call_msg("TagMapDoomFortress:SGT/begin_normal_0")
	if [0, -1].include?($game_temp.choice)
		SndLib.sound_QuickDialog
		get_character(0).animation = get_character(0).animation_atk_mh
		case rand(3)
			when 0;get_character(0).call_balloon(15)
			when 1;get_character(0).call_balloon(7)
			when 2;get_character(0).call_balloon(5)
		end
		SndLib.sound_punch_hit(100)
		lona_mood "p5crit_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.force_stun("Stun1")
		call_msg_popup("TagMapDoomFortress:SGT/begin_wrong_ans",get_character(0).id)
		cam_center(0)
		return portrait_hide
	end
	call_msg("TagMapDoomFortress:SGT/begin_normal_1")
	if [-1].include?($game_temp.choice)
		SndLib.sound_QuickDialog
		get_character(0).animation = get_character(0).animation_atk_mh
		case rand(3)
			when 0;get_character(0).call_balloon(15)
			when 1;get_character(0).call_balloon(7)
			when 2;get_character(0).call_balloon(5)
		end
		SndLib.sound_punch_hit(100)
		lona_mood "p5crit_damage"
		$game_player.actor.portrait.shake
		$game_player.actor.force_stun("Stun1")
		call_msg_popup("TagMapDoomFortress:SGT/begin_wrong_ans",get_character(0).id)
		cam_center(0)
		return portrait_hide
	end
	call_msg("TagMapDoomFortress:SGT/begin_normal_2")
	call_msg("TagMapDoomFortress:SGT/begin_normal_3")
	call_msg("TagMapDoomFortress:SGT/begin_normal_4")
	optain_exp(1500*2)
	$story_stats["RecQuestSGT"] = 1
else
	call_msg("TagMapDoomFortress:SGT/known0")
end

cam_center(0)
portrait_hide
