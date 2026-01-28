

tmpDualBiosID=$game_map.get_storypoint("DualBios")[2]
tmpBossX,tmpBossY,tmpBossID=$game_map.get_storypoint("Boss")
tmpBossAtkX,tmpBossAtkY,tmpBossAtkID=$game_map.get_storypoint("BossAtk")
tmpTrapGuardX,tmpTrapGuardY,tmpTrapGuardID=$game_map.get_storypoint("TrapGuard")
tmpHouse2InX,tmpHouse2InY,tmpHouse2InID=$game_map.get_storypoint("House2In")
tmpCHK = $story_stats["SMCloudVillage_KillTheKid"] == 2 && $story_stats["SMCloudVillage_Aggroed"] == 0 && $story_stats["UniqueCharSMCloudVillage_Boss"] != -1

if tmpCHK
	if $story_stats["UniqueCharSMCloudVillage_Boss"] != -1
		get_character(tmpBossID).npc_story_mode(true)
		get_character(tmpTrapGuardID).npc_story_mode(true)
		tmpBoss_tmpX = get_character(tmpBossID).x
		tmpBoss_tmpY = get_character(tmpBossID).y
	end
	if $story_stats["UniqueCharSMCloudVillage_BossAtk"] != -1
		get_character(tmpBossAtkID).npc_story_mode(true)
		tmpBossAtk_tmpX = get_character(tmpBossAtkID).x
		tmpBossAtk_tmpY = get_character(tmpBossAtkID).y
	end
	
	$game_player.call_balloon(8)
	wait(60)
	2.times{
		$game_player.direction = 8 ; $game_player.move_forward_force
		$game_player.move_speed = 2.8
		until !$game_player.moving? ; wait(1) end
	}
	$game_player.call_balloon(8)
	$game_player.direction = 4
	wait(60)
	$game_player.call_balloon(8)
	$game_player.direction = 6
	wait(60)
	$game_player.direction = 2
	call_msg("TagMapSMCloudVillage:Boss/Trap1")
	portrait_hide
	SndLib.bgm_play("D/Hidden Assault LOOP",70,100)
	if $story_stats["UniqueCharSMCloudVillage_BossAtk"] != -1
		get_character(tmpBossAtkID).moveto(tmpHouse2InX,tmpHouse2InY)
		get_character(tmpBossAtkID).opacity = 0
		get_character(tmpBossAtkID).effects=["FadeIn",0,false,nil,nil,nil]
		until get_character(tmpBossAtkID).opacity >= 255 ; wait(1) end
		1.times{
			get_character(tmpBossAtkID).direction = 8 ; get_character(tmpBossAtkID).move_forward_force
			get_character(tmpBossAtkID).move_speed = 3
			until !get_character(tmpBossAtkID).moving? ; wait(1) end
		}
		1.times{
			get_character(tmpBossAtkID).direction = 4 ; get_character(tmpBossAtkID).move_forward_force
			get_character(tmpBossAtkID).move_speed = 3
			until !get_character(tmpBossAtkID).moving? ; wait(1) end
		}
		get_character(tmpBossAtkID).direction = 8
	end
	if $story_stats["UniqueCharSMCloudVillage_Boss"] != -1
		get_character(tmpTrapGuardID).moveto(tmpHouse2InX,tmpHouse2InY)
		get_character(tmpTrapGuardID).opacity = 0
		get_character(tmpTrapGuardID).effects=["FadeIn",0,false,nil,nil,nil]
		until get_character(tmpTrapGuardID).opacity >= 255 ; wait(1) end
		1.times{
			get_character(tmpTrapGuardID).direction = 8 ; get_character(tmpTrapGuardID).move_forward_force
			get_character(tmpTrapGuardID).move_speed = 3
			until !get_character(tmpTrapGuardID).moving? ; wait(1) end
		}
		1.times{
			get_character(tmpTrapGuardID).direction = 6 ; get_character(tmpTrapGuardID).move_forward_force
			get_character(tmpTrapGuardID).move_speed = 3
			until !get_character(tmpTrapGuardID).moving? ; wait(1) end
		}
		get_character(tmpTrapGuardID).direction = 8
		
		get_character(tmpBossID).opacity = 0
		get_character(tmpBossID).moveto(tmpHouse2InX,tmpHouse2InY)
		get_character(tmpBossID).effects=["FadeIn",0,false,nil,nil,nil]
		get_character(tmpBossID).direction = 8
		until get_character(tmpBossID).opacity >= 255 ; wait(1) end
		#1.times{
		#	get_character(tmpBossID).direction = 8 ; get_character(tmpBossID).move_forward_force
		#	get_character(tmpBossID).move_speed = 3
		#	until !get_character(tmpBossID).moving? ; wait(1) end
		#}
	end
	
	
	
	
	if $story_stats["UniqueCharSMCloudVillage_BossAtk"] != -1
		get_character(tmpBossAtkID).npc_story_mode(false)
		get_character(tmpBossAtkID).npc.fucker_condition={"sex"=>[0, "="]}
		get_character(tmpBossAtkID).npc.killer_condition={"weak"=>[10, "<"]}
		get_character(tmpBossAtkID).npc.assaulter_condition={"weak"=>[9, ">"]}
		get_character(tmpBossAtkID).npc.remove_skill("killer","NpcMarkMoralityUp")
		get_character(tmpBossAtkID).npc.remove_skill("assaulter","NpcMarkMoralityUp")
		get_character(tmpBossAtkID).npc.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],30)
	end
	if $story_stats["UniqueCharSMCloudVillage_Boss"] != -1
		get_character(tmpBossID).npc_story_mode(false)
		#get_character(tmpBossID).npc.add_fated_enemy([0])
		get_character(tmpBossID).npc.remove_skill("killer","NpcMarkMoralityUp")
		get_character(tmpBossID).npc.remove_skill("assaulter","NpcMarkMoralityUp")
		get_character(tmpBossID).npc.fucker_condition={"weak"=>[50, ">"],"sex"=>[0, "="]}
		get_character(tmpBossID).npc.killer_condition={"sex"=>[65535, "="]}
		get_character(tmpBossID).npc.assaulter_condition={"sex"=>[65535, "="]}
		get_character(tmpTrapGuardID).npc_story_mode(false)
		get_character(tmpTrapGuardID).npc.fucker_condition={"weak"=>[50, ">"],"sex"=>[0, "="]}
		get_character(tmpTrapGuardID).npc.killer_condition={"weak"=>[10, "<"]}
		get_character(tmpTrapGuardID).npc.assaulter_condition={"weak"=>[9, ">"]}
		get_character(tmpTrapGuardID).npc.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],30)
		get_character(tmpTrapGuardID).npc.remove_skill("killer","NpcMarkMoralityUp")
		get_character(tmpTrapGuardID).npc.remove_skill("assaulter","NpcMarkMoralityUp")
	end
	call_msg("TagMapSMCloudVillage:Boss/Trap2")
	call_msg("TagMapSMCloudVillage:Boss/Trap_ATKboss_alive") if $story_stats["UniqueCharSMCloudVillage_BossAtk"] != -1
	call_msg("TagMapSMCloudVillage:Boss/Trap3")
	
end
tmpAggroID=$game_map.get_storypoint("aggro")[2]
get_character(tmpAggroID).start
eventPlayEnd
get_character(0).erase