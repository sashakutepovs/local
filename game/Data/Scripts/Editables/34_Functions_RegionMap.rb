#class Integer
#class Integer
#class Integer
#class Integer
#	def is_number?
#		true if Float self rescue false
#	end 
#end

class Game_Player
	def deduct_lona_sta_overmap #REGION列表  請勿變更對應表  一旦決定就決定了
		case $game_player.region_id
			when 1	;sta_cost = 10 ; #平地
			when 2	;sta_cost = 6 ; #海灘
			when 3	;sta_cost = 25 ; #死山
			when 4	;sta_cost = 20 ; #羽林
			when 5	;sta_cost = 20 ; #松林
			when 6	;sta_cost = 20 ; #死林
			when 7	;sta_cost = 25 ; #青山
			when 8	;sta_cost = 22 ; #沼澤
			when 9	;sta_cost = 8  ; #Abandoned house
			when 10	;sta_cost = 7  ; #SLUM
			when 11	;sta_cost = 6  ; #道路
			when 12	;sta_cost = 6  ; #比佛利山莊
			when 13	;sta_cost = 7  ; #沼澤小徑
			when 14	;sta_cost = 8  ; #受感染的沙地
			when 15	;sta_cost = 14  ; #濕地
			when 16	;sta_cost = 10 ; #肉魔的地衣 r16_PlainBadland
			when 17	;sta_cost = 10 ; #感染的道路 r17_RoadSyb
			when 18	;sta_cost = 14 ; #感染的城市 r18_TownSyb
			when 19	;sta_cost = 8 ;  #沙漠化的土地 r19_OrkDesert
			when 20	;sta_cost = 7  ; #RefugeeCamp1
			when 21	;sta_cost = 6  ; #鎮上
			when 22	;sta_cost = 5  ; #官道
			when 23	;sta_cost = 5  ; #Boulevard1
			when 24	;sta_cost = 7  ; #沼澤小徑
			when 25	;sta_cost = 22 ; #沼澤
			when 26	;sta_cost = 14  ; #濕地
			when 27	;sta_cost = 6 ; #海灘(Fish)
			when 28	;sta_cost = 10 ; #肉魔的地衣 r28_OrkBadland2
			when 29	;sta_cost = 15 ; #陷落的堡壘 r29_SYB_KeepAbom1
			when 30	;sta_cost = 15 ; #肉魔的地衣 r30_SYB_KeepOrk1
			when 31	;sta_cost = 7 ; # r31_SYB_RoadOrk1
			when 32	;sta_cost = 14 ; # r31_SYB_RoadOrk1
			else	;sta_cost = 1  ; 
		end
		sta_cost
	end
end

module GIM_ADDON

