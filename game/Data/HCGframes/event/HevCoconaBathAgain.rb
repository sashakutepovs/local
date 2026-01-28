portrait_hide
chcg_background_color(0,0,0,0,7)
portrait_off
4.times{
	SndLib.sound_equip_armor(125)
	wait(30)
}
get_character(0).batch_cocona_setCHS("-char-F-TEEN01",13)
		
SndLib.waterBath
wait(90)
portrait_hide
chcg_background_color(0,0,0,255,-7)


$story_stats["ForceChcgMode"] = 1

$game_portraits.setRprt("CoconaBathAgain1")
$game_portraits.rprt.set_position(-190+(-5+rand(10)),-90+(-5+rand(10))) #lona
$game_portraits.rprt.shake
chcg_background_color(0,100,200,80)
SndLib.waterBath
call_msg("CompCocona:Cocona/BathAgain1")
Audio.se_stop

$game_portraits.setRprt("CoconaBathAgain2")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-80+(-5+rand(10))) #cocona
$game_portraits.rprt.shake
SndLib.waterBath
call_msg("CompCocona:Cocona/BathAgain2")
Audio.se_stop

$game_portraits.setRprt("CoconaBathAgain1")
$game_portraits.rprt.set_position(-190+(-5+rand(10)),-90+(-5+rand(10))) #lona
$game_portraits.rprt.shake
SndLib.waterBath
call_msg("CompCocona:Cocona/BathAgain3")
Audio.se_stop

$game_portraits.setRprt("CoconaBathAgain2")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-80+(-5+rand(10))) #cocona
$game_portraits.rprt.shake
SndLib.waterBath
call_msg("CompCocona:Cocona/BathAgain4")
Audio.se_stop

coconaEV = nil
if cocona_in_group?
	coconaEV = get_character($game_player.get_followerID(0))
end

		$game_NPCLayerMain.nap_reset_stats
		$game_NPCLayerMain.prtmood("cocona_confused")
		$game_NPCLayerMain.stat["Cocona_Dress"] = "Maid"
		get_character(0).batch_cocona_setCHS("-char-F-TEEN01",12)
		SndLib.sound_equip_armor(80)
coconaEV.batch_cocona_setCHS if coconaEV
coconaEV.batch_cocona_setHstats if coconaEV
coconaEV.chs_need_update = true if coconaEV
coconaEV.refresh if coconaEV
$game_map.interpreter.chcg_cocona_bath_clearnUP

$story_stats["ForceChcgMode"] = 0
chcg_background_color(0,0,0,255)
portrait_off
4.times{
	SndLib.sound_equip_armor(125)
	wait(30)
}
