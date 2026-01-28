
tmpDuabBiosID=$game_map.get_storypoint("DualBios")[2]
tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("CannonCur")
tmpCBTvictimX,tmpCBTvictimY,tmpCBTvictimID=$game_map.get_storypoint("CBTvictim")
tmpCurVictimID = get_character(tmpDuabBiosID).summon_data[:CurVictimID]
tmpCBTvictimGrapID=$game_map.get_storypoint("CBTvictimGrap")[2]
tmpCBTlightID=$game_map.get_storypoint("CBTlight")[2]

 $bg.erase
 $cg.erase
@cover_chcg.dispose if @cover_chcg
@hint_sprite.dispose if @hint_sprite
 chcg_background_color(0,0,0,0,7)
	get_character(tmpCBTlightID).move_type = 0
	get_character(tmpCBTlightID).force_update = false
	$game_player.moveto(get_character(tmpDuabBiosID).summon_data[:CBToX],get_character(tmpDuabBiosID).summon_data[:CBToY])
	get_character(tmpCurID).call_balloon(0)
	get_character(tmpCurID).set_manual_move_type(0)
	get_character(tmpCurID).move_type = 0
	#get_character(tmpCurID).force_update = false
	$hudForceHide = false
	$balloonForceHide = false
	$game_player.force_update = true
	$game_system.menu_disabled = false
	$game_player.transparent = false
	$game_player.light_check
	get_character(tmpCBTvictimID).move_type = 0
	set_event_force_page(tmpCBTvictimID,get_character(tmpCurVictimID).summon_data[:hp]+1)
	set_event_force_page(tmpCBTvictimGrapID,get_character(tmpCurVictimID).summon_data[:hp]+1)
	tmpPattern = get_character(tmpCBTvictimID).x - tmpCBTvictimX
	get_character(tmpCBTvictimGrapID).pattern = tmpPattern
	get_character(0).switch2_id = 0
	cam_center(0)
	
	if get_character(tmpCurVictimID).summon_data[:hp] >0
		set_this_event_force_page(2)
	else
		set_this_event_force_page(1)
	end
	hunterEV = nil
	tmpAggro = $game_map.npcs.any?{|event|
		next if get_character(tmpDuabBiosID).summon_data[:Payed] == true
		next if event.summon_data == nil
		next if !event.summon_data[:Hunter]
		next if event.actor.action_state == :death
		event.npc.remove_stun_effect
		hunterEV = event
		true
	}
chcg_background_color(0,0,0,255,-7)
SndLib.bgm_play_prev


if get_character(tmpCurVictimID).summon_data[:hp] <= 0
	EvLib.sum("EfxSpeamHit",$game_player.x,$game_player.y)
	$game_player.actor.addCums("CumsHead",550,"Orkind")
	call_msg("TagMapSMRefugeeCamp:GobSemen/begin1")
	call_msg("TagMapSMRefugeeCamp:GobSemen/begin2_#{rand(2)}")
	$game_player.actor.mood += 10
	GabeSDK.getAchievement("SMRefugeeCampCBT")
else
	call_msg("TagMapSMRefugeeCamp:GobExit/Alive#{rand(2)}")
end

if tmpAggro && hunterEV
		$game_player.actor.add_state("MoralityDown30")
		$game_player.call_balloon(19)
		hunterEV.npc.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],500)
		hunterEV.turn_toward_character($game_player)
		$game_player.turn_toward_character(hunterEV)
		call_msg("TagMapSMRefugeeCamp:Hunter/WTF")
end

eventPlayEnd