#本檔案管理野外敵人種族生成與分類  不包含事件本身
	def overmap_random_event_trigger(region=$game_player.region_id,rewrite=false,tmpRegionBG=nil)#TODO 設定接收筏 接收資訊決定事件類別 善惡
		availble_scripts = overmap_random_event_trigger_create_availble_scripts(region)
		overmap_random_event_trigger_get_availble_scripts(region,rewrite,tmpRegionBG,availble_scripts)
	end
	def overmap_random_event_trigger_create_availble_scripts(region)
		case region
			when 1,4,5,7,9	#平原 海灘 松森 密森 松森山 野外廢屋
					availble_scripts =[	[75,"OrkindGroup.rb"],
										[50,"UndeadWalking.rb"],
										[25,"BanditMobs.rb"],
										[30,"CommonMobs.rb"],
										[check_HitchhikerTrait ? 10 : 5,"RoadHalp.rb"],
										[check_HitchhikerTrait ? 10 : 5,"RefugeeCamp.rb"],
										[check_HitchhikerTrait ? 20 : 10,"AbandonedResourcesNoer.rb"],
										[check_HitchhikerTrait ? 20 : 10,"NoerOutaNeedaHelp.rb"],
										[30,"DireWolfCharge.rb"]
										]
			when 2	#海灘 
					availble_scripts =[	[75,"OrkindGroup.rb"],
										[25,"BanditMobs.rb"],
										[30,"CommonMobs.rb"],
										[20,"RogueWaves.rb"],
										[check_HitchhikerTrait ? 10 : 5,"RoadHalp.rb"],
										[check_HitchhikerTrait ? 10 : 5,"RefugeeCamp.rb"],
										[check_HitchhikerTrait ? 20 : 10,"AbandonedResourcesNoer.rb"],
										[check_HitchhikerTrait ? 20 : 10,"NoerOutaNeedaHelp.rb"]
										]
			when 8#沼澤
					availble_scripts =[	[80,"FishkindGroup.rb"],
										[20,"OrkindGroup.rb"],
										[25,"UndeadWalking.rb"],
										[30,"DireWolfCharge.rb"]
										]
			when 15#濕地
					availble_scripts =[	[80,"FishkindGroup.rb"],
										[35,"OrkindGroup.rb"],
										[35,"UndeadWalking.rb"]
										]
	
			when 11			#野外道路
					availble_scripts =[	[20,"OrkindGroup.rb"],
										[10,"DireWolfCharge.rb"],
										[20,"UndeadWalking.rb"],
										[check_HitchhikerTrait ? 20 : 10,"RoadHalp.rb"],
										[check_HitchhikerTrait ? 20 : 10,"AbandonedResourcesNoer.rb"],
										[check_HitchhikerTrait ? 20 : 10,"RefugeeCamp.rb"],
										[check_HitchhikerTrait ? 30 : 15,"NoerOutaNeedaHelp.rb"],
										[check_GangDebtCollet ? 70 : 0,"GangDebtCollet.rb"],
										[30,"CommonMobs.rb"],
										[70,"BanditMobs.rb"]
										]
			when 12			#Rudesind Slope
					availble_scripts =[	[100,"NobleGuards.rb"] ]
	
			when 13			#沼澤小徑
					availble_scripts =[	[20,"OrkindGroup.rb"],
										[10,"NoerGuards.rb"],
										[check_HitchhikerTrait ? 20 : 10,"RoadHalp.rb"],
										[check_HitchhikerTrait ? 20 : 10,"AbandonedResourcesNoer.rb"],
										[check_HitchhikerTrait ? 20 : 10,"RefugeeCamp.rb"],
										[check_HitchhikerTrait ? 30 : 15,"NoerOutaNeedaHelp.rb"],
										[check_GangDebtCollet ? 20 : 0,"GangDebtCollet.rb"],
										[30,"CommonMobs.rb"],
										[20,"BanditMobs.rb"],
										[80,"FishkindGroup.rb"]
										]
			when 21,22		#城市與街道 低機率暴民 高機率守衛
					availble_scripts =[	[100,"NoerGuards.rb"],
										[check_GangDebtCollet ? 100 : 0,"GangDebtCollet.rb"],
										[30,"BanditMobs.rb"],
										[check_HitchhikerTrait ? 15 : 5,"NoerMissionary.rb"],
										[check_HitchhikerTrait ? 15 : 5,"NoerHomeless.rb"]
										]
	
			when 10,20		#城市外部 貧民窟 ,難民營
					availble_scripts =[ [30,"CommonMobs.rb"],
										[70,"BanditMobs.rb"],
										[check_HitchhikerTrait ? 20 : 10,"RoadHalp.rb"],
										[check_HitchhikerTrait ? 15 : 5,"NoerMissionary.rb"],
										[check_HitchhikerTrait ? 15 : 5,"NoerHomeless.rb"]
										]
			when 23;		#官道
					availble_scripts =[	[30,"NoerGuards.rb"],
										[30,"CommonMobs.rb"],
										[check_HitchhikerTrait ? 20 : 10,"RoadHalp.rb"],
										[check_HitchhikerTrait ? 20 : 10,"RefugeeCamp.rb"],
										[70,"BanditMobs.rb"]
										]
										
			when 14;		#受感染的沙地
					availble_scripts =[	[check_HitchhikerTrait ? 20 : 10,"RoadHalp.rb"],
										[50,"AbomBreedlingRaid.rb"],
										[50,"AbomBreedlingTrap.rb"],
										[20,"AbomSpider.rb"],
										[10,"AbomManager.rb"]
										]
										
			when 17,18,29;					#SYB城市感染區
					availble_scripts =[	
										[50,"AbomBreedlingRaid.rb"],
										[10,"AbomBreedlingTrap.rb"],
										[30,"AbomSpider.rb"],
										[20,"AbomManager.rb"]
										]
			when 3,6;		#荒野感染區
					availble_scripts =[	[50,"AbomSpider.rb"],
										[50,"AbomBreedlingRaid.rb"],
										[40,"AbomManager.rb"]
										]
										
										
			when 24,25,26;		#漁人島
					availble_scripts =[	[60,"FishPPL.rb"],
										[10,"FishkindGroup.rb"]
										]
			when 27 			#漁人島 海灘
					availble_scripts =[	[60,"FishPPL.rb"],
										[10,"FishkindGroup.rb"],
										[10,"RogueWaves.rb"]
										]
			when 19,28					#SYB 類獸人區 野外
					availble_scripts =[	
										[check_HitchhikerTrait ? 15 : 5,"NFL_AbandonedCropses.rb"],
										[check_HitchhikerTrait ? 15 : 5,"NFL_Vs_Refugee_Orkind.rb"],
										[check_HitchhikerTrait ? 15 : 5,"RefugeeCamp.rb"],
										[2, "AbomManager.rb"],
										[5, "AbomSpider.rb"],
										[10, "AbomBreedlingRaid.rb"],
										[50, "NFL_OrkindPlayGround.rb"],
										[50,"NFL_OrkindGroup.rb"],
										[100,"NFL_GobRaider.rb"]
										]
			when 30					#SYB 類獸人區 城堡
					availble_scripts =[	
										[check_HitchhikerTrait ? 15 : 5,"NFL_AbandonedCropses.rb"],
										[check_HitchhikerTrait ? 15 : 5,"NFL_Vs_Refugee_Orkind.rb"],
										[check_HitchhikerTrait ? 15 : 5,"RefugeeCamp.rb"],
										[2, "AbomManager.rb"],
										[5, "AbomSpider.rb"],
										[10, "AbomBreedlingRaid.rb"],
										[50, "NFL_OrkindPlayGround.rb"],
										[100,"NFL_OrkindGroup.rb"]
										]
			when 31,32
					availble_scripts =[	
										[check_HitchhikerTrait ? 15 : 5,"NFL_AbandonedCropses.rb"],
										[check_HitchhikerTrait ? 15 : 5,"NFL_Vs_Refugee_Orkind.rb"],
										[check_HitchhikerTrait ? 15 : 5,"RefugeeCamp.rb"],
										[100, "NFL_OrkindPlayGround.rb"],
										[200,"NFL_OrkindGroup.rb"]
										]
			else ; 			#other
					availble_scripts =[	[100,"OrkindGroup.rb"],
										[30,"CommonMobs.rb"],
										[100,"UndeadWalking.rb"]
										]
			#else msgbox "no script for this region #{reion}";nil;
		end
		availble_scripts
	end
	def overmap_random_event_trigger_get_availble_scripts(region=$game_player.region_id,rewrite=false,tmpRegionBG=nil,availble_scripts)
		spawn_race=nil
			random_range=0
			availble_scripts = region if rewrite == true
			availble_scripts.each{|race|
				random_range+=race[0]
			}
			temp_create_race=rand(random_range)
			for i in 0...availble_scripts.length
				temp_create_race-=availble_scripts[i][0] 
				if temp_create_race<=0
					spawn_race = availble_scripts[i][1] 
					break 
				end
			end
		spawn_race
		$story_stats["ReRollHalfEvents"] = 1
		$story_stats["RegionMap_Background"] = tmpRegionBG if tmpRegionBG != nil
		load_script("Data/HCGframes/encounter/#{spawn_race}")
		$story_stats["record_EncounterTriggered"] += 1
		$story_stats["StepOvermapDangerous"] = 0
	end
	#NAP導致的野外危險係數產生的機率
	def region_map_wildness_nap_stats
		p "region_map_wildness_nap_spawn"
		$story_stats["WildDangerous"] += [[(rand(10)+$story_stats["WorldDifficulty"]/2).to_i - $game_player.actor.survival*2,10].max,50].min
		if $story_stats["WildDangerous"] >= rand(100) + $game_player.actor.survival
			$game_player.move_sneak
			race_list=region_map_wildness_nap_stats_create_race_list
			region_map_wildness_nap_stats_execute(race_list)
		end #if $story_stats["WildDangerous"] >= rand(100)+$game_player.actor.survival
	end #def


	def region_map_wildness_nap_stats_create_race_list
		race_list=case $story_stats["OnRegionMap_Regid"]
				when 1,4,5,7 #平原 松森 密森 松森山
					[
						[70,"Orkind"],
						[20,"BanditMobs"],
						[30,"UndeadWalking"],
						[30,"CommonMobs"],
						[30,"WolfGroup"]
					]
				when 2 #海灘
					[
						[70,"Orkind"],
						[20,"BanditMobs"],
						[30,"UndeadWalking"],
						[30,"CommonMobs"],
						[40,"BanditMobs"]
					]
				when 8 #沼澤
					[
						[70,"Fishkind"],
						[30,"Orkind"],
						[20,"UndeadWalking"],
						[20,"WolfGroup"]
					]
				when 15 #濕地
					[
						[80,"Fishkind"],
						[35,"Orkind"],
						[35,"UndeadWalking"]
					]
				when 20,23; #貧民窟#官道等 低機率ORKIND 低機率 GUARD 高機率暴民
					[
						[70,"BanditMobs"],
						[check_GangDebtCollet ? 70 : 0,"GangDebtCollet"],
						[30,"CommonMobs"]
					]
				when 10,21,22 #城市與街道 低機率暴民 高機率守衛
					[
						[40,"BanditMobs"],
						[check_GangDebtCollet ? 100 : 0,"GangDebtCollet"],
						[30,"CommonMobs"],
						[30,"HumanGuard"]
					]
				when 12
					[
						[100,"NobleGuards"]
					]
				when 11 #野外道路
					[
						[10,"Orkind"],
						[20,"BanditMobs"],
						[10,"WolfGroup"],
						[20,"UndeadWalking"],
						[30,"CommonMobs"],
						[70,"HumanGuard"]
					]
				when 2,3,6,14 #荒野感染區
					[
						[50,"AbomManager"],
						[60,"AbomBreedlingRaid"],
						[30,"AbomSpider"]
					]
				when 24,25,26,27;	#漁人島
					[
						[60,"FishPPL"],
						[10,"Fishkind"]
					]
				when 19,28;	#NorthFL 類獸人區
					[
						[60,"Orkind"],
						[60,"OrkindPlayGround"],
						[5,"AbomManager"],
						[10,"AbomBreedlingRaid"],
						[5,"AbomSpider"]
					]
				when 31,32
					[
						[60,"Orkind"],
						[60,"OrkindPlayGround"]
					]
				else#其他所有TAG
					[
						[10,"Orkind"],
						[60,"BanditMobs"],
						[30,"CommonMobs"],
						[30,"HumanGuard"]
					]
		end # case race_chance
		race_list
	end
	def region_map_wildness_nap_stats_execute(race_list)
		spawn_race=nil
		random_range=0 
		race_list.each{|race|
			random_range+=race[0]
		}
		temp_create_race=rand(random_range)
		for i in 0...race_list.length
			temp_create_race-=race_list[i][0] 
			if temp_create_race<=0
				spawn_race = race_list[i][1] 
				break 
			end
		end
		if $story_stats["OnRegionMapEncounterRace"] != 0 #if get spotted in overmap. controller in 33_Functions_OverMapEvents.rb def overmap_event_EnterMap
			$story_stats["OnRegionMapSpawnRace"] = $story_stats["OnRegionMapEncounterRace"] 
			$story_stats["OnRegionMapEncounterRace"] = 0
		else
			$story_stats["OnRegionMapSpawnRace"] = spawn_race
		end
	end
