DataManager.write_constant("LonaRPG_Rec","RecHevCecilyHijack1",1)
		###################################################################################################################################################################################
			portrait_hide
			chcg_background_color(0,0,0,0,7)
			portrait_off
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(60)

			
			$story_stats["ForceChcgMode"] = 1
			chcg_background_color(200,0,200,40)
			SndLib.sound_chcg_full(80)
			$game_portraits.setRprt("CecilyHijack1_02")
			$game_portraits.rprt.set_position(-140+rand(5),-34+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene1")
			$game_portraits.setRprt("CecilyHijack1_01")
			$game_portraits.rprt.set_position(-160+rand(5),-24+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene2")
			$game_portraits.setRprt("CecilyHijack1_02")
			$game_portraits.rprt.set_position(-90+rand(5),-24+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene3")
			$game_portraits.setRprt("CecilyHijack1_02")
			$game_portraits.rprt.set_position(-90+rand(5),-24+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene4")
			$game_portraits.setRprt("CecilyHijack1_02")
			$game_portraits.rprt.set_position(-35+rand(5),-165+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene5")
			$game_portraits.setRprt("CecilyHijack1_01")
			$game_portraits.rprt.set_position(-140+rand(5),-34+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene6")
			5.times{
				$game_portraits.setRprt("CecilyHijack1_0#{2+rand(3)}")
				$game_portraits.rprt.set_position(-150+rand(5),-90+rand(60)) ;SndLib.sound_chs_dopyu(50) ; wait(18)
				$game_portraits.rprt.set_position(-185+rand(5),-100+rand(5)) ;SndLib.sound_chs_dopyu(80) ; wait(4)
			}
			$game_portraits.setRprt("CecilyHijack1_04")
			$game_portraits.rprt.set_position(-140+rand(5),-34+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_slap(90,90)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene7")
			$game_portraits.setRprt("CecilyHijack1_03")
			$game_portraits.rprt.set_position(-35+rand(5),-165+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene8")
			$game_portraits.setRprt("CecilyHijack1_02")
			$game_portraits.rprt.set_position(-105+rand(5),-40+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene9")
			10.times{
				$game_portraits.setRprt("CecilyHijack1_0#{2+rand(3)}")
				$game_portraits.rprt.set_position(-150+rand(5),-90+rand(60)) ;SndLib.sound_chs_dopyu(50) ; wait(18)
				$game_portraits.rprt.set_position(-185+rand(5),-100+rand(5)) ;SndLib.sound_chs_dopyu(80) ; wait(4)
			}
			
			
			
			
			
			
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene10")
			3.times{
				$game_portraits.setRprt("CecilyHijack1_05")
				$game_portraits.rprt.set_position(-150+rand(5),-90+rand(60)) ;SndLib.sound_chs_dopyu(50) ; wait(7)
				$game_portraits.setRprt("CecilyHijack1_02")
				$game_portraits.rprt.set_position(-185+rand(5),-100+rand(5)) ;SndLib.sound_chs_dopyu(80) ;wait(40)
			}
			$game_portraits.rprt.shake
			$game_portraits.setRprt("CecilyHijack1_06")
			$game_portraits.rprt.set_position(-162+rand(5),-28+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene11")
			$game_portraits.setRprt("CecilyHijack1_04")
			$game_portraits.rprt.set_position(-105+rand(5),-40+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(80)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene12")
			1.times{
				$game_portraits.setRprt("CecilyHijack1_02")
				$game_portraits.rprt.set_position(-150+rand(5),-90+rand(60)) ;SndLib.sound_chs_dopyu(70) ; wait(40)
				$game_portraits.rprt.set_position(-185+rand(5),-100+rand(5)) ;SndLib.sound_chs_dopyu(80) ;wait(40)
			}
			4.times{
			$game_portraits.setRprt("CecilyHijack1_07")
			$game_portraits.rprt.set_position(-162+rand(5),-28+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			wait(50)
			}
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene13")
			$game_portraits.setRprt("CecilyHijack1_08")
			$game_portraits.rprt.set_position(-80+rand(5),-50+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene14")
			$game_portraits.setRprt("CecilyHijack1_08")
			$game_portraits.rprt.set_position(-27+rand(5),-157+rand(5))
			$game_portraits.rprt.shake
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene15")
			$game_portraits.setRprt("CecilyHijack1_09")
			$game_portraits.rprt.set_position(-148+rand(5),-70+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene16")
			3.times{
				$game_portraits.setRprt("CecilyHijack1_1#{rand(4)}")
				$game_portraits.rprt.set_position(-150+rand(5),-90+rand(60)) ;SndLib.sound_chs_dopyu(50) ; wait(18)
				$game_portraits.rprt.set_position(-185+rand(5),-100+rand(5)) ;SndLib.sound_chs_dopyu(80) ; wait(4)
			}
			$game_portraits.setRprt("CecilyHijack1_09")
			$game_portraits.rprt.set_position(-140+rand(5),-34+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene17")
			$game_portraits.setRprt("CecilyHijack1_09")
			$game_portraits.rprt.set_position(-80+rand(5),-20+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene18")
			12.times{
				$game_portraits.setRprt("CecilyHijack1_1#{rand(4)}")
				$game_portraits.rprt.set_position(-150+rand(5),-90+rand(60)) ;SndLib.sound_chs_dopyu(50) ; wait(18)
				$game_portraits.rprt.set_position(-185+rand(5),-100+rand(5)) ;SndLib.sound_chs_dopyu(80) ; wait(4)
			}
			$game_portraits.rprt.set_position(-182+rand(5),-33+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene19")
			1.times{
				$game_portraits.setRprt("CecilyHijack1_1#{rand(4)}")
				$game_portraits.rprt.set_position(-150+rand(5),-90+rand(60)) ;SndLib.sound_chs_dopyu(70) ; wait(40)
				$game_portraits.rprt.set_position(-185+rand(5),-100+rand(5)) ;SndLib.sound_chs_dopyu(80) ;wait(40)
			}
			4.times{
			$game_portraits.setRprt("CecilyHijack1_07")
			$game_portraits.rprt.set_position(-162+rand(5),-28+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			wait(50)
			}
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene19_1")
			$game_portraits.setRprt("CecilyHijack1_14")
			$game_portraits.rprt.set_position(-163+rand(5),-72+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene20")
			$game_portraits.setRprt("CecilyHijack1_09")
			$game_portraits.rprt.set_position(-193+rand(5),-58+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			wait(60)
			3.times{
				$game_portraits.setRprt("CecilyHijack1_1#{rand(4)}")
				$game_portraits.rprt.set_position(-150+rand(5),-90+rand(60)) ;SndLib.sound_chs_dopyu(50) ; wait(18)
				$game_portraits.rprt.set_position(-185+rand(5),-100+rand(5)) ;SndLib.sound_chs_dopyu(80) ; wait(4)
			}
			$game_portraits.rprt.set_position(-41+rand(5),-170+rand(5))
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene21")
			$game_portraits.setRprt("CecilyHijack1_13")
			$game_portraits.rprt.set_position(-62+rand(5),-100+rand(5))
			$game_portraits.rprt.shake
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			SndLib.sound_chcg_full(100)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene22")
			portrait_off
			chcg_background_color(0,0,0,0,7)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			SndLib.sound_chcg_full(80)
			wait(25)
			call_msg("TagMapCecilyHijack:CecilyRape/rape_scene23")
			$story_stats["ForceChcgMode"] = 0
		###################################################################################################################################################################################
chcg_background_color_off
portrait_off