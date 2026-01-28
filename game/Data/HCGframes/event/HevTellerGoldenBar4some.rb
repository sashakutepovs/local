DataManager.write_rec_constant("RecHevTellerGoldenBar4some",1)

portrait_off
chcg_background_color(0,0,0,0,7)
SndLib.sound_equip_armor
SndLib.sound_chcg_full(rand(100)+50)
wait(10)
call_msg("CompTeller:GoldenBarHev/begin1")
Audio.se_stop
portrait_hide
chcg_background_color(0,0,0,255,-7)


$story_stats["ForceChcgMode"] = 1
chcg_background_color(0,100,200,80)


################################################################################################################
SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_01")
$game_portraits.rprt.set_position(-80+(-5+rand(10)),-30+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf01")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_01")
$game_portraits.rprt.set_position(-240+(-5+rand(10)),-160+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf03")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_01")
$game_portraits.rprt.set_position(-20+(-5+rand(10)),-60+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf02")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_01")
$game_portraits.rprt.set_position(-180+(-5+rand(10)),-30+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf04")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_01")
$game_portraits.rprt.set_position(-90+(-5+rand(10)),-130+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf05")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_01")
$game_portraits.rprt.set_position(-90+(-5+rand(10)),-130+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf06")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_01")
$game_portraits.rprt.set_position(-180+(-5+rand(10)),-30+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf07")


SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_02")
$game_portraits.rprt.set_position(-180+(-5+rand(10)),-30+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf08")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_03")
$game_portraits.rprt.set_position(-100+(-5+rand(10)),-30+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf09")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_04")
$game_portraits.rprt.set_position(-120+(-5+rand(10)),-130+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf10")

SndLib.sound_chcg_full(rand(100)+50)
$game_portraits.setRprt("TellerGoldenBar4some_04")
$game_portraits.rprt.set_position(-90+(-5+rand(10)),-130+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompTeller:GoldenBarHev/HevItSelf11")

################################################################################################################




$story_stats["ForceChcgMode"] = 0
portrait_off
chcg_background_color(0,0,0,255)
wait(5)
SndLib.sys_DoorLock
wait(10+rand(10))
SndLib.sys_DoorLock
wait(10+rand(10))
SndLib.sys_DoorLock
wait(10+rand(10))