######################### 於此處管理各族的單位生成
def region_map_wildness_spawn(tmpForceSpawn = false) #NAP導致的野外危險係數產生的單位
return if $story_stats["OverMapEvent_name"] != 0 && tmpForceSpawn == false#避免同時產生Encounter環境單位
p "region_map_wildness_spawn"
tmpForceSpawn == false ? tmpSpawnRace = $story_stats["OnRegionMapSpawnRace"] : tmpSpawnRace = tmpForceSpawn
	case tmpSpawnRace
		when "OrkindPlayGround" ; 
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomGoblin",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomHobgoblin",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomOrc",posi1[0],posi1[1])
							}
						when 25..50
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomGoblin",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomHobgoblin",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomOrc",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("HobgoblinShaman",posi1[0],posi1[1])
							}
						when 50..75
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomGoblin",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomHobgoblin",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomOrc",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("OrcButcher",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("HobgoblinShaman",posi1[0],posi1[1])
							}
						else
							4.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomHobgoblin",posi1[0],posi1[1])
							}
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("RandomOrc",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("OrcButcher",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							EvLib.sum("HobgoblinShaman",posi1[0],posi1[1])
							}
					end
		
		when "GobRaider" ; 
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HobgoblinRaiderSpear",posi1[0],posi1[1])
							}
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HobgoblinRaiderArcher",posi1[0],posi1[1])
						when 25..50
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HobgoblinRaiderSpear",posi1[0],posi1[1])
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HobgoblinRaiderArcher",posi1[0],posi1[1])
							}
						when 50..75
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HobgoblinRaiderSpear",posi1[0],posi1[1])
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HobgoblinRaiderArcher",posi1[0],posi1[1])
							}
						else
							4.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HobgoblinRaiderSpear",posi1[0],posi1[1])
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HobgoblinRaiderArcher",posi1[0],posi1[1])
							}
					end
		when "Orkind" ; 
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							4.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("RandomGoblin",posi1[0],posi1[1])
							}
						when 25..50
							5.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("RandomGoblin",posi1[0],posi1[1])
							}
						when 50..75
							5.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("RandomGoblin",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("RandomHobgoblin",posi1[0],posi1[1])
							}
						else
							5.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("RandomGoblin",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("RandomHobgoblin",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("RandomOrc",posi1[0],posi1[1])
							}
					end
					
		when "Fishkind" ; 
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindCharger",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindCommoner",posi1[0],posi1[1])
							}
						when 25..50
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindCharger",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindCommoner",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindSpear",posi1[0],posi1[1])
							}
						when 50..75
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindCharger",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindCommoner",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindSpear",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindFat",posi1[0],posi1[1])
							}
						else
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindCharger",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindCommoner",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("FishkindFat",posi1[0],posi1[1])
							}
					end
					
					
		when "FishPPL" ; 
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeSpearGuard",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeBowGuard",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeWatcher",posi1[0],posi1[1])
							}
						when 25..50
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeSpearGuard",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeBowGuard",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeWatcher",posi1[0],posi1[1])
							}
						when 50..75
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeSpearGuard",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeBowGuard",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeWatcher",posi1[0],posi1[1])
							}
						else
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeSpearGuard",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeBowGuard",posi1[0],posi1[1])
							}
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("DeeponeWatcher",posi1[0],posi1[1])
							}
					end
					
		when "HumanGuard" ;
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanBow",posi1[0],posi1[1])
							}
						when 25..50
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanBow",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanWarrior",posi1[0],posi1[1])
							}
						when 50..75
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanBow",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanWarrior",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanScout",posi1[0],posi1[1])
							}
						else
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanBow",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanWarrior",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanScout",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanLawbringer",posi1[0],posi1[1])
							}
					end
					
		when "NobleGuards" ;
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							4.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanWarrior",posi1[0],posi1[1])
							}
						when 25..50
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanWarrior",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanLawbringer",posi1[0],posi1[1])
							}
						when 50..75
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanWarrior",posi1[0],posi1[1])
							}
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanLawbringer",posi1[0],posi1[1])
							}
						else
							4.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanWarrior",posi1[0],posi1[1])
							}
							4.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("HumanLawbringer",posi1[0],posi1[1])
							}
					end
					
		when "BanditMobs","GangDebtCollet" ;
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueScout",posi1[0],posi1[1])
							}
						when 25..50
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueScout",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanClub",posi1[0],posi1[1])
							}
						when 50..75
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueScout",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanClub",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueBow",posi1[0],posi1[1])
							}
						else
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueScout",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanClub",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueBow",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueWarrior",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanRogueWarriorElite",posi1[0],posi1[1])
							}
					end
		when "CommonMobs" ;
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanCommoner",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobMootCommoner",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanPickAxe",posi1[0],posi1[1])
							}
						when 25..50
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanCommoner",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobMootCommoner",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanPickAxe",posi1[0],posi1[1])
							}
						when 50..75
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanCommoner",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobMootCommoner",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanPickAxe",posi1[0],posi1[1])
							}
						else
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanCommoner",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobMootCommoner",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanPickAxe",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("MobHumanSpear",posi1[0],posi1[1])
							}
					end
					
					
		when "UndeadWalking" ;
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadCommoner",posi1[0],posi1[1])
							}
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadSickle",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteWarrior",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteSpear",posi1[0],posi1[1])
							}
						when 25..50
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadCommoner",posi1[0],posi1[1])
							}
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadSickle",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteWarrior",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteSpear",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadBow",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteBow",posi1[0],posi1[1])
							}
						when 50..75
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadCommoner",posi1[0],posi1[1])
							}
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadSickle",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteWarrior",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteSpear",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadBow",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteBow",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadSpear",posi1[0],posi1[1])
							}
						else
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadCommoner",posi1[0],posi1[1])
							}
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadSickle",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteWarrior",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteSpear",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadBow",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadEliteBow",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadSpear",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("UndeadWarrior",posi1[0],posi1[1])
							}
					end
		when "WolfGroup" ;
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
					posi2=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
					posi3=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
					$game_map.reserve_summon_event("WildDireWolf",posi1[0],posi1[1],-1)
					
		when "AbomManager"
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureSpider",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureZombie",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureScorpion",posi1[0],posi1[1])
							}
						when 25..50
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureSpider",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureZombie",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureScorpion",posi1[0],posi1[1])
							}
						when 50..75
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureSpider",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureZombie",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureScorpion",posi1[0],posi1[1])
							}
							1.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureManager",posi1[0],posi1[1])
							}
						else
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureSpider",posi1[0],posi1[1])
							}
							3.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureZombie",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureScorpion",posi1[0],posi1[1])
							}
							2.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureManager",posi1[0],posi1[1])
							}
					end
					
				when "AbomSpider"
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					case $story_stats["WorldDifficulty"]
						when 0..25
							5.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureSpider",posi1[0],posi1[1])
							}
						when 25..50
							6.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureSpider",posi1[0],posi1[1])
							}
						when 50..75
							8.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureSpider",posi1[0],posi1[1])
							}
						else
							10.times{
							posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
							$game_map.reserve_summon_event("AbomCreatureSpider",posi1[0],posi1[1])
							}
					end
					
				when "AbomBreedlingRaid"
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					tmpTimes = 4
					tmpTimes += (($story_stats["WorldDifficulty"] / 30)*2).to_i
					tmpTimes.times{
						posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
						EvLib.sum("AbomCreatureBreedling",posi1[0],posi1[1],{:mobs=>true})
					}
							
				when "Refugee"
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					get_posiINSA = $story_stats["RegionMap_RegionInsa"] 
					3.times{
						posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
						$game_map.reserve_summon_event("HoboM#{rand(2)}",posi1[0],posi1[1])
					}
					2.times{
						posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
						$game_map.reserve_summon_event("HoboF#{rand(2)}",posi1[0],posi1[1])
					}
					3.times{
						posi1=$game_map.region_map[get_posiINSA[rand(get_posiINSA.length)]].sample
						$game_map.reserve_summon_event("CampBed#{rand(4)}",posi1[0],posi1[1])
					}
				when "Vs_Refugee_Orkind"
					posiRES0,posiRES1	=$game_map.get_storypoint("StartPoint")
					EvLib.sum("EncVsRef8",posiRES0,posiRES1-2)
					EvLib.sum("QuestGiverEncVsRef",posiRES0,posiRES1-1)
					EvLib.sum("EncVsRef2",posiRES0,posiRES1+1)
					EvLib.sum("EncVsRef4",posiRES0-2,posiRES1)
					EvLib.sum("EncVsRef6",posiRES0+2,posiRES1)
					EvLib.sum("QuestCountOrkVsRef",1,1)
					
					
		end
