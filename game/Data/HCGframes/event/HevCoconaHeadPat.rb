portrait_hide
wait(20)
portrait_off


$story_stats["ForceChcgMode"] = 1
chcg_background_color(0,100,200,80)
basicX = 80
$game_portraits.setRprt("coconaHeadPat_a1")
$game_portraits.rprt.set_position(basicX+100+(-5+rand(10)),-30+(-5+rand(10)))
call_msg("CompCocona:Cocona/HeatPatA_2")

$game_portraits.setRprt("coconaHeadPat_a2")
$game_portraits.rprt.set_position(basicX+80+(-5+rand(10)),-15+(-5+rand(10)))
SndLib.sound_equip_armor
call_msg("CompCocona:Cocona/HeatPatA_3")

$game_portraits.setRprt("coconaHeadPat_a3")
$game_portraits.rprt.set_position(basicX+80+(-5+rand(10)),0+(-5+rand(10)))
$game_portraits.rprt.shake
SndLib.sound_equip_armor
call_msg("CompCocona:Cocona/HeatPatA_4")

4.times{
$game_portraits.setRprt("coconaHeadPat_a4")
$game_portraits.rprt.set_position(basicX+80+(-15+rand(30)),0+(-5+rand(10)))
$game_portraits.rprt.shake
SndLib.stepBush(80,50)
SndLib.sound_equip_armor(60,60)
wait(40+rand(20))
}
call_msg("CompCocona:Cocona/HeatPatA_5")

$game_portraits.setRprt("coconaHeadPat_a5")
$game_portraits.rprt.set_position(basicX+80+(-5+rand(20)),0+(-5+rand(20)))
call_msg("CompCocona:Cocona/HeatPatA_6")

4.times{
$game_portraits.rprt.set_position(basicX+80+(-15+rand(30)),0+(-5+rand(10)))
$game_portraits.rprt.shake
SndLib.stepBush(80,50)
SndLib.sound_equip_armor(60,60)
wait(40+rand(20))
}
call_msg("CompCocona:Cocona/HeatPatA_7")

$game_portraits.rprt.set_position(basicX+80+(-5+rand(10)),0+(-5+rand(10)))
call_msg("CompCocona:Cocona/HeatPatA_8")

$story_stats["ForceChcgMode"] = 0
chcg_background_color_off
portrait_off

