DataManager.write_constant("LonaRPG_Rec","RecHevCargoSaveCecilyRape",1)
		
		###################################################################################################################################################################################
			portrait_hide
			$story_stats["ForceChcgMode"] = 1
			chcg_background_color(200,0,200,40)
			$game_portraits.setRprt("CecilySaveRape1r")
			$game_portraits.rprt.set_position(-67,-64)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene1")
			$game_portraits.rprt.set_position(-150,-64)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene2")
			$game_portraits.setRprt("CecilySaveRape1")
			$game_portraits.rprt.set_position(-67,-64)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene3")
			$game_portraits.rprt.set_position(-150,-64)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene4")
			
			$game_portraits.setRprt("CecilySaveRape2")
			$game_portraits.rprt.set_position(-209,-163)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene5") #buchu sound
			$game_portraits.rprt.set_position(-150,-64)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene6")
			$game_portraits.rprt.set_position(-209,-163)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene7")
			$game_portraits.setRprt("CecilySaveRape1")
			$game_portraits.rprt.set_position(-67,-64)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene8")
			
			$game_portraits.setRprt("CecilySaveRape3")
			$game_portraits.rprt.set_position(-175,-147)
			$game_portraits.rprt.shake
			SndLib.sound_chs_dopyu(100)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene9")
			SndLib.sound_chs_dopyu(80)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene10")
			
			$game_portraits.setRprt("CecilySaveRape4")
			$game_portraits.rprt.set_position(-175,-147)
			$game_portraits.rprt.shake
			SndLib.sound_chs_dopyu(80)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene11")
			
			$game_portraits.setRprt("CecilySaveRape5")
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene12")
			$game_portraits.setRprt("CecilySaveRape6")
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.shake
			$game_portraits.rprt.set_position(-150,-64)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene13")
			$game_portraits.setRprt("CecilySaveRape8")
			$game_portraits.rprt.set_position(-67,-64)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene14")
			$game_portraits.rprt.set_position(-150,-64)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene15")
			$game_portraits.setRprt("CecilySaveRape4")
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene16")
			$game_portraits.setRprt("CecilySaveRape3")
			15.times{
				$game_portraits.setRprt("CecilySaveRape#{3+rand(3)}r")
				$game_portraits.rprt.set_position(-148,-125) ;SndLib.sound_chs_dopyu(50) ; wait(18)
				$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(80) ; wait(4)
			}
			$game_portraits.setRprt("CecilySaveRape6")
			$game_portraits.rprt.set_position(-150,-64)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene17")
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene18")
			$game_portraits.setRprt("CecilySaveRape7")
			$game_portraits.rprt.set_position(-67,-64)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene19")
			$game_portraits.setRprt("CecilySaveRape8")
			$game_portraits.rprt.set_position(-67,-64)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene20")
			
			3.times{
				$game_portraits.setRprt("CecilySaveRape5")
				$game_portraits.rprt.set_position(-190,-151) ;SndLib.sound_chs_dopyu(70) ; wait(7)
				$game_portraits.setRprt("CecilySaveRape9")
				$game_portraits.rprt.set_position(-209,-173) ;SndLib.sound_chs_dopyu(70) ; wait(40)
			}
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene21")
			
			
			3.times{
				$game_portraits.setRprt("CecilySaveRape10")
				$game_portraits.rprt.set_position(-190,-151) ;SndLib.sound_chs_dopyu(70) ; wait(40)
				$game_portraits.rprt.set_position(-209,-173) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			}
			$game_portraits.setRprt("CecilySaveRape11")
				$game_portraits.rprt.set_position(-209,-173) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			$game_portraits.rprt.shake
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene22")
			
			$game_portraits.setRprt("CecilySaveRape11")
			$game_portraits.rprt.set_position(-209,-163)
			call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene23")
			
			chcg_background_color_off
			$story_stats["ForceChcgMode"] = 0
		###################################################################################################################################################################################
		call_msg("TagMapCargoSaveCecily:CecilyRape/stage_rape_end")
portrait_hide