$story_stats["RapeLoop"] =1 if $story_stats["OnRegionMapSpawnRace"] !=0 && tmpForceSpawn == false
end


#綁架管理 ps: 直接死亡行請去NAP DEF中處理
def region_map_wildness_capture
	p "region_map_wildness_capture"
	$game_player.actor.sta = -99 if $game_player.actor.sta !=-99
	case $story_stats["OnRegionMapSpawnRace"]
		when "Orkind"
				$story_stats["OnRegionMapSpawnRace"] = 0
				$story_stats["CapturedStatic"] =1
				call_msg("OvermapEvents:Lona/CaptureByOrkind0")
				$game_player.move_normal
				call_msg("OvermapEvents:Lona/CaptureByOrkind1#{talk_style}")
				$cg.erase
				tarList = [	"OrkindCave1","OrkindCave2","OrkindCave3","OrkindCave4","OrkindCamp1","OrkindKeep1",
							"NFL_OrkCamp1","NFL_OrkCamp2"]
				tmpPoint = check_PointsClosestRange(tarList)
				st_x,st_y,st_id=$game_map.get_storypoint(tmpPoint)
				$game_player.moveto(get_character(st_id).x,get_character(st_id).y)
				$story_stats["LastOverMapX"] = $game_player.x
				$story_stats["LastOverMapY"] = $game_player.y
				call_msg("OvermapEvents:Lona/Capture_arrived#{talk_style}")
				change_map_captured_enter_tag(tmpPoint)
		when "Fishkind"
				$story_stats["OnRegionMapSpawnRace"] = 0
				$story_stats["CapturedStatic"] =1
				call_msg("OvermapEvents:Lona/CaptureByOrkind0")										#todo
				$game_player.move_normal
				call_msg("OvermapEvents:Lona/CaptureByOrkind1#{talk_style}")						#todo
				$cg.erase
				tmpPoint = check_PointsClosestRange(["FishkindCave1","FishkindCave2","FishkindCave3"])
				st_x,st_y,st_id=$game_map.get_storypoint(tmpPoint)
				$game_player.moveto(get_character(st_id).x,get_character(st_id).y)
				$story_stats["LastOverMapX"] = $game_player.x
				$story_stats["LastOverMapY"] = $game_player.y
				call_msg("OvermapEvents:Lona/Capture_arrived#{talk_style}")
				change_map_captured_enter_tag(tmpPoint)
				
		when "FishPPL"
				$story_stats["OnRegionMapSpawnRace"] = 0
				$story_stats["CapturedStatic"] =1
				$game_player.actor.morality_lona = 29 if $game_player.actor.morality_lona < 29
				call_msg("OvermapEvents:Lona/CaptureByFishPPL")
				if $game_player.actor.stat["SlaveBrand"] == 1
					$story_stats["SlaveOwner"] = "FishTownR"
					call_msg("OvermapEvents:Lona/CaptureByFishPPL_isSlave")
				else
					$game_player.actor.stat["EventExt1Race"] = "Fishkind"
					$game_player.actor.stat["EventExt1"] ="Grab"
					$story_stats["SlaveOwner"] = "FishTownR"
					call_msg("OvermapEvents:Lona/CaptureByFishPPL_NotSlave")
					$game_player.actor.mood = -100
					$game_player.actor.add_state("SlaveBrand") #51
					whole_event_end
				end
				tmpPoint = check_PointsClosestRange(["FishTownR"])
				$game_player.move_normal
				call_msg("OvermapEvents:Lona/CaptureByBandits1#{talk_persona}")
				$cg.erase
				st_x,st_y,st_id=$game_map.get_storypoint(tmpPoint)
				$game_player.moveto(get_character(st_id).x,get_character(st_id).y)
				$story_stats["LastOverMapX"] = $game_player.x
				$story_stats["LastOverMapY"] = $game_player.y
				call_msg("OvermapEvents:Lona/Capture_arrived#{talk_style}")
				portrait_off
				change_map_captured_enter_tag(tmpPoint)
				$story_stats["RapeLoopTorture"] =1
				
		when "HumanGuard" , "NobleGuards"
				$story_stats["OnRegionMapSpawnRace"] = 0
				$story_stats["CapturedStatic"] =1
				call_msg("OvermapEvents:Lona/CaptureByNoerGuard")					if $story_stats["SlaveOwner"] == 0
				call_msg("OvermapEvents:Lona/CaptureByNoerGuard_SlaveOwner")		if $story_stats["SlaveOwner"] != 0
				$game_player.move_normal
				$cg.erase
				st_x,st_y,st_id=$game_map.get_storypoint("NoerPrison") 					if $story_stats["SlaveOwner"] == 0
				st_x,st_y,st_id=$game_map.get_storypoint($story_stats["SlaveOwner"]) 	if $story_stats["SlaveOwner"] != 0
				$game_player.moveto(get_character(st_id).x,get_character(st_id).y)
				$story_stats["LastOverMapX"] = $game_player.x
				$story_stats["LastOverMapY"] = $game_player.y
				call_msg("OvermapEvents:Lona/Capture_arrived#{talk_style}")
				change_map_captured_enter_tag("NoerPrison") 							if $story_stats["SlaveOwner"] == 0
				change_map_captured_enter_tag($story_stats["SlaveOwner"]) 				if $story_stats["SlaveOwner"] != 0
				$story_stats["RapeLoopTorture"] =1
				$game_player.actor.morality_lona = 29 if $game_player.actor.stat["SlaveBrand"] == 1
				
		when "BanditMobs"
				$story_stats["OnRegionMapSpawnRace"] = 0
				$story_stats["CapturedStatic"] =1
				call_msg("OvermapEvents:Lona/CaptureByBandits0")
				$game_player.move_normal
				call_msg("OvermapEvents:Lona/CaptureByBandits1#{talk_persona}")
				$cg.erase
				
				
				tmpPoint = check_PointsClosestRange(["NoerMobHouse","BanditCamp1","BanditCamp2"])
				st_x,st_y,st_id=$game_map.get_storypoint(tmpPoint)
				$game_player.moveto(get_character(st_id).x,get_character(st_id).y)
				$story_stats["LastOverMapX"] = $game_player.x
				$story_stats["LastOverMapY"] = $game_player.y
				call_msg("OvermapEvents:Lona/Capture_arrived#{talk_style}")
				change_map_captured_enter_tag(tmpPoint)
				
		when "GangDebtCollet"
				$story_stats["OnRegionMapSpawnRace"] = 0
				$story_stats["CapturedStatic"] =1
				call_msg("OvermapEvents:Lona/CaptureByGang0")
				$game_player.move_normal
				call_msg("OvermapEvents:Lona/CaptureByGang1#{talk_persona}")
				call_msg("OvermapEvents:Lona/CaptureByGang2")
				$cg.erase
				posi2 = $game_map.get_storypoint("NoerBackStreet")
				$game_player.moveto(posi2[0],posi2[1])
				$story_stats["LastOverMapX"] = $game_player.x
				$story_stats["LastOverMapY"] = $game_player.y
				call_msg("OvermapEvents:Lona/Capture_arrived#{talk_style}")
				change_map_captured_enter_tag("NoerBackStreet")
				$story_stats["RapeLoop"]			=1
				$story_stats["RapeLoopTorture"]		=1
				$story_stats["SlaveOwner"]			="NoerBackStreet"
				$story_stats["Captured"]			=1
				
		when "AbomManager", "AbomSpider", "AbomBreedlingRaid", "AbomBreedlingTrap"
				$story_stats["OnRegionMapSpawnRace"] = 0
				$story_stats["CapturedStatic"] =1
				call_msg("OvermapEvents:Lona/CaptureByOrkind0")
				$game_player.move_normal
				call_msg("OvermapEvents:Lona/CaptureByOrkind1#{talk_style}")
				$cg.erase
				tmpPoint = check_PointsClosestRange(["AbomHive1","AbomHive2","AbomHive3"])
				st_x,st_y,st_id=$game_map.get_storypoint(tmpPoint)
				$game_player.moveto(get_character(st_id).x,get_character(st_id).y)
				$story_stats["LastOverMapX"] = $game_player.x
				$story_stats["LastOverMapY"] = $game_player.y
				call_msg("OvermapEvents:Lona/Capture_arrived#{talk_style}")
				change_map_captured_enter_tag(tmpPoint)
	end #case
