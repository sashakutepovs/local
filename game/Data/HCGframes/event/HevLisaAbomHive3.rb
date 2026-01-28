

DataManager.write_constant("LonaRPG_Rec","RecHevLisaAbomHive3",1)
portrait_hide
chcg_background_color(0,0,0,0,7)
portrait_off
SndLib.sound_WormMoonQuestion(100,70)
call_msg("CompLisa:Lisa12/rg13_HEV0")
SndLib.sound_WormCommonLoud(100,70)
chcg_background_color(0,0,0,255,-7)


$story_stats["ForceChcgMode"] = 1
chcg_background_color(200,0,200,40)

$game_portraits.setRprt("LisaAbomHive01")
$game_portraits.rprt.set_position(-120+rand(4),-150+rand(4)) #forcus on Center
$game_portraits.rprt.shake
SndLib.sound_chcg_full(80,70)
call_msg("CompLisa:Lisa12/rg13_HEV1")
call_msg("CompLisa:Lisa12/rg13_HEV1_1")
$game_portraits.setRprt("LisaAbomHive01")
$game_portraits.rprt.set_position(-120+rand(4),-150+rand(4)) #forcus on Center
$game_portraits.rprt.shake
SndLib.sound_chcg_full(80,70)
call_msg("CompLisa:Lisa12/rg13_HEV2")

$game_portraits.setRprt("LisaAbomHive02")
$game_portraits.rprt.set_position(-230+rand(4),-90+rand(4)) #forcus on R tentcle
$game_portraits.rprt.shake
SndLib.sound_chcg_full(80,100)
SndLib.sound_WormCommonLoud(100,70)
call_msg("CompLisa:Lisa12/rg13_HEV3")

$game_portraits.setRprt("LisaAbomHive03")
$game_portraits.rprt.set_position(-230+rand(4),-40+rand(4))#forcus on R tentcle
$game_portraits.rprt.shake
SndLib.sound_chcg_full(80,100)
$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
call_msg("CompLisa:Lisa12/rg13_HEV4")

$game_portraits.rprt.set_position(-260+rand(4),-40+rand(4))#forcus on R tentcle + up
$game_portraits.rprt.shake
SndLib.sound_chcg_full(80,100)
$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
call_msg("CompLisa:Lisa12/rg13_HEV5")
5.times{
	$game_portraits.rprt.set_position(-200+rand(4),-40+rand(4))#forcus on R tentcle + up
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(80,100)
	$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
	wait(30)
}
call_msg("CompLisa:Lisa12/rg13_HEV6")


$game_portraits.setRprt("LisaAbomHive04")
$game_portraits.rprt.set_position(-120+rand(4),-150+rand(4)) #forcus on Center
$game_portraits.rprt.shake
SndLib.sound_WormMoonQuestion(100,70)
call_msg("CompLisa:Lisa12/rg13_HEV7")

$game_portraits.setRprt("LisaAbomHive06")
$game_portraits.rprt.set_position(-120+rand(4),-150+rand(4)) #forcus on Center
$game_portraits.rprt.shake
SndLib.sound_chcg_full(80,100)
$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
call_msg("CompLisa:Lisa12/rg13_HEV8")

$game_portraits.setRprt("LisaAbomHive07_0")
$game_portraits.rprt.set_position(-80+rand(4),-150+rand(4)) #forcus on vag
$game_portraits.rprt.shake
SndLib.sound_chs_pyu(80,100)
$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
call_msg("CompLisa:Lisa12/rg13_HEV9")

tmpRoll = 0
8.times{
	tmpRoll +=1
	$game_portraits.setRprt("LisaAbomHiveX_0#{tmpRoll}")
	$game_portraits.rprt.set_position(-130+rand(30),-100+rand(15)) #forcus on vag
	$game_map.interpreter.flash_screen(Color.new(255,0,0,25),8,true)
	SndLib.sound_chs_papa(80,100)
	SndLib.sound_chcg_full(80,100)
	wait(30)
	tmpRoll =0 if tmpRoll >= 4
}
$game_portraits.setRprt("LisaAbomHive07_1")
$game_portraits.rprt.set_position(-40,-150)
$game_portraits.rprt.shake
call_msg("CompLisa:Lisa12/rg13_HEV11")

