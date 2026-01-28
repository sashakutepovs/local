
if $story_stats["tmpData"] == "WarBossRapeLoop" && $story_stats["UniqueCharUniqueOgreWarBoss"] != -1
	$story_stats["tmpData"] = nil
	$story_stats["RapeLoop"] = 1
end
p "########## BIOS AUTORUN SETUP ##########"
$game_map.set_fog("cave_fall")
map_background_color(80,80,200,40,0)
SndLib.bgs_play("Cave/Cavern Sound effect_Short",50)

if $story_stats["RapeLoop"] == 1 && $story_stats["UniqueCharUniqueOgreWarBoss"] != -1
	tmpDedGillsPile0ID = $game_map.get_storypoint("DedGillsPile0")[2]
	tmpOgreWarBossID = $game_map.get_storypoint("OgreWarBoss")[2]
	tmpSTptTopX,tmpSTptTopY,tmpSTptTopID = $game_map.get_storypoint("STptTop")
	get_character(tmpDedGillsPile0ID).call_balloon(28,-1)
	SndLib.bgm_play("CB_Danger LOOP",80,100)
	#GoblinSlaveSpear
	
	
	tmpWarbossEV = get_character(tmpOgreWarBossID)
	tmpWarbossEV.actor.player_control_mode(on_off=true,canUseSkill=true)
	tmpWarbossEV.actor.shieldEV = $game_player
	$game_player.actor.is_object = true
	$game_player.actor.is_a_ProtectShield = true
	$game_player.transparent = true
	$game_player.opacity = 0
	
	
	tmpWarbossEV.moveto(tmpSTptTopX,tmpSTptTopY)
	tmpWarbossEV.direction = 2
	EvLib.sum("GoblinSlaveSpear",tmpSTptTopX-1,tmpSTptTopY,{:master=>tmpWarbossEV})
	EvLib.sum("GoblinSlaveBow",tmpSTptTopX+1,tmpSTptTopY,{:master=>tmpWarbossEV})
	$game_map.shadows.set_color(0, 0, 0)
	$game_map.shadows.set_opacity(180)
end

fadeout=$story_stats["ReRollHalfEvents"] == 1
enter_static_tag_map(nil,fadeout) if $story_stats["ReRollHalfEvents"] == 1
summon_companion
eventPlayEnd
get_character(0).erase

