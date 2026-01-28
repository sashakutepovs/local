$game_player.animation = $game_player.animation_dance
tmpDdrBoxID = $game_map.get_storypoint("DdrBox")[2]
get_character(tmpDdrBoxID).opacity = 0
get_character(tmpDdrBoxID).call_balloon(0)


danceID = $game_map.get_storypoint("DanceCount")[2]
sex_secord = get_character(danceID).switch2_id[1]
tmpE3		= !$game_player.actor.equips[3].nil? && $game_player.actor.equips[3].id != 9
tmpE4		= !$game_player.actor.equips[4].nil? && $game_player.actor.equips[4].id != 13
tmpE6		= !$game_player.actor.equips[6].nil?
can_strip 	= tmpE3 || tmpE4 || tmpE6
can_poo 	= $story_stats["Setup_ScatEffect"] ==1 && $game_actors[1].defecate_level >=300
can_pee 	= $story_stats["Setup_UrineEffect"] ==1 && $game_actors[1].urinary_level >=300
can_milk 	= $game_actors[1].lactation_level >=300
can_clearn 	= ($game_actors[1].cumsMeters["CumsCreamPie"] + $game_actors[1].cumsMeters["CumsMoonPie"]) >=1
peeon 		= $story_stats["Setup_UrineEffect"] ==1 && sex_secord >= 2500 #UniqueEvent_Peeon.rb
posi	=$game_map.region_map[2].sample
can_cum = sex_secord >= 1300
can_touch= sex_secord <=1500
tmpADDfapper = false

p "******************************************************"
p can_strip 	
p can_poo 	
p can_pee 	
p can_milk 	
p can_clearn 	
p peeon 		
p "******************************************************"

event_list = [
			["DressOut",can_strip],
			["Masturbation",true],
			["Pee",can_pee],
			["Poo",can_poo],
			["can_milk",can_milk],
			["GroinClearn",can_clearn],
			["AnalTouch",can_touch],
			["BoobTouch",can_touch],
			["VagTouch",can_touch],
			["VagLick",can_touch],
			["Kiss",can_touch],
			["Bukaake",can_cum],				 #rb
			["CumTop",can_cum],				 #rb
			["CumBot",can_cum],				 #rb
			["CumMid",can_cum],				 #rb
			["PeeonHead",peeon],				 #rb
			["Peeon",peeon]					 #rb
]
event_list.delete_if{|asd| asd[1] == false}
event_pick = event_list.sample

# strip dress
 $game_player.direction = [2,4].sample
if can_strip
	call_msg("TagMapNoerTavern:Lona/dance_DDR_DressOut")
	call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
	case $game_temp.choice
	when 0
		tmpADDfapper = true
		SndLib.sound_equip_armor
		SndLib.ppl_CheerGroup(70)
		get_character(danceID).switch2_id[1] += 300
		$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
		if tmpE6 #mid ext
			$game_player.actor.change_equip(6, nil)
			$game_player.actor.update_lonaStat
			$game_player.update
		elsif tmpE4 #bot
			$game_player.actor.change_equip(4, nil)
			$game_player.actor.update_lonaStat
			$game_player.update
		elsif tmpE3 #mid
			$game_player.actor.change_equip(3, nil)
			$game_player.actor.update_lonaStat
			$game_player.update
		end
	else
		SndLib.ppl_BooGroup(100)
		$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
		$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
		$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
	end#case