$game_portraits.setRprt("LisaAbomHive08_0")
$game_portraits.rprt.set_position(-80+rand(4),-150+rand(4)) #forcus on vag
$game_portraits.rprt.shake
call_msg("CompLisa:Lisa12/rg13_HEV12")
2.times{
	$game_portraits.setRprt("LisaAbomHive08_1")
	$game_portraits.rprt.set_position(-80+rand(4),-150+rand(4)) #forcus on vag
	$game_portraits.rprt.shake
	SndLib.sound_chcg_chupa
	wait(30)
	$game_portraits.setRprt("LisaAbomHive08_0")
	$game_portraits.rprt.set_position(-80+rand(4),-150+rand(4)) #forcus on vag
	$game_portraits.rprt.shake
	SndLib.sound_chcg_chupa
	wait(30)
}
call_msg("CompLisa:Lisa12/rg13_HEV13")
tmpRoll = 0
16.times{
	tmpRoll +=1
	$game_portraits.setRprt("LisaAbomHiveY_0#{tmpRoll}")
	$game_portraits.rprt.set_position(-150+rand(60),-120+rand(15)) #forcus on vag
	$game_map.interpreter.flash_screen(Color.new(255,0,0,25),8,true)
	SndLib.sound_chs_papa(80,100)
	SndLib.sound_chcg_full(80,100)
	wait(15)
	tmpRoll =0 if tmpRoll >= 4
}
$game_portraits.rprt.shake
call_msg("CompLisa:Lisa/LisaAbomHev30")
$game_portraits.setRprt("LisaAbomHive09")
$game_portraits.rprt.set_position(-80,-130)
$game_portraits.rprt.shake
SndLib.sound_chs_papa(80,100)
call_msg("CompLisa:Lisa12/rg13_HEV14")
$game_portraits.setRprt("LisaAbomHive08_1")
$game_portraits.rprt.set_position(-80,-130)
$game_portraits.rprt.shake
SndLib.sound_chs_papa(80,100)
call_msg("CompLisa:Lisa12/rg13_HEV15")

$game_portraits.setRprt("LisaAbomHive10")
$game_portraits.rprt.set_position(-80,-130)
$game_portraits.rprt.shake
SndLib.sound_chs_pyu(100,50)
SndLib.sound_chs_dopyu(100,50)
wait(70)

$game_portraits.setRprt("LisaAbomHive11")
$game_portraits.rprt.set_position(-80,-130)
$game_portraits.rprt.shake
SndLib.sound_chs_pyu(100,50)
SndLib.sound_chs_dopyu(100,50)
wait(70)

$game_portraits.setRprt("LisaAbomHive12")
$game_portraits.rprt.set_position(-80,-130)
$game_portraits.rprt.shake
SndLib.sound_chs_pyu(100,50)
SndLib.sound_chs_dopyu(100,50)
wait(70)

$game_portraits.setRprt("LisaAbomHive13")
$game_portraits.rprt.set_position(-80,-130)
$game_portraits.rprt.shake
SndLib.sound_chs_pyu(100,50)
SndLib.sound_chcg_full(80,100)
SndLib.sound_chcg_full(80,100)
SndLib.sound_chcg_full(80,100)
call_msg("CompLisa:Lisa12/rg13_HEV16")
$game_portraits.setRprt("LisaAbomHive13")
$game_portraits.rprt.set_position(-80,-130)
$game_portraits.rprt.shake
SndLib.sound_chs_pyu(100,50)
SndLib.sound_chcg_full(80,100)
SndLib.sound_chcg_full(80,100)
SndLib.sound_chcg_full(80,100)
call_msg("CompLisa:Lisa12/rg13_HEV17")




chcg_background_color_off
portrait_off
$story_stats["ForceChcgMode"] = 0

