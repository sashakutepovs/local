DataManager.write_constant("LonaRPG_Rec","RecHevSeaWitchReverseRape",1)
		
		###################################################################################################################################################################################
			portrait_hide
			$story_stats["ForceChcgMode"] = 1
			chcg_background_color(200,0,200,40)
			#(-130+(-5+rand(10)),-90+(-5+rand(10))) center
			#(-240+(-5+rand(10)),-130+(-5+rand(10))) male
			#(-30+(-5+rand(10)),-160+(-5+rand(10))) vag
			
			SndLib.sound_chcg_full(80) ; SndLib.sound_drink2 ; 
			$game_portraits.setRprt("SeaWitchReverseRape_01")
			$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
			$game_portraits.rprt.shake
			call_msg("CompSeaWitch:reverseRape/begin1")
			SndLib.sound_chcg_full(80) ; SndLib.sound_drink2
			SndLib.sound_MaleWarriorDed
			$game_portraits.setRprt("SeaWitchReverseRape_01")
			$game_portraits.rprt.set_position(-240+(-5+rand(10)),-130+(-5+rand(10)))
			$game_portraits.rprt.shake
			call_msg("CompSeaWitch:reverseRape/begin2")
			SndLib.sound_chcg_full(80) ; SndLib.sound_drink2
			$game_portraits.setRprt("SeaWitchReverseRape_01")
			$game_portraits.rprt.set_position(-30+(-5+rand(10)),-160+(-5+rand(10)))
			$game_portraits.rprt.shake
			call_msg("CompSeaWitch:reverseRape/begin3")
			3.times{
			SndLib.sound_chcg_full(80) ; SndLib.sound_MaleWarriorDed
			$game_portraits.setRprt("SeaWitchReverseRape_01")
			$game_portraits.rprt.set_position(-30+(-5+rand(10)),-160+(-5+rand(10)))
			$game_portraits.rprt.shake
			wait(50)
			}
			SndLib.sound_drink2
			SndLib.sound_drink2(90) ; SndLib.sound_MaleWarriorDed
			$game_portraits.setRprt("SeaWitchReverseRape_02")
			$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
			$game_portraits.rprt.shake
			call_msg("CompSeaWitch:reverseRape/begin4")
			SndLib.sound_chcg_full(80) ; SndLib.sound_drink2
			SndLib.sound_MaleWarriorDed
			$game_portraits.setRprt("SeaWitchReverseRape_02")
			$game_portraits.rprt.set_position(-240+(-5+rand(10)),-130+(-5+rand(10)))
			$game_portraits.rprt.shake
			call_msg("CompSeaWitch:reverseRape/begin5")
			3.times{
			SndLib.sound_chcg_full(80) ; SndLib.sound_MaleWarriorDed
			$game_portraits.setRprt("SeaWitchReverseRape_03")
			$game_portraits.rprt.set_position(-30+(-5+rand(10)),-160+(-5+rand(10)))
			$game_portraits.rprt.shake
			wait(50)
			}
			SndLib.sound_drink2(90) ; SndLib.sound_drink2
			$game_portraits.setRprt("SeaWitchReverseRape_03")
			$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
			$game_portraits.rprt.shake
			call_msg("CompSeaWitch:reverseRape/begin6")
			3.times{
			SndLib.sound_chcg_full(80) ; SndLib.sound_drink2(90) ; SndLib.sound_drink2
			$game_portraits.setRprt("SeaWitchReverseRape_04")
			$game_portraits.rprt.set_position(-30+(-5+rand(10)),-160+(-5+rand(10)))
			$game_portraits.rprt.shake
			wait(50)
			}
			$game_portraits.setRprt("SeaWitchReverseRape_04")
			$game_portraits.rprt.set_position(-130+(-5+rand(10)),-90+(-5+rand(10)))
			$game_portraits.rprt.shake
			call_msg("CompSeaWitch:reverseRape/begin7")
			3.times{
			SndLib.sound_chcg_full(80) ; SndLib.sound_drink2(90) ; SndLib.sound_drink2
			$game_portraits.setRprt("SeaWitchReverseRape_05")
			$game_portraits.rprt.set_position(-30+(-5+rand(10)),-160+(-5+rand(10)))
			$game_portraits.rprt.shake
			wait(50)
			}
			call_msg("CompSeaWitch:reverseRape/begin8")
			
			
			#$game_portraits.setRprt("CecilySaveRape1r")
			#$game_portraits.rprt.set_position(-67,-64)
			#$game_portraits.rprt.shake
			#call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene1")
			#$game_portraits.setRprt("CecilySaveRape5")
			#$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			#$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			#$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			#$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			#$game_portraits.rprt.set_position(-168,-125) ;SndLib.sound_chs_dopyu(50) ; wait(25)
			#$game_portraits.rprt.set_position(-190,-141) ;SndLib.sound_chs_dopyu(70) ; wait(7)
			#$game_portraits.rprt.shake
			#call_msg("TagMapCargoSaveCecily:CecilyRape/rape_scene12")

			
			chcg_background_color_off
			$story_stats["ForceChcgMode"] = 0
		###################################################################################################################################################################################
		#call_msg("TagMapCargoSaveCecily:CecilyRape/stage_rape_end")
portrait_hide