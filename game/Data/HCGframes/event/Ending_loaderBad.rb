
portrait_off
SndLib.bgs_stop
SndLib.bgm_stop
chcg_background_color(40,0,40,0,7)
$hudForceHide = true

case $story_stats["Ending_MainCharacter"]
	when "Ending_MC_OrkindImpale"
		portrait_off
		$game_player.actor.change_equip(1, nil)
		$game_player.actor.change_equip(2, nil)
		$game_player.actor.change_equip(3, nil)
		$game_player.actor.change_equip(4, nil)
		$game_player.actor.change_equip(5, nil)
		$game_player.actor.change_equip(6, nil)
		$game_player.actor.change_equip(8, nil)
		$game_player.actor.change_equip(9, nil)
		$game_player.actor.dirt =255
		call_msg("commonEnding:OrkindImpale/begin1")
		$cg.erase
	when "Ending_MC_OrkindCampCaptured"
		portrait_off
		$game_player.actor.change_equip(1, nil)
		$game_player.actor.change_equip(2, nil)
		$game_player.actor.change_equip(3, nil)
		$game_player.actor.change_equip(4, nil)
		$game_player.actor.change_equip(5, nil)
		$game_player.actor.change_equip(6, nil)
		$game_player.actor.change_equip(8, nil)
		$game_player.actor.change_equip(9, nil)
		$game_player.actor.dirt =255
		call_msg("commonEnding:OrkindCampCaptured/begin1")
		call_msg("commonEnding:OrkindCampCaptured/begin2")
		
		$cg.erase
		
	when "Ending_MC_HumanSlave"
		portrait_off
		$game_player.actor.change_equip(1, nil)
		$game_player.actor.change_equip(2, nil)
		$game_player.actor.change_equip(3, nil)
		$game_player.actor.change_equip(4, nil)
		$game_player.actor.change_equip(5, nil)
		$game_player.actor.change_equip(6, nil)
		$game_player.actor.change_equip(8, nil)
		$game_player.actor.change_equip(9, nil)
		$game_player.actor.dirt =255
		call_msg("commonEnding:HumanSlave/begin1")
		call_msg("commonEnding:HumanSlave/begin2")
		SndLib.bgs_play("RainLight",70,100)
		call_msg("commonEnding:HumanSlave/begin3")
		
		SndLib.bgs_stop
		$cg.erase
		$bg.erase
		
	when "Ending_MC_FishkindCampCaptured"
		portrait_off
		$game_player.actor.change_equip(1, nil)
		$game_player.actor.change_equip(2, nil)
		$game_player.actor.change_equip(3, nil)
		$game_player.actor.change_equip(4, nil)
		$game_player.actor.change_equip(5, nil)
		$game_player.actor.change_equip(6, nil)
		$game_player.actor.change_equip(8, nil)
		$game_player.actor.change_equip(9, nil)
		$game_player.actor.dirt =255
		3.times{
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingNose"])  #241
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingNoseB"])	#240
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingEar"])   #242
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingChest"]) #243
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingBelly"]) #244
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingArms"])  #245
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingAnal"])  #246
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingVag"])   #247
			$game_player.actor.itemUseBatch($data_ItemName["AddPiercingBack"])  #248
		}
		$game_player.actor.addCums("CumsCreamPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.addCums("CumsMoonPie",1000,"Fishkind")
		$game_player.actor.stat["preg"] = 3
		$game_player.actor.mood = 100
		$game_player.actor.vag_damage = 10001
		$game_player.actor.urinary_damage = 10001
		$game_player.actor.anal_damage = 10001
		
		$game_player.force_update = false
		player_force_update
		call_msg("commonEnding:FishkindCampCaptured/begin1")
		
		SndLib.bgs_stop
		$cg.erase
		$bg.erase
		$game_player.force_update = true
		
	when "Ending_MC_AbomHiveCaptured"
		portrait_off
		$game_player.actor.change_equip(1, nil)
		$game_player.actor.change_equip(2, nil)
		$game_player.actor.change_equip(3, nil)
		$game_player.actor.change_equip(4, nil)
		$game_player.actor.change_equip(5, nil)
		$game_player.actor.change_equip(6, nil)
		$game_player.actor.change_equip(8, nil)
		$game_player.actor.change_equip(9, nil)
		$game_player.actor.dirt =255
		$game_player.actor.sta = -99
		$game_player.actor.stat["EventAnalRace"] = "Abomination"
		$game_player.actor.stat["EventExt1Race"] = "Abomination"
		$game_player.actor.stat["EventVagRace"] = "Abomination"
		$game_player.actor.stat["EventMouthRace"] = "Abomination"
		$game_player.actor.stat["EventAnal"] ="AnalTouch"
		$game_player.actor.stat["EventExt1"] ="BoobTouch"
		$game_player.actor.stat["EventVag"] ="Snuff"
		$game_player.actor.stat["EventMouth"] ="kissed"
		
		call_msg("commonEnding:AbomHiveCaptured/begin1")
		call_msg("commonEnding:AbomHiveCaptured/begin2")
		call_msg("commonEnding:AbomHiveCaptured/begin3")
		#call_msg("AbomHiveCaptured:HumanSlave/begin3")
		
		
		SndLib.bgs_stop
		$cg.erase
		$bg.erase
end

load_script("Data/HCGframes/OverEvent_Death.rb")
