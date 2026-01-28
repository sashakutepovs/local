

SndLib.sound_Heartbeat(90,90) ; screen.start_tone_change(Tone.new(255,0,40,80),30)
get_character(0).forced_y = 0
get_character(0).force_update = true
get_character(0).drop_light
SndLib.bgm_play("/D/Berserk_Weird DreamsBegin",75,100)
wait(45)
combat_remove_random_equip(0)
combat_remove_random_equip(1)
SndLib.sound_equip_armor
call_msg("common:Lona/BerserkDrug0")
$game_player.actor.add_state("BerserkPack150A") #BerserkPack150A
$game_player.actor.add_state("ForceBloodLust") #ForceBloodLust
$game_player.actor.add_state("ForceBloodyMess") #ForceBloodyMess
call_msg("common:Lona/BerserkDrug1") ; portrait_hide
call_msg("common:Lona/BerserkDrug2")
$cg.erase
#SndLib.sound_Heartbeat(90,90) ; screen.start_tone_change(Tone.new(255,0,40,80),30)
#call_msg("But you.")
#SndLib.sound_Heartbeat(90,90) ; screen.start_tone_change(Tone.new(255,0,40,80),30)
#call_msg("You will be worse")
#SndLib.sound_Heartbeat(90,90) ; screen.start_tone_change(Tone.new(255,0,40,80),30)
#call_msg("Rip and Tear!!!")
#SndLib.sound_Heartbeat(90,90) ; screen.start_tone_change(Tone.new(255,0,40,80),30)
#call_msg("Until its done!")
lona_mood "normal"
$game_player.actor.stat["subpose"] =1
$game_player.actor.stat["eyes"] =3
$game_player.actor.stat["subeyes"] =3
$game_player.actor.stat["mouth"] =18
$game_player.actor.stat["head_blush"] =0
$game_player.actor.stat["eyes_tear"] =0
$game_player.actor.stat["eyes_shock"] =0
$game_player.actor.stat["ShockHead"] =0
$game_player.actor.stat["ShockBody"] =0
$game_player.actor.portrait.update
$game_player.actor.portrait.shake
call_msg("common:Lona/BerserkDrug3")
$game_player.actor.portrait.shake
call_msg("common:Lona/BerserkDrug4")
$game_player.actor.setup_state(103,5) if $story_stats["Setup_Hardcore"] >= 1

$game_player.setup_SkillRoster(tmpRoster=4,101,0) #BasicNormal
$game_player.setup_SkillRoster(tmpRoster=4,102,1) #BasicHeavy
$game_player.setup_SkillRoster(tmpRoster=4,103,2) #BasicControl
$game_player.setup_SkillRoster(tmpRoster=4,101,3) #BasicNormal
$game_player.setup_SkillRoster(tmpRoster=4,102,4) #BasicHeavy
$game_player.setup_SkillRoster(tmpRoster=4,103,5) #BasicControl
$game_player.setup_SkillRoster(tmpRoster=4,101,6) #BasicNormal
$game_player.setup_SkillRoster(tmpRoster=4,102,7) #BasicHeavy
$game_player.setup_SkillRoster(tmpRoster=4,103,8) #BasicControl
SndLib.bgm_play("/D/Berserk_Weird DreamsAction",75,100)
SndLib.sound_Heartbeat(90,90) ; screen.start_tone_change(Tone.new(125,0,20,125),30)
eventPlayEnd
