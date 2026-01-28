
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
portrait_hide

get_character(0).set_summon_data({}) if !get_character(0).summon_data
get_character(0).summon_data[:DiggedWastePoo] = false if !get_character(0).summon_data[:DiggedWastePoo]
get_character(0).summon_data[:DiggedWastePee] = false if !get_character(0).summon_data[:DiggedWastePee]

	if $game_date.night? && $story_stats["Captured"] == 1 && get_character(0).summon_data[:Opt_DoomFortress_toilet] == 1
			call_msg("commonCommands:Lona/Toilet_ClearnUp")
			get_character(0).summon_data[:DiggedWastePoo] = true
			get_character(0).summon_data[:DiggedWastePee] = true
			get_character(0).summon_data[:Opt_DoomFortress_toilet] = 0
			get_character(0).call_balloon(0)
			tmpCanCollectWaste = ($game_player.actor.survival_trait + $game_player.actor.scoutcraft_trait >= 10) || $game_player.actor.stat["Mod_Taste"] == 1 || $game_player.actor.stat["Omnivore"] == 1
			$game_player.actor.sta -= 10
			$game_player.actor.sta += 2 if tmpCanCollectWaste
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				SndLib.sys_MeatGain(80+rand(10),50+rand(40))
				wait(60)
				SndLib.sys_MeatGain(80+rand(10),50+rand(40))
				wait(60)
				SndLib.sys_MeatGain(80+rand(10),50+rand(40))
				wait(60)
				get_character(0).opacity = 0
			chcg_background_color(0,0,0,255,-7)
			EvLib.sum("WastePee",$game_player.x,$game_player.y+rand(2))
			EvLib.sum("WastePoo1",$game_player.x,$game_player.y+rand(2))
			$game_player.actor.puke_value_normal += 50+rand(10) if !tmpCanCollectWaste
			$game_player.actor.dirt  += 100
			tmpCanDigPoo = tmpCanCollectWaste && $story_stats["Setup_ScatEffect"] !=0
			tmpCanDigPee = tmpCanCollectWaste && $story_stats["Setup_UrineEffect"] !=0
			optain_item("ItemBottledPee",1) if tmpCanDigPee#58
			wait(30) if tmpCanDigPee
			optain_item("WastePoo0",1) if tmpCanDigPoo#40
		
	#############################################   Normal ###################################################
	else
		load_script("Data/HCGframes/Command_AreaExcretion.rb")
	end

eventPlayEnd