end #def


#ENCOUNTER 生成物件 Encounter環境單位
def region_map_wildness_characters
	case $story_stats["OverMapEvent_name"]
		when "_bad_Vs_Refugee_Orkind"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "Orkind"
			$story_stats["RegionMap_Background"] = "OrkindMessy" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("Vs_Refugee_Orkind")
			
		when "_bad_OrkindPlayGround"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "Orkind"
			$story_stats["RegionMap_Background"] = "OrkindPlayGround" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("OrkindPlayGround")
			
		when "_bad_GobRaider"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "Orkind"
			$story_stats["RegionMap_Background"] = "OrkindMessy" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("GobRaider")
			
		when "_bad_OrkindCamp"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "Orkind"
			$story_stats["RegionMap_Background"] = "OrkindMessy" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("Orkind")
			
		when "_bad_FishkindGroup"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "Fishkind"
			$story_stats["RegionMap_Background"] = "FishkindMessy" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("Fishkind")
		
			
		when "_bad_FishPPL"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "FishPPL"
			$story_stats["RegionMap_Background"] = "FishkindMessy" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("FishPPL")
		
		when "_bad_UndeadWalking"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] += 1000
			$story_stats["OnRegionMapSpawnRace"] = "UndeadWalking"
			$story_stats["RegionMap_Background"] = "UndeadTrap" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("UndeadWalking")
			
		when "_good_Merchant"
			$story_stats["RegionMap_Background"] = "Merchant"
			posi1 = $game_map.region_map[7].sample
			temp_choice = rand(3)
			$game_map.reserve_summon_event("MerchantMedicine",posi1[0],posi1[1],-1) if temp_choice ==0
			$game_map.reserve_summon_event("MerchantWeaponry",posi1[0],posi1[1],-1) if temp_choice ==1
			$game_map.reserve_summon_event("MerchantFood",posi1[0],posi1[1],-1) if temp_choice ==2
			
		when "_bad_WolfGroup"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] += 1000
			$story_stats["OnRegionMapSpawnRace"] = "WolfGroup"
			$story_stats["RegionMap_Background"] = "FewRandomCropse" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("WolfGroup")
			
		when "_unknow_HumanGuard"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] =0
			$story_stats["OnRegionMapSpawnRace"] = "HumanGuard"
			$story_stats["RegionMap_Background"] = 0 if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("HumanGuard")
			
		when "_unknow_NobleGuards"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] =0
			$story_stats["OnRegionMapSpawnRace"] = "NobleGuards"
			$story_stats["RegionMap_Background"] = 0 if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("NobleGuards")
			
		when "_bad_BanditMobs"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "BanditMobs"
			$story_stats["RegionMap_Background"] = 0 if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("BanditMobs")
			
		when "_bad_GangDebtCollet"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "GangDebtCollet"
			$story_stats["RegionMap_Background"] = 0 if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("GangDebtCollet")
			
		when "_bad_CommonMobs"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "CommonMobs"
			$story_stats["RegionMap_Background"] = 0 if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("CommonMobs")
			
		when "_good_SosGiver"
			$story_stats["RapeLoop"] = 0
			$story_stats["WildDangerous"] =0
			$story_stats["OnRegionMapSpawnRace"] = 0
			$story_stats["RegionMap_Background"] = 0 if $story_stats["RegionMap_Background"] == 0
			get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
			get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
			quest_posi = [6]
			posiQ=$game_map.region_map[quest_posi[rand(quest_posi.length)]].sample
			$game_map.reserve_summon_event("#{$story_stats["OverMapEvent_SosName"]}",posiQ[0],posiQ[1],-1)
			4.times{
				posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
				$game_map.reserve_summon_event("RandomWildnessPPL",posi1[0],posi1[1],-1)
			}
		when "_Good_NoerMissionary"
			$story_stats["RapeLoop"] = 0
			$story_stats["WildDangerous"] =0
			$story_stats["OnRegionMapSpawnRace"] = 0
			$story_stats["RegionMap_Background"] = 0 if $story_stats["RegionMap_Background"] == 0
			get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
			get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
			posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
			$game_map.reserve_summon_event("EncNoerMissionary",posi1[0],posi1[1],-1)
			
		when "_Good_NoerHomeless"
			$story_stats["RapeLoop"] = 0
			$story_stats["WildDangerous"] =0
			$story_stats["OnRegionMapSpawnRace"] = 0
			$story_stats["RegionMap_Background"] = 0 if $story_stats["RegionMap_Background"] == 0
			get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
			get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
			4.times{
				posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
				$game_map.reserve_summon_event("EncNoerHolelessPPL",posi1[0],posi1[1])
			}
		when "_bad_AbomManager"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "AbomManager"
			$story_stats["RegionMap_Background"] = "AbomMessy" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("AbomManager")
			
		when "_bad_AbomSpider"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "AbomSpider"
			$story_stats["RegionMap_Background"] = "AbomSpiderMessy" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("AbomSpider")
			
		when "_bad_AbomBreedlingRaid"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = "AbomBreedlingRaid"
			$story_stats["RegionMap_Background"] = "AbomMessy" if $story_stats["RegionMap_Background"] == 0
			region_map_wildness_spawn("AbomBreedlingRaid")
			
		when "_Bad_RoadHalp"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] +=1000
			$story_stats["OnRegionMapSpawnRace"] = $story_stats["OverMapEvent_enemy"]
			$story_stats["RegionMap_Background"] = "RoadHalp"
			region_map_wildness_spawn($story_stats["OnRegionMapSpawnRace"])
			
		when "_good_RefugeeCamp"
			$story_stats["RapeLoop"] = 1
			$story_stats["WildDangerous"] =0
			$story_stats["OnRegionMapSpawnRace"] = "Refugee"
			$story_stats["RegionMap_Background"] = "RefugeeCamp"
			region_map_wildness_spawn($story_stats["OnRegionMapSpawnRace"])
			
		when "Custom"
			#[0,0,0,0,  #rapeloop,WildDanger,SpawnRape,BackGround
			#[[6],"EncNoerMissionary"], #QuestTarSpawn Region, EvLibSumName
			#[4,"RandomWildnessPPL"]
			#]
			
			data = $story_stats["OverMapEvent_SosName"]
			$story_stats["RapeLoop"] = data[0] ? data[0] : 0
			$story_stats["WildDangerous"] = data[1] ? data[1] : $story_stats["WildDangerous"]
			$story_stats["OnRegionMapSpawnRace"] = data[2] ? data[2] : 0
			$story_stats["RegionMap_Background"] = data[3] ? data[3] : 0
			get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
			get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
			if data[4]
				if data[4][2]
					quest_posi = data[4][2].sample
				else
					quest_posi = get_posi.sample
				end
				data[4][1].times{
					posiQ=$game_map.region_map[quest_posi].sample
					EvLib.sum(data[4][0],posiQ[0],posiQ[1])
				}
			end
			if data[5]
				if data[5][2]
					quest_posi = data[5][2].sample
				else
					quest_posi = get_posi.sample
				end
				data[5][1].times{
					posiQ=$game_map.region_map[quest_posi].sample
					EvLib.sum(data[5][0],posiQ[0],posiQ[1])
				}
			end
	end #case  $story_stats["OverMapEvent_name"]
