get_character(0).trigger = -1

################## TODO a fight scene

wait(60)
call_msg("CompCocona:T2start/0")
call_msg("CompCocona:T2start/0_1")
call_msg("CompCocona:T2start/1")
portrait_hide

wait(60)
EvLib.sum("EffectOverKill",get_character(0).x,get_character(0).y+1)
wait(1+rand(5))
EvLib.sum("EffectOverKill",get_character(0).x+1,get_character(0).y)
wait(1+rand(5))
EvLib.sum("EffectOverKill",get_character(0).x-1,get_character(0).y)
wait(1+rand(5))
EvLib.sum("EffectOverKill",get_character(0).x,get_character(0).y)
wait(1+rand(5))
EvLib.sum("EffectOverKill",get_character(0).x,get_character(0).y-1)
wait(1+rand(5))
get_character(0).animation = get_character(0).aniCustom(get_character(0).summon_data[:prepairAni2],1)
wait(60)
get_character(0).animation = get_character(0).aniCustom(get_character(0).summon_data[:prepairAni3],1)
SndLib.sound_combat_whoosh(get_character(0).report_distance_to_vol_close)
wait(10)
SndLib.sound_combat_whoosh(get_character(0).report_distance_to_vol_close)
wait(48)
SndLib.katana_start_heavy(get_character(0).report_distance_to_vol_close)
get_character(0).animation = get_character(0).aniCustom(get_character(0).summon_data[:prepairAni4],1)
wait(23)
get_character(0).animation = get_character(0).aniCustom(get_character(0).summon_data[:prepairAni5],-1)
wait(35)
call_msg("CompCocona:T2start/2")
portrait_hide
if $story_stats["RecQuestCoconaVagTaken"] >= 3 #若可可娜非處 且賣過淫
	call_msg("CompCocona:T2start/3_CoconaWhore")
else
	call_msg("CompCocona:T2start/3_CoconaNormal")
end
get_character(0).animation = nil
get_character(0).move_type = 8
get_character(0).set_manual_move_type(8)
get_character(0).npc_story_mode(false)
get_character(0).set_npc("UniqueBossMamaT2")
get_character(0).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
SndLib.bgm_play("/D/Arena-Industrial Combat LAYER 45",90,120)
eventPlayEnd
