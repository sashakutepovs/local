
recRoomMode = $story_stats["tmpData"] && $story_stats["tmpData"][:recRoomMode]
return if recRoomMode
chcg_init_cocona
coconaEV = get_character($game_player.get_followerID(0))
return if !coconaEV || !cocona_in_group?
$game_player.force_update = false

$game_NPCLayerMain.stat["pose"] = "CoconaWhoreEV_B"
$game_NPCLayerMain.stat["EventVagRace"] = "Human"
tmpBackHumFuckerLHand	=$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"]
tmpVagHumFucker			=$game_NPCLayerMain.stat["Cocona_VagHumFucker"]
tmpBackHumFuckerRHand	=$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"]
tmpEffect_EffectPee		=$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"]
tmpEffect_ButtShake		=$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"]
tmpEffect_HeadShock		=$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"]
tmpEffect_EyesShock		=$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"]
tmpEffect_EyesTear		=$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]
tmpEffect_BodyShake		=$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"]
tmpEffect_Wet			=$game_NPCLayerMain.stat["Cocona_Effect_Wet"]
tmpEffect_CumButtR		=$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"]
tmpEffect_CumButtL		=$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"]
tmpEffect_CreamPie		=$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"]
tmpVagOpen				=$game_NPCLayerMain.stat["Cocona_VagOpen"]
tmpDress				=$game_NPCLayerMain.stat["Cocona_Dress"]
tmpBody					=$game_NPCLayerMain.stat["Cocona_Body"]
tmpEyes					=$game_NPCLayerMain.stat["Cocona_Eyes"]
tmpMouth				=$game_NPCLayerMain.stat["Cocona_Mouth"]
tmpHeadBase				=$game_NPCLayerMain.stat["Cocona_HeadBase"]
tmpBOX					=$game_NPCLayerMain.stat["Cocona_BOX"]
tmpVagXray				=$game_NPCLayerMain.stat["Cocona_VagXray"]
#setLprt("NPCLayerMain")
#	$game_NPCLayerMain.portrait.update
#	$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125,-108)
$game_NPCLayerMain.portrait.mirror = true



call_msg("CompCocona:cocona/RecQuestCocona_HEV3_12")


$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 0
$game_NPCLayerMain.stat["Cocona_VagHumFucker"]	= 0
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_Wet"] = 1
$game_NPCLayerMain.stat["Cocona_VagOpen"] = 1
6.times{
	SndLib.sound_chcg_pee(100,400)
	$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = [4,5].sample
	$game_NPCLayerMain.stat["Cocona_Mouth"] = rand(3)+2
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-125-50,-108)
	wait(20)
	
	$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"] = 2
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = [4,5].sample
	$game_NPCLayerMain.stat["Cocona_Mouth"] = rand(3)+2
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-125-50,-108)
	$game_NPCLayerMain.portrait.shake
	wait(20)
}
call_msg("CompCocona:cocona/RecQuestCocona_HEV3_8")
$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"] = 0
$game_NPCLayerMain.stat["Cocona_Arousal"] = 0
$story_stats["record_CoconaOgrasm"] +=1
$game_player.force_update = true
coconaEV.actor.set_sta(coconaEV.actor.battle_stat.get_stat("sta")-30) if coconaEV
coconaEV.actor.update_npc_stat if coconaEV