end #def
	

#ENCOUNTER生成背景 
def region_map_wildness_background
	p "SummonEventGroup.wildness_background"
	if $story_stats["ReRollHalfEvents"] == 1
	return if $story_stats["RegionMap_RegionOuta"] == 0 || $story_stats["RegionMap_RegionInsa"] == 0
	case $story_stats["RegionMap_Background"]
	when "OrkindPlayGround";
					posiRES0,posiRES1	=$game_map.region_map[7].sample
					EvLib.sum("PlayGroundCorpses",posiRES0,posiRES1)
					EvLib.sum("Hp3DedPiller#{rand(8)}",posiRES0+1,posiRES1+1)
					EvLib.sum("Hp3DedPiller#{rand(8)}",posiRES0-1,posiRES1+1)
					EvLib.sum("Hp3DedPiller#{rand(8)}",posiRES0+1,posiRES1-1)
					EvLib.sum("Hp3DedPiller#{rand(8)}",posiRES0-1,posiRES1-1)
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					tmpEVname = ["Bg_BBQ_HumanM","Bg_BBQ_HumanF","Bg_BBQ_AbomBreedling","Bg_BBQ_Goblin"].sample
					EvLib.sum(tmpEVname,posi[0],posi[1])
					10.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticWaste",posi[0],posi[1])
					}
					3.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("Hp3DedHeads#{rand(2)}",posi[0],posi[1])
					}
					3.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("DedGills#{rand(4)}",posi[0],posi[1],{:death_event=>"SeedBedOrkindBabyGroup"})
					}
					3.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("Hp3DedPiller#{rand(8)}",posi[0],posi[1])
					}
					5.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("Hp3OrkTotem#{rand(5)}",posi[0],posi[1])
					}
	when "OrkindMessy";
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("StaticCampFire",posi[0],posi[1])
					
					3.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticCropse",posi[0],posi[1])
					}
					
					10.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticWaste",posi[0],posi[1])
					}
		when "FishkindMessy";
					10.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticFish",posi[0],posi[1])
					}
					4.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticFish",posi[0],posi[1])
					}
		when "UndeadTrap"
					8.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("UndeadHideTrap",posi[0],posi[1])
					}
					2.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi	= posi.sample
					EvLib.sum("UndeadHideTrap",posi[0],posi[1])
					}
		when "FewRandomCropse"
					3.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticCropse",posi[0],posi[1])
					}
		when "AbandonedCropses"
					posiRES0,posiRES1	=$game_map.region_map[7].sample
					EvLib.sum("AbandonedCorpses",posiRES0,posiRES1)
					2.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi	= posi.sample
					EvLib.sum("UndeadHideTrap",posi[0],posi[1])
					}
					3.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticWaste",posi[0],posi[1])
					}
		when "AbandonedResources"
					posiRES0,posiRES1	=$game_map.region_map[7].sample
					EvLib.sum("AbandonedResources",posiRES0,posiRES1)
					4.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticWaste",posi[0],posi[1])
					}
		when "HumanCamp"
					posiRES0,posiRES1	=$game_map.region_map[7].sample
					$game_map.reserve_summon_event("BG_Tent3x3_#{rand(4)+1}",posiRES0,posiRES1,-1)
					posi5	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi5	= posi5.sample
					$game_map.reserve_summon_event("StaticCampFire",posi5[0],posi5[1],-1)
					4.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticWaste",posi[0],posi[1])
					}
		when "DestroyedHumanCamp"
					posiRES0,posiRES1	=$game_map.region_map[7].sample
					posi1	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi1	= posi1.sample
					$game_map.reserve_summon_event("BG_Tent3x3_#{rand(4)+1}",posiRES0,posiRES1,-1)
					$game_map.reserve_summon_event("StaticCampFire",posi1[0],posi1[1],-1)
					3.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticCropse",posi[0],posi[1])
					}
					5.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticWaste",posi[0],posi[1])
					}
					5.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticWaste",posi[0],posi[1])
					}
		when "OpenCamp"
					posiRES0,posiRES1	=$game_map.region_map[5].sample
					$game_map.reserve_summon_event("OpenCamp",posiRES0,posiRES1,-1)
					4.times{
					posi	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi	= posi.sample
					EvLib.sum("RandomStaticWaste",posi[0],posi[1])
					}
		when "AbomMessy"
					4.times{
					posi1	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi1	= posi1.sample
					$game_map.reserve_summon_event("AbomWall#{rand(3)}",posi1[0],posi1[1]) #rng 0~2,  3 is dungeon only
					}
		when "AbomSpiderMessy"
					12.times{
					posi1	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi1	= posi1.sample
					$game_map.reserve_summon_event("AbomCreatureSpiderHideTrap",posi1[0],posi1[1])
					}
		when "RoadHalp"
					get_posi = $story_stats["RegionMap_RegionOuta"] if $story_stats["OverMapEvent_saw"] == 0
					get_posi = $story_stats["RegionMap_RegionInsa"] if $story_stats["OverMapEvent_saw"] == 1
					posi1=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
					posi2=$game_map.region_map[get_posi[rand(get_posi.length)]].sample
					$game_map.reserve_summon_event("EncHomelessPPL1",posi1[0],posi1[1])
					$game_map.reserve_summon_event("QuestGiverRoadHalp",posi2[0],posi2[1])
					
		when "RefugeeCamp"
					posiRES0_X,posiRES0_Y	=$game_map.region_map[7].sample
					posiRES1_X,posiRES1_Y	=$game_map.region_map[6].sample
					posiRES2_X,posiRES2_Y	=$game_map.region_map[5].sample
					$game_map.reserve_summon_event("CampFireActive",posiRES0_X,posiRES0_Y)
					$game_map.reserve_summon_event("EncRefugeeMIdle_D6",posiRES0_X-1,posiRES0_Y)
					$game_map.reserve_summon_event("EncRefugeeMIdle_D4",posiRES0_X+1,posiRES0_Y)
					$game_map.reserve_summon_event("EncRefugeeMIdle_D2",posiRES0_X,posiRES0_Y-1)
					$game_map.reserve_summon_event("EncRefugeeMIdle_D8",posiRES0_X,posiRES0_Y+1)
					
					$game_map.reserve_summon_event("RefugeeTent0",posiRES1_X,posiRES1_Y-1)
					$game_map.reserve_summon_event("EncRefugeeCampVandor",posiRES1_X,posiRES1_Y)
					
					$game_map.reserve_summon_event("RefugeeTent1",posiRES2_X,posiRES2_Y-1)
					$game_map.reserve_summon_event("PlayerPot",posiRES2_X,posiRES2_Y)
					$game_map.reserve_summon_event("EncRefugeeMIdle_D6",posiRES2_X-1,posiRES2_Y)
					$game_map.reserve_summon_event("EncRefugeeMIdle_D4",posiRES2_X+1,posiRES2_Y)
					
					
					4.times{
					posi1	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi1	= posi1.sample
					$game_map.reserve_summon_event("RandomStaticWaste",posi1[0],posi1[1],-1)
					}
					2.times{
					posi1	=$game_map.region_map[$story_stats["RegionMap_RegionOuta"].sample]		;posi1	= posi1.sample
					$game_map.reserve_summon_event("StaticCampFire",posi1[0],posi1[1],-1)
					}
					2.times{
					posi1	=$game_map.region_map[$story_stats["RegionMap_RegionInsa"].sample]		;posi1	= posi1.sample
					$game_map.reserve_summon_event("Clotheshorse",posi1[0],posi1[1],-1)
					}
					
		end #case $story_stats["OverMapEvent_name"]
	end #if $story_stats["ReRollHalfEvents"] ==1 
	$story_stats["RegionMap_Background"] = 0
