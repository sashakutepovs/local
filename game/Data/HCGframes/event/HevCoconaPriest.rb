$story_stats["HiddenOPT0"] = "0"
###################################################################################################################################################################################
portrait_hide
chcg_background_color(0,0,0,0,7)
portrait_off
$story_stats["ForceChcgMode"] = 1

call_msg("CompCocona:cocona/RecQuestCocona_HEV_0")
SndLib.sound_chcg_full(80)
wait(40)
SndLib.MaleWarriorGruntSpot
call_msg("CompCocona:cocona/RecQuestCocona_HEV_1")

$game_temp.choice == -1
call_msg("CompCocona:cocona/RecQuestCocona_15_1_1") #break,wait
$story_stats["HiddenOPT0"] = "#{$game_temp.choice}"
	if $story_stats["HiddenOPT0"] == "1"
		chcg_background_color(200,0,100,100)
	
		SndLib.sound_chcg_full(80)
		$game_portraits.setRprt("CoconaPriest01")
		$game_portraits.rprt.set_position(-95+rand(5),-150+rand(5)) #priest
		$game_portraits.rprt.shake
		SndLib.MaleWarriorGruntSpot
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_2")
		
		$game_portraits.setRprt("CoconaPriest02")
		$game_portraits.rprt.set_position(-65+rand(5),-160+rand(5)) #cocona
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_3")
		
		$game_portraits.setRprt("CoconaPriest01")
		$game_portraits.rprt.set_position(-65+rand(5),-160+rand(5)) #cocona
		$game_portraits.rprt.shake
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_3_1")
		
		$game_portraits.setRprt("CoconaPriest01")
		$game_portraits.rprt.set_position(-95+rand(5),-150+rand(5)) #priest
		SndLib.MaleWarriorGruntSpot
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_4")
	end

$game_temp.choice == -1
call_msg("CompCocona:cocona/RecQuestCocona_15_1_2") if $story_stats["HiddenOPT0"] == "1" #break,wait
$story_stats["HiddenOPT0"] = "#{$game_temp.choice}"
	if $story_stats["HiddenOPT0"] == "1"
		$game_portraits.setRprt("CoconaPriest02")
		$game_portraits.rprt.set_position(-65+rand(5),-130+rand(5)) #cocona
		$game_portraits.rprt.shake
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_5")
		
		$game_portraits.setRprt("CoconaPriest03")
		$game_portraits.rprt.set_position(-105+rand(5),-90+rand(5)) #priest
		$game_portraits.rprt.shake
		SndLib.sys_equip
		SndLib.MaleWarriorGruntSpot
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_6")
		
		$game_portraits.setRprt("CoconaPriest03")
		$game_portraits.rprt.set_position(-65+rand(5),-130+rand(5)) #cocona
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_7")
	end

$game_temp.choice == -1
call_msg("CompCocona:cocona/RecQuestCocona_15_1_3") if $story_stats["HiddenOPT0"] == "1" #break,wait
$story_stats["HiddenOPT0"] = "#{$game_temp.choice}"
	if $story_stats["HiddenOPT0"] == "1"
		$game_portraits.setRprt("CoconaPriest04")
		$game_portraits.rprt.set_position(-150+rand(5),-170+rand(5)) #penis
		$game_portraits.rprt.shake
		SndLib.sys_equip
		wait(10)
		SndLib.sound_chcg_full(80)
		wait(10)
		SndLib.MaleWarriorGruntSpot
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_8")
		
		$game_portraits.setRprt("CoconaPriest05")
		$game_portraits.rprt.set_position(-65+rand(5),-160+rand(5)) #cocona
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_7")
		
		$game_portraits.setRprt("CoconaPriest05")
		$game_portraits.rprt.set_position(-150+rand(5),-170+rand(5)) #penis
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_9")
		
		$game_portraits.setRprt("CoconaPriest06")
		$game_portraits.rprt.set_position(-150+rand(5),-170+rand(5)) #penis
		$game_portraits.rprt.shake
		SndLib.sound_chcg_full(80)
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_10")
		
		$game_portraits.setRprt("CoconaPriest06")
		$game_portraits.rprt.set_position(-65+rand(5),-130+rand(5)) #cocona
		call_msg("CompCocona:cocona/RecQuestCocona_HEV_11")
	end

