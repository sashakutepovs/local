
DataManager.write_rec_constant("RecHevFishKindDockSlave",1)

portrait_hide
chcg_background_color(0,0,0,0,7)
$story_stats["ForceChcgMode"] = 1
chcg_background_color(0,100,200,80)

$game_portraits.setRprt("FishKindDockSlave")
$game_portraits.rprt.set_position(-94+(-5+rand(10)),-144+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("TagMapNoerDock:FishKindDoor/Hev0")
$game_portraits.rprt.set_position(-242+(-5+rand(10)),-40+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("TagMapNoerDock:FishKindDoor/Hev1")
$game_portraits.rprt.set_position(-94+(-5+rand(10)),-144+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("TagMapNoerDock:FishKindDoor/Hev1_1")
$game_portraits.rprt.set_position(-242+(-5+rand(10)),-40+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("TagMapNoerDock:FishKindDoor/Hev2")
$game_portraits.rprt.set_position(-37+(-5+rand(10)),-17+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("TagMapNoerDock:FishKindDoor/Hev3")
$game_portraits.rprt.set_position(-37+(-5+rand(10)),-17+(-5+rand(10)))
$game_portraits.rprt.shake
call_msg("TagMapNoerDock:FishKindDoor/Hev4")
$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
call_msg("TagMapNoerDock:FishKindDoor/Hev5")


$story_stats["ForceChcgMode"] = 0
chcg_background_color(0,0,0,255)
portrait_off

call_msg("TagMapNoerDock:FishKindDoor/Lona0")
portrait_hide