end#def


#此處為睡著時被綁架的管理
def region_map_wildness_nap(tmpForce=nil)
	$game_portraits.lprt.hide
	check_enemy_survival? if !tmpForce
	$story_stats["RapeLoop"] = 1 if tmpForce
	if $story_stats["RapeLoop"] == 1# || tmpForce
		$story_stats["Kidnapping"] = 0
		if tmpForce
			tmpRace = tmpForce
			$story_stats["OnRegionMapSpawnRace"] = tmpRace
		else
			tmpRace = $story_stats["OnRegionMapSpawnRace"]
		end
		case tmpRace
			when "Orkind", "OrkindPlayGround"
					$story_stats["Captured"] =1
					rape_loop_drop_item(false,false)
					call_msg("OvermapEvents:Lona/WildnessNapRobber0")
					call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
					$story_stats["Kidnapping"] = 1
					load_script("Data/HCGframes/event/OrkindCave_NapGangRape.rb")
						
			when "Fishkind"
					$story_stats["Captured"] =1
					rape_loop_drop_item(false,false)
					call_msg("OvermapEvents:Lona/WildnessNapRobber0")
					call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
					$story_stats["Kidnapping"] = 1
					load_script("Data/HCGframes/event/FishkindCave_NapGangRape.rb")
						
			when "FishPPL"
					$story_stats["Captured"] =1
					rape_loop_drop_item(false,false)
					call_msg("OvermapEvents:Lona/WildnessNapRobber0")
					call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
					load_script("Data/Batch/Put_HeavyestBondage.rb") #上銬批次檔
					$story_stats["Kidnapping"] = 1
					#call_msg("OvermapEvents:Lona/CaptureByFishPPL_rape")
					#portrait_hide
					#load_script("Data/HCGframes/event/FishkindCave_NapGangRape.rb")
						
			when "HumanGuard"
					if $game_player.actor.morality < 30 || $game_player.actor.stat["SlaveBrand"] == 1
						$story_stats["Captured"] =1
						rape_loop_drop_item(false,false)
						call_msg("OvermapEvents:Lona/WildnessNapRobber0")
						call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
						load_script("Data/Batch/Put_HeavyestBondage.rb") #上銬批次檔
						$story_stats["Kidnapping"] = 1
					else
						$story_stats["RapeLoop"] = 0
						$story_stats["WildDangerous"] = 0
						$story_stats["OnRegionMapSpawnRace"] = 0
						$story_stats["OverMapEvent_name"] = 0
						$story_stats["RegionMap_Background"] = 0
						handleNap
					end
						
			when "NobleGuards"
					$story_stats["Captured"] =1
					rape_loop_drop_item(false,false)
					call_msg("OvermapEvents:Lona/WildnessNapRobber0")
					call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
					
					$game_player.actor.morality_lona = 45 if $game_player.actor.morality_lona > 45
					load_script("Data/Batch/Put_HeavyestBondage.rb") #上銬批次檔
					$story_stats["Kidnapping"] = 1

					
			when "BanditMobs","GangDebtCollet"
					$story_stats["Captured"] =1
					rape_loop_drop_item(false,false)
					call_msg("OvermapEvents:Lona/WildnessNapRobber0")
					call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
					load_script("Data/Batch/Put_HeavyestBondage.rb") #上銬批次檔
					$story_stats["Kidnapping"] = 1
					
			when "CommonMobs","Refugee"
					rape_loop_drop_item(false,false)
					call_msg("OvermapEvents:Lona/WildnessNapRobber0")
					call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
					$story_stats["RapeLoop"] = 0
					$story_stats["WildDangerous"] = 0
					$story_stats["OnRegionMapSpawnRace"] = 0
					$story_stats["OverMapEvent_name"] = 0
					$story_stats["RegionMap_Background"] = 0
					handleNap
					
					
			when "UndeadWalking"
					SndLib.bgm_stop
					SndLib.bgs_stop
					portrait_hide
					chcg_background_color(20,0,0,0,2)
					12.times{
						$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
						SndLib.sound_UndeadQuestion if rand(100) >= 50
						SndLib.sound_gore(100)
						SndLib.sound_combat_hit_gore(70)
						wait(20+rand(20))
					}
					chcg_background_color(0,0,0,255)
					call_msg("commonEnding:undead/Eaten")
					return load_script("Data/HCGframes/OverEvent_Death.rb")
					
			when "FishFemale"
					SndLib.bgm_stop
					SndLib.bgs_stop
					portrait_hide
					chcg_background_color(20,0,0,0,2)
					12.times{
						$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
						SndLib.FishkindSmSkill if rand(100) >= 50
						SndLib.sound_gore(100)
						SndLib.sound_combat_hit_gore(70)
						wait(20+rand(20))
					}
					chcg_background_color(0,0,0,255)
					#call_msg("commonEnding:undead/Eaten")
					return load_script("Data/HCGframes/OverEvent_Death.rb")
					
			when "WolfGroup"
					SndLib.bgm_stop
					SndLib.bgs_stop
					chcg_background_color(20,0,0,0,2)
					
					12.times{
						$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
						SndLib.dogSpot(100) if rand(100) >=60
						SndLib.dogAtk(100) if rand(100) >=60
						SndLib.sound_gore(100)
						SndLib.sound_combat_hit_gore(70)
						wait(20+rand(20))
					}
					chcg_background_color(0,0,0,255)
					call_msg("commonEnding:wolf/Eaten")
					return load_script("Data/HCGframes/OverEvent_Death.rb")
					
			when "AbomManager", "AbomSpider", "AbomBreedlingRaid"
						$story_stats["Captured"] =1
						rape_loop_drop_item(false,false)
						call_msg("OvermapEvents:Lona/WildnessNapRobber0")
						call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
						$story_stats["Kidnapping"] = 1
						load_script("Data/HCGframes/event/AbomHive_NapGangRape.rb")
						
			when "AbomBreedlingRaid", "AbomBreedlingTrap"
						$story_stats["Captured"] =1
						rape_loop_drop_item(false,false)
						call_msg("OvermapEvents:Lona/WildnessNapRobber0")
						call_msg("OvermapEvents:Lona/WildnessNapRobber1#{talk_style}")
						$story_stats["Kidnapping"] = 1

			when "AbomBat"
					SndLib.bgm_stop
					SndLib.bgs_stop
					portrait_hide
					chcg_background_color(20,0,0,0,2)
					12.times{
						$game_map.interpreter.flash_screen(Color.new(255,0,0,200),8,true)
						SndLib.AbomBatAtk if rand(100) >= 50
						SndLib.sound_gore(100)
						SndLib.sound_combat_hit_gore(70)
						wait(20+rand(20))
					}
					chcg_background_color(0,0,0,255)
					call_msg("commonEnding:undead/Eaten")
					return load_script("Data/HCGframes/OverEvent_Death.rb")
						
	##########################################################################################################
						#load_script("Data/HCGframes/event/OrkindCave_NapGangRape.rb")
	##########################################################################################################
	
			end #case race
	else
		region_map_wildness_nap_stats if $story_stats["OnRegionMap"] >=1
		handleNap#normal nap
	end
	######################################
	
	$game_player.actor.set_action_state(:none)
	if $story_stats["Kidnapping"] ==1
		$story_stats["Setup_Hardcore"] >= 1 ? $story_stats["WorldDifficulty"] -= 13 : $story_stats["WorldDifficulty"] -= 22
		$story_stats["WorldDifficulty"] = 0 if $story_stats["WorldDifficulty"] < 0
		change_map_captured_leave_region
	else
	#region_map_wildness_spawn if $story_stats["OnRegionMap"] >=1
	call_msg("OvermapEvents:Lona/WildnessNapSpawn") if $story_stats["RapeLoop"] ==1
	end
