DataManager.write_rec_constant("RecHevTellerSakaGBoss",1)

portrait_off
chcg_background_color(0,0,0,0,7)
SndLib.sound_equip_armor
call_msg("CompTeller:TellerSakaGBoss/begin1")
Audio.se_stop
portrait_hide
chcg_background_color(0,0,0,255,-7)


$story_stats["ForceChcgMode"] = 1
chcg_background_color(0,100,200,80)

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss01")
$game_portraits.rprt.set_position(-120+(-5+rand(10)),-150+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG01")

$game_portraits.setRprt("TellerSakaGBoss02")
$game_portraits.rprt.set_position(-120+(-5+rand(10)),-100+(-5+rand(10)))
call_msg("CompTeller:TellerSakaGBoss/hCG02")

$game_portraits.setRprt("TellerSakaGBoss03")
$game_portraits.rprt.set_position(-110+(-5+rand(10)),-140+(-5+rand(10)))
call_msg("CompTeller:TellerSakaGBoss/hCG03")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss04")
$game_portraits.rprt.set_position(-110+(-5+rand(10)),-110+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG04")

##################################################################################
SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss05")
$game_portraits.rprt.set_position(-110+(-5+rand(10)),-110+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG05")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss06")
$game_portraits.rprt.set_position(-110+(-5+rand(10)),-110+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG06")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss05")
$game_portraits.rprt.set_position(-110+(-5+rand(10)),-110+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG04")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss06")
$game_portraits.rprt.set_position(-110+(-5+rand(10)),-110+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG07")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss05")
$game_portraits.rprt.set_position(-110+(-5+rand(10)),-110+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG08")

SndLib.sound_chcg_full(rand(100)+50)
SndLib.sound_MaleWarriorDed
$game_portraits.setRprt("TellerSakaGBoss06")
$game_portraits.rprt.set_position(-110+(-5+rand(10)),-110+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG09")
SndLib.sound_MaleWarriorDed
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG10")

SndLib.sound_MaleWarriorDed
SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss05")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-120+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG11")

SndLib.sound_MaleWarriorDed
SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss07")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-120+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG12")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss08")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-120+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG13")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss07")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-120+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG14")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss08")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-120+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG15")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerSakaGBoss09")
$game_portraits.rprt.set_position(-100+(-5+rand(10)),-100+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:TellerSakaGBoss/hCG16")

$game_portraits.setRprt("TellerSakaGBoss09")
$game_portraits.rprt.set_position(-100+(-5+rand(10)),-100+(-5+rand(10)))
call_msg("CompTeller:TellerSakaGBoss/hCG17")

$game_portraits.setRprt("TellerSakaGBoss09")
$game_portraits.rprt.set_position(-100+(-5+rand(10)),-100+(-5+rand(10)))
call_msg("CompTeller:TellerSakaGBoss/hCG18")

$game_portraits.setRprt("TellerSakaGBoss09")
$game_portraits.rprt.set_position(-100+(-5+rand(10)),-100+(-5+rand(10)))
call_msg("CompTeller:TellerSakaGBoss/hCG19")


$story_stats["ForceChcgMode"] = 0
portrait_off
chcg_background_color(0,0,0,255)
wait(5)
SndLib.sys_DoorLock
wait(15+rand(10))
SndLib.sys_DoorLock
wait(15+rand(10))
SndLib.sys_DoorLock
wait(15+rand(10))

portrait_hide


#dress ON