else
	case event_pick[0]
		when "Masturbation"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Masturbation")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
							load_script("Data/HCGframes/Action_CHSH_Masturbation.rb")
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 800
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
		when "Pee"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Pee")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
							load_script("Data/HCGframes/Command_Pee.rb")
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 300
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
		when "Poo"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Poo")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
							load_script("Data/HCGframes/Command_Poo.rb")
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 500
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
		when "can_milk"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Milk")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
							load_script("Data/HCGframes/Command_SelfMilking.rb")
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 1200
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
		when "GroinClearn"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_GroinClearn")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
							load_script("Data/HCGframes/Command_GroinClearn.rb")
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 300
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
		when "Bukaake"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Bukaake")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
								$game_player.actor.stat["EventExt1Race"] = "Human"
								$game_player.actor.stat["EventExt2Race"] = "Human"
								$game_player.actor.stat["EventExt3Race"] = "Human"
								$game_player.actor.stat["EventExt4Race"] = "Human"
								chcg_decider_basic_fapper(pose=5)
								load_script("Data/HCGframes/Ext1_Fapper.rb")
								$game_actors[1].addCums("CumsHead",300,"Human")
								load_script("Data/HCGframes/Ext2_Fapper.rb")
								$game_actors[1].addCums("CumsHead",300,"Human")
								load_script("Data/HCGframes/Ext3_Fapper.rb")
								$game_actors[1].addCums("CumsHead",300,"Human")
								load_script("Data/HCGframes/Ext4_Fapper.rb")
								$game_actors[1].addCums("CumsHead",300,"Human")
								whole_event_end
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 1200
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
		when "CumTop"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Cum")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
								$game_player.actor.stat["EventExt1Race"] = "Human"
								$game_player.actor.stat["EventExt2Race"] = "Human"
								$game_player.actor.stat["EventExt3Race"] = "Human"
								$game_player.actor.stat["EventExt4Race"] = "Human"
								chcg_decider_basic_fapper(pose=1)
								load_script("Data/HCGframes/Ext1_Fapper.rb")
								$game_actors[1].addCums("CumsTop",300,"Human")
								load_script("Data/HCGframes/Ext2_Fapper.rb")
								$game_actors[1].addCums("CumsTop",300,"Human")
								load_script("Data/HCGframes/Ext3_Fapper.rb")
								$game_actors[1].addCums("CumsTop",300,"Human")
								load_script("Data/HCGframes/Ext4_Fapper.rb")
								$game_actors[1].addCums("CumsTop",300,"Human")
								whole_event_end
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 1200
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
		when "CumMid"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Cum")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
								$game_player.actor.stat["EventExt1Race"] = "Human"
								$game_player.actor.stat["EventExt2Race"] = "Human"
								$game_player.actor.stat["EventExt3Race"] = "Human"
								$game_player.actor.stat["EventExt4Race"] = "Human"
								chcg_decider_basic_fapper(pose=2)
								load_script("Data/HCGframes/Ext1_Fapper.rb")
								$game_actors[1].addCums("CumsMid",300,"Human")
								load_script("Data/HCGframes/Ext2_Fapper.rb")
								$game_actors[1].addCums("CumsMid",300,"Human")
								load_script("Data/HCGframes/Ext3_Fapper.rb")
								$game_actors[1].addCums("CumsMid",300,"Human")
								load_script("Data/HCGframes/Ext4_Fapper.rb")
								$game_actors[1].addCums("CumsMid",300,"Human")
								whole_event_end
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 1200
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
		when "CumBot"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Cum")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
								$game_player.actor.stat["EventExt1Race"] = "Human"
								$game_player.actor.stat["EventExt2Race"] = "Human"
								$game_player.actor.stat["EventExt3Race"] = "Human"
								$game_player.actor.stat["EventExt4Race"] = "Human"
								chcg_decider_basic_fapper(pose=3)
								load_script("Data/HCGframes/Ext1_Fapper.rb")
								$game_actors[1].addCums("CumsBot",300,"Human")
								load_script("Data/HCGframes/Ext2_Fapper.rb")
								$game_actors[1].addCums("CumsBot",300,"Human")
								load_script("Data/HCGframes/Ext3_Fapper.rb")
								$game_actors[1].addCums("CumsBot",300,"Human")
								load_script("Data/HCGframes/Ext4_Fapper.rb")
								$game_actors[1].addCums("CumsBot",300,"Human")
								whole_event_end
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 1200
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end

		when "PeeonHead"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_PeeonHead")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
								$game_player.actor.stat["EventVagRace"] = "Human"
								$game_player.actor.stat["EventAnalRace"] = "Human"
								$game_player.actor.stat["EventMouthRace"] = "Human"
								$game_player.actor.stat["EventExt1Race"] = "Human"
								$game_player.actor.stat["EventExt2Race"] = "Human"
								$game_player.actor.stat["EventExt3Race"] = "Human"
								$game_player.actor.stat["EventExt4Race"] = "Human"
								load_script("Data/HCGframes/UniqueEvent_PeeonTavernHead.rb")
								whole_event_end
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 1200
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end

		when "Peeon"
				call_msg("TagMapNoerTavern:Lona/dance_DDR_Peeon")
				call_msg("TagMapNoerTavern:Lona/dance_DDR_opt")
				case $game_temp.choice
					when 0
							portrait_off
							tmpADDfapper = true
							SndLib.ppl_CheerGroup(70)
								$game_player.actor.stat["EventVagRace"] = "Human"
								$game_player.actor.stat["EventAnalRace"] = "Human"
								$game_player.actor.stat["EventMouthRace"] = "Human"
								$game_player.actor.stat["EventExt1Race"] = "Human"
								$game_player.actor.stat["EventExt2Race"] = "Human"
								$game_player.actor.stat["EventExt3Race"] = "Human"
								$game_player.actor.stat["EventExt4Race"] = "Human"
								load_script("Data/HCGframes/UniqueEvent_Peeon.rb")
								whole_event_end
							SndLib.ppl_CheerGroup(70)
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							$game_map.reserve_summon_event("TavernJumpMoney",posi[0],posi[1])
							get_character(danceID).switch2_id[1] += 1200
				else
					SndLib.ppl_BooGroup(100)
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
					$game_map.reserve_summon_event("TavernTrap#{rand(5)}",posi[0],posi[1])
				end
				
		when "AnalTouch"
					$game_player.actor.add_state(159)
					event_Grab_AnalTouch("Human")
					get_character(danceID).switch2_id[1] += 200
					SndLib.ppl_CheerGroup(70)
		when "BoobTouch"
					$game_player.actor.add_state(159)
					event_Grab_BoobTouch("Human")
					get_character(danceID).switch2_id[1] += 200
					SndLib.ppl_CheerGroup(70)
		when "VagTouch"
					$game_player.actor.add_state(159)
					event_Grab_VagTouch("Human")
					get_character(danceID).switch2_id[1] += 200
					SndLib.ppl_CheerGroup(70)
		when "VagLick"
					$game_player.actor.add_state(159)
					event_Grab_VagLick("Human")
					get_character(danceID).switch2_id[1] += 200
					SndLib.ppl_CheerGroup(70)
		when "Kiss"
					$game_player.actor.add_state(159)
					event_Grab_Kissed("Human")
					get_character(danceID).switch2_id[1] += 200
					SndLib.ppl_CheerGroup(70)
					
	end #case event list
end


if tmpADDfapper
 $game_map.npcs.any?{
 |event| 
  next if event.summon_data == nil
  next if !event.summon_data[:customer]
  next if event.animation = nil
  next if event.actor.action_state == :death
  next if event.actor.action_state == :stun
  next if event.actor.action_state == :sex
  event.animation = event.animation_masturbation
}
end

get_character(tmpDdrBoxID).opacity = 255
get_character(tmpDdrBoxID).call_balloon(19,-1)
$game_player.animation = nil
portrait_hide