end #def

def check_enemy_survival?(tmpRace=$story_stats["OnRegionMapSpawnRace"],tmpWrite=true) #use to check if player clearn entire map? and no contect mobs? and nap again should not trigger events.
	tmpResult = $game_map.npcs.any?{
				|event|
				next if !event.summon_data
				next if event.actor.action_state == :death
				next if event.actor.action_state == :stun
				next if event.npc.stat.get_stat("sta") <= 0
				event.summon_data[:WildnessNapEvent] == tmpRace
				}
	if !tmpResult && tmpWrite
		$story_stats["OnRegionMapSpawnRace"] =0
		$story_stats["OverMapEvent_name"] = 0
		$story_stats["WildDangerous"] -= 50		; $story_stats["WildDangerous"] = 0 if 0 > $story_stats["WildDangerous"]
		$story_stats["RapeLoop"] = 0
		$story_stats["Kidnapping"] = 0
	end
	p "check_enemy_survival? => #{tmpResult}"
	tmpResult
end

def check_PointsClosestRange(target=["a,b,c"])
	tmpTarPoint = []
	target.each { |tmpPoint|
	tmpPointID=$game_map.get_storypoint(tmpPoint)[2]
	tmpTarPoint << [get_character(tmpPointID).report_range,tmpPoint]
	}
	tmpTarPoint = tmpTarPoint.min
	tmpTarPoint[1]
end

def check_GangDebtCollet #檢查貸款用
	return false if $DEMO
	#return false if $story_stats["UniqueCharUniqueGangBoss"] == -1
	#return false if $story_stats["UniqueCharUniqueHappyMerchant"] == -1
	return true if $story_stats["SlaveOwner"] == "NoerBackStreet"
	return false if $story_stats["BackStreetArrearsPrincipal"] <= 0
	return false if $story_stats["BackStreetArrearsPrincipal"] > $story_stats["BackStreetArrearsInterest"]
	return true
end

def check_HitchhikerTrait
	return $game_player.actor.stat["Hitchhiker"] == 1
end

end #module