###################################################################################################################################################################################
if $story_stats["HiddenOPT0"] == "1"
	DataManager.write_constant("LonaRPG_Rec","RecHevCoconaPriest",1)
	portrait_off
	chcg_background_color(0,0,0,0,7)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV2_1")
	5.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,100),8,true) ; SndLib.sound_chcg_full(80)
		wait(10+rand(20))
	}
	call_msg("CompCocona:cocona/RecQuestCocona_HEV2_2")
	call_msg("CompCocona:cocona/RecQuestCocona_HEV2_3")
	call_msg("CompCocona:cocona/RecQuestCocona_HEV2_4")
	$cg.erase
	2.times{
		$game_map.interpreter.flash_screen(Color.new(255,0,0,100),8,true) ; SndLib.sound_chcg_full(80)
		wait(10+rand(20))
	}
	########### TMP CG EV HERE ###########
	########### TMP CG EV HERE ###########
	########### TMP CG EV HERE ###########
	########### TMP CG EV HERE ###########
	########### TMP CG EV HERE ###########
	chcg_background_color(200,0,200,100)
	$game_portraits.setRprt("CoconaPriestX01")
	$game_portraits.rprt.set_position(-100+rand(5),-20+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_1")
	
	$game_portraits.setRprt("CoconaPriestX03")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	SndLib.sys_equip
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_2")
	
	$game_portraits.setRprt("CoconaPriestX02")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_3")
	
	$game_portraits.setRprt("CoconaPriestX04")
	$game_portraits.rprt.set_position(-100+rand(5),-20+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_4")
	
	$game_portraits.setRprt("CoconaPriestX01")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_5")
	
	$game_portraits.setRprt("CoconaPriestX04")
	$game_portraits.rprt.set_position(-100+rand(5),-20+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_6")
	
	$game_portraits.setRprt("CoconaPriestX04")
	$game_portraits.rprt.set_position(-100+rand(5),-20+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_7")
	
	$game_portraits.setRprt("CoconaPriestX02")
	$game_portraits.rprt.set_position(-200+rand(5),-80+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_8")
	5.times{
		$game_portraits.setRprt("CoconaPriestX0#{1+rand(4)}")
		$game_portraits.rprt.set_position(-150+rand(10),-80+rand(20)) #CoreFocus bot with vag and cocona
		SndLib.sound_chcg_full(100)
		wait(30)
		$game_portraits.setRprt("CoconaPriestX0#{1+rand(4)}")
		$game_portraits.rprt.set_position(-175+rand(10),-100+rand(20)) #CoreFocus bot with vag and cocona
		$game_portraits.rprt.shake
		SndLib.sound_punch_hit(70,50)
		$game_map.interpreter.flash_screen(Color.new(255,0,0,100),8,true)
		wait(40)
	}
	$game_portraits.setRprt("CoconaPriestX04")
	$game_portraits.rprt.set_position(-100+rand(5),-20+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_Roar0")
	SndLib.sound_chcg_full(60)
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_Roar1")
	
	$game_portraits.setRprt("CoconaPriestX02")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(60)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_Roar2")
	$game_portraits.setRprt("CoconaPriestX03")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	SndLib.sound_chcg_full(60)
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_Roar3")
	$game_portraits.setRprt("CoconaPriestX02")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	SndLib.sound_chcg_full(100)
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_Roar5")
	5.times{
		$game_portraits.setRprt("CoconaPriestX0#{1+rand(2)}")
		$game_portraits.rprt.set_position(-150+rand(10),-80+rand(20)) #CoreFocus bot with vag and cocona
		SndLib.sound_chcg_full(100)
		wait(20)
		$game_portraits.setRprt("CoconaPriestX0#{3+rand(2)}")
		$game_portraits.rprt.set_position(-175+rand(10),-100+rand(20)) #CoreFocus bot with vag and cocona
		$game_portraits.rprt.shake
		SndLib.sound_punch_hit(50,50)
		$game_map.interpreter.flash_screen(Color.new(255,0,0,100),8,true)
		wait(40)
	}
	$game_portraits.setRprt("CoconaPriestX04")
	$game_portraits.rprt.set_position(-100+rand(5),-20+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_9")
	
	$game_portraits.setRprt("CoconaPriestX02")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_Roar2")
	
	$game_portraits.setRprt("CoconaPriestX04")
	$game_portraits.rprt.set_position(-100+rand(5),-20+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_punch_hit(70,50)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_10")
	5.times{
		$game_portraits.setRprt("CoconaPriestX0#{1+rand(2)}")
		$game_portraits.rprt.set_position(-150+rand(10),-80+rand(20)) #CoreFocus bot with vag and cocona
		SndLib.sound_chcg_full(80)
		wait(15)
		$game_portraits.setRprt("CoconaPriestX0#{3+rand(2)}")
		$game_portraits.rprt.set_position(-175+rand(10),-100+rand(20)) #CoreFocus bot with vag and cocona
		SndLib.sound_punch_hit(50,50)
		$game_portraits.rprt.shake
		$game_map.interpreter.flash_screen(Color.new(255,0,0,100),8,true)
		wait(20)
	}
	7.times{
		$game_portraits.setRprt("CoconaPriestX0#{1+rand(2)}")
		$game_portraits.rprt.set_position(-150+rand(10),-80+rand(20)) #CoreFocus bot with vag and cocona
		SndLib.sound_chcg_full(80)
		wait(7)
		$game_portraits.setRprt("CoconaPriestX0#{3+rand(2)}")
		$game_portraits.rprt.set_position(-175+rand(10),-100+rand(20)) #CoreFocus bot with vag and cocona
		SndLib.sound_punch_hit(50,50)
		$game_portraits.rprt.shake
		$game_map.interpreter.flash_screen(Color.new(255,0,0,100),8,true)
		wait(18)
	}
	10.times{
		$game_portraits.setRprt("CoconaPriestX0#{1+rand(2)}")
		$game_portraits.rprt.set_position(-150+rand(10),-80+rand(20)) #CoreFocus bot with vag and cocona
		SndLib.sound_chcg_full(50)
		wait(4)
		$game_portraits.setRprt("CoconaPriestX0#{3+rand(2)}")
		$game_portraits.rprt.set_position(-175+rand(10),-100+rand(20)) #CoreFocus bot with vag and cocona
		SndLib.sound_punch_hit(50,50)
		$game_portraits.rprt.shake
		$game_map.interpreter.flash_screen(Color.new(255,0,0,100),8,true)
		wait(9)
	}
	
	$game_portraits.setRprt("CoconaPriestX02")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_11")
	
	$game_portraits.setRprt("CoconaPriestX03")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_12")
	
	$game_portraits.setRprt("CoconaPriestX01")
	$game_portraits.rprt.set_position(-100+rand(5),-20+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_13")
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_14")
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_15")
	
	
	$game_portraits.setRprt("CoconaPriestX02")
	$game_portraits.rprt.set_position(-120+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_Roar2")
	$game_portraits.setRprt("CoconaPriestC01")
	$game_portraits.rprt.set_position(-120+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_chcg_pee(100,400)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_16")
	$game_portraits.setRprt("CoconaPriestC01")
	$game_portraits.rprt.set_position(-120+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	SndLib.sound_chcg_pee(100,400)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_17")
	4.times{
	$game_portraits.setRprt("CoconaPriestC01")
		$game_portraits.rprt.set_position(-70+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
		$game_portraits.rprt.shake
		SndLib.sound_chcg_pee(100,400)
		wait(40)
	}
	
	$game_portraits.setRprt("CoconaPriestC04")
	$game_portraits.rprt.set_position(-100+rand(5),-90+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_18")
	
	$game_portraits.setRprt("CoconaPriestC04")
	$game_portraits.rprt.set_position(-150+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_pee(100,400)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_19")
	
	$game_portraits.setRprt("CoconaPriestC02")
	$game_portraits.rprt.set_position(-100+rand(5),-50+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_20")
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_21")
	$game_portraits.setRprt("CoconaPriestC03")
	$game_portraits.rprt.set_position(-100+rand(5),-50+rand(5)) #CoreFocus top with priest
	$game_portraits.rprt.shake
	SndLib.sound_chcg_pee(100,400)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_22")
	3.times{
		$game_portraits.setRprt("CoconaPriestC03")
		$game_portraits.rprt.set_position(-70+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
		$game_portraits.rprt.shake
		SndLib.sys_UseItem2
		wait(60)
	}
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_23")
	3.times{
		$game_portraits.setRprt("CoconaPriestC06")
		$game_portraits.rprt.set_position(-70+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
		$game_portraits.rprt.shake
		SndLib.sys_UseItem2
		wait(50)
	}
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_24")
	6.times{
		$game_portraits.setRprt("CoconaPriestC07")
		$game_portraits.rprt.set_position(-70+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
		$game_portraits.rprt.shake
		SndLib.sys_UseItem2
		wait(30)
	}
	2.times{
		$game_portraits.setRprt("CoconaPriestC07")
		$game_portraits.rprt.set_position(-70+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
		$game_portraits.rprt.shake
		SndLib.sys_UseItem2
		wait(60)
	}
	$game_portraits.setRprt("CoconaPriestEND")
	$game_portraits.rprt.set_position(-70+rand(5),-110+rand(5)) #CoreFocus bot with vag and cocona
	$game_portraits.rprt.shake
	SndLib.sound_chcg_full(100)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_25")
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_26")
	$game_portraits.rprt.shake
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_27")
	
	
	
	
	
	
	#########END
	chcg_background_color(0,0,0,0,7)
	portrait_off
	call_msg("CompCocona:cocona/RecQuestCocona_HEV4_END")
end
###################################################################################################################################################################################


$story_stats["ForceChcgMode"] = 0
portrait_off

