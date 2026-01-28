DataManager.write_rec_constant("RecHevCoconaBath",1)


portrait_hide
chcg_background_color(0,0,0,0,7)
SndLib.waterBath
call_msg("CompCocona:bathEV/begin0")
Audio.se_stop
portrait_hide
chcg_background_color(0,0,0,255,-7)


$story_stats["ForceChcgMode"] = 1
chcg_background_color(0,100,200,80)

SndLib.waterBath
$game_portraits.setRprt("CoconaBath1")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompCocona:bathEV/begin1")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
call_msg("CompCocona:bathEV/begin2")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
call_msg("CompCocona:bathEV/begin3")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
call_msg("CompCocona:bathEV/begin4")
Audio.se_stop
wait(60)

SndLib.waterBath
$game_portraits.setRprt("CoconaBath2")
$game_portraits.rprt.set_position(-140+(-5+rand(10)),-80+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompCocona:bathEV/begin5")
$game_portraits.rprt.set_position(-140+(-5+rand(10)),-80+(-5+rand(10)))
call_msg("CompCocona:bathEV/begin6")
Audio.se_stop
wait(60)

SndLib.waterBath
$game_portraits.setRprt("CoconaBath3")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("CompCocona:bathEV/begin7")
Audio.se_stop
wait(60)

$story_stats["ForceChcgMode"] = 0
chcg_background_color(0,0,0,255)
$game_portraits.setRprt("nil")
$game_portraits.setLprt("nil")
portrait_hide


#dress ON