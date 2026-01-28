return self.delete if $story_stats["SMCloudVillage_KidRevange"] != 0
return self.delete if $story_stats["UniqueCharNoerRelayOut_PoorBoy"] == -1

tmpPoorBoyX,tmpPoorBoyY,tmpPoorBoyID=$game_map.get_storypoint("PoorBoy")
tmpHoboAtk1X,tmpHoboAtk1Y,tmpHoboAtk1ID=$game_map.get_storypoint("HoboAtk1")
tmpHoboAtk2X,tmpHoboAtk2Y,tmpHoboAtk2ID=$game_map.get_storypoint("HoboAtk2")

$story_stats["SMCloudVillage_KidRevange"] = 1
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpPoorBoyID).call_balloon(0)
	get_character(tmpPoorBoyID).npc_story_mode(true)
	get_character(tmpHoboAtk1ID).npc_story_mode(true)
	get_character(tmpHoboAtk2ID).npc_story_mode(true)
chcg_background_color(0,0,0,255,-7)
$game_player.call_balloon(1)
wait(40)
$game_player.turn_toward_character(get_character(tmpPoorBoyID))
$game_player.call_balloon(2)
wait(60)
call_msg("TagMapNoerRelayOut:rg4/begin0")
1.times{
	get_character(tmpPoorBoyID).direction = 4 ; get_character(tmpPoorBoyID).move_forward_force
	get_character(tmpPoorBoyID).move_speed = 2.8
	until !get_character(tmpPoorBoyID).moving? ; wait(1) end
}
get_character(tmpPoorBoyID).direction = 8
call_msg("TagMapNoerRelayOut:rg4/begin1")
1.times{
	get_character(tmpPoorBoyID).direction = 6 ; get_character(tmpPoorBoyID).move_forward_force
	get_character(tmpPoorBoyID).move_speed = 2.8
	until !get_character(tmpPoorBoyID).moving? ; wait(1) end
}
get_character(tmpPoorBoyID).direction = 8
call_msg("TagMapNoerRelayOut:rg4/begin2")
1.times{
	get_character(tmpHoboAtk1ID).direction = 2 ; get_character(tmpHoboAtk1ID).move_forward_force
	get_character(tmpHoboAtk1ID).move_speed = 2.8
	get_character(tmpHoboAtk1ID).call_balloon(5)
	until !get_character(tmpHoboAtk1ID).moving? ; wait(1) end
}
get_character(tmpHoboAtk1ID).direction = 6
get_character(tmpPoorBoyID).direction = 4
get_character(tmpHoboAtk1ID).animation = get_character(tmpHoboAtk1ID).animation_atk_mh
wait(7)
SndLib.sound_punch_hit(100,90)
wait(2)
get_character(tmpPoorBoyID).animation = get_character(tmpPoorBoyID).animation_stun
call_msg("TagMapNoerRelayOut:rg4/begin3")

3.times{
	get_character(tmpHoboAtk1ID).direction = 8 ; get_character(tmpHoboAtk1ID).move_forward_force
	get_character(tmpHoboAtk1ID).move_speed = 2.8
	get_character(tmpHoboAtk2ID).direction = 8 ; get_character(tmpHoboAtk2ID).move_forward_force
	get_character(tmpHoboAtk2ID).move_speed = 2.8
	until !get_character(tmpHoboAtk1ID).moving? ; wait(1) end
}
get_character(tmpHoboAtk1ID).direction = 8 ; get_character(tmpHoboAtk1ID).move_forward_force
get_character(tmpHoboAtk1ID).move_speed = 2.8
get_character(tmpHoboAtk2ID).direction = 8 ; get_character(tmpHoboAtk2ID).move_forward_force
get_character(tmpHoboAtk2ID).move_speed = 2.8
get_character(tmpHoboAtk1ID).effects=["FadeOutDelete",0,false,nil,nil,[true,false].sample]
get_character(tmpHoboAtk2ID).effects=["FadeOutDelete",0,false,nil,nil,[true,false].sample]
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(tmpPoorBoyID).npc_story_mode(false)
	get_character(tmpHoboAtk1ID).npc_story_mode(false)
	get_character(tmpHoboAtk2ID).npc_story_mode(false)
	get_character(tmpPoorBoyID).call_balloon(28,-1) if $story_stats["UniqueCharNoerRelayOut_PoorBoy"] == 1
	get_character(tmpPoorBoyID).call_balloon(28,-1) if $story_stats["SMCloudVillage_KillTheKid"] == 1
	get_character(tmpPoorBoyID).set_npc("NeutralHumanTeenHoboM")
	get_character(tmpPoorBoyID).npc.stat.set_stat("arousal",0)
	get_character(tmpPoorBoyID).npc.fucker_condition={"sex"=>[65535, "="]}
	get_character(tmpPoorBoyID).npc.killer_condition={"sex"=>[65535, "="]}
	get_character(tmpPoorBoyID).npc.assaulter_condition={"sex"=>[65535, "="]}
	get_character(tmpPoorBoyID).npc.death_event = "EffectDedEval"
	get_character(tmpPoorBoyID).direction = 2
	get_character(tmpHoboAtk1ID).delete
	get_character(tmpHoboAtk2ID).delete
chcg_background_color(0,0,0,255,-7)
eventPlayEnd
get_character(0).erase

