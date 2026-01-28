return SndLib.sys_trigger if $story_stats["UniqueCharUniqueOgreWarBoss"] == -1
return SndLib.sys_trigger if $story_stats["RapeLoop"] == 0
tmpMove_type = $game_player.actor.master.move_type
$game_player.actor.master.npc_story_mode(true)
$game_player.actor.master.move_type = 0
get_character(0).npc_story_mode(true)


$game_portraits.setLprt("OgreWarboss_BoneShield")
$game_portraits.lprt.shake
$game_player.actor.master.call_balloon(5)
SndLib.sound_OgreDed(100,60)
wait(120)
$game_portraits.lprt.hide

aniData = [ [10,0+get_character(0).direction_offset,-1,0,1]]
get_character(0).animation = get_character(0).aniCustom(aniData,-1)
get_character(0).call_balloon(6)
get_character(0).npc.play_sound(:sound_alert2,80)
wait(60)
call_msg("TagMapSyb_WarBossRoom:cooker/begin1")

tmpTarList = []
tmpTarList << [$game_text["commonNPC:commonNPC/Cancel"]							,"Cancel"]
tmpTarList << [$game_text["TagMapSyb_WarBossRoom:Warboss/rapeloop_OPT_beat"]	,"rapeloop_OPT_beat"]
tmpTarList << [$game_text["TagMapSyb_WarBossRoom:Warboss/rapeloop_OPT_rape"]	,"rapeloop_OPT_rape"]
cmd_sheet = tmpTarList
cmd_text =""
for i in 0...cmd_sheet.length
	cmd_text.concat(cmd_sheet[i].first+",")
end
##call_msg("commonNPC:MaleHumanRandomNpc/CommonHuman_CommonNpcOpt",0,2,0)
call_msg("\\optB[#{cmd_text}]")
$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
$game_temp.choice = -1

case tmpPicked
	when "rapeloop_OPT_beat"
		$game_player.actor.master.animation = $game_player.actor.master.animation_atk_mh
		wait(8)
		SndLib.sound_punch_hit(100)
		get_character(0).summon_data[:WarbossTalked] = true
		wait(8)
		get_character(0).npc.play_sound(:sound_alert2,80)
		get_character(0).jump_to(get_character(0).x,get_character(0).y)
		get_character(0).animation = get_character(0).animation_stun
		wait(60)
		###################this npc kneel
		$game_player.actor.master.call_balloon(5)
		SndLib.sound_OgreDed(100,60)
		wait(60)
		get_character(0).call_balloon(6)
		get_character(0).npc.play_sound(:sound_alert2,80)
		aniData = [ [10,0+get_character(0).direction_offset,-1,0,1]]
		get_character(0).animation = get_character(0).aniCustom(aniData,-1)
		wait(60)
		
	when "rapeloop_OPT_rape"
		$game_player.actor.master.animation = $game_player.actor.master.animation_grabber_qte(get_character(0))
		get_character(0).animation = get_character(0).animation_grabbed_qte
		wait(10)
		get_character(0).npc.play_sound(:sound_alert2,80)
		get_character(0).jump_to(get_character(0).x,get_character(0).y)
		get_character(0).call_balloon(6)
		wait(80)
		$game_player.transparent = false
		$game_player.forced_z = -1
		$game_player.animation = $game_player.animation_stun
		npc_sex_service_main($game_player.actor.master,get_character(0),"mouth",nil,1)
		10.times{
			SndLib.sound_chs_buchu(80)
			get_character(0).npc.play_sound(:sound_death,80) if rand(100) >= 60
			wait(30)
		}
		get_character(0).summon_data[:WarbossTalked] = true
		chcg_background_color(0,0,0,0,7)
			get_character(0).unset_chs_sex
			$game_player.actor.master.unset_chs_sex
			$game_player.transparent = true
			$game_player.forced_z = 0
			$game_player.moveto($game_player.actor.master.x,$game_player.actor.master.y)
		chcg_background_color(0,0,0,255,-7)
		###################this npc kneel
		$game_player.actor.master.call_balloon(5)
		SndLib.sound_OgreDed(100,60)
		wait(60)
		get_character(0).call_balloon(6)
		get_character(0).npc.play_sound(:sound_alert2,80)
		aniData = [ [10,0+get_character(0).direction_offset,-1,0,1]]
		get_character(0).animation = get_character(0).aniCustom(aniData,-1)
		wait(60)
end

$game_player.actor.master.move_type = tmpMove_type
$game_player.actor.master.npc_story_mode(false)
$game_player.animation = nil

get_character(0).npc_story_mode(false)
get_character(0).animation = nil
eventPlayEnd
