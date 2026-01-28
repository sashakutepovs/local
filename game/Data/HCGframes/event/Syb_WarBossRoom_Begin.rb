

$game_system.add_mail("Syb_WarBossRoom")
p "########## BIOS AUTORUN SETUP ##########"
$game_map.set_fog("cave_fall")
map_background_color(80,80,200,40,0)
$game_map.shadows.set_color(0, 0, 0)
$game_map.shadows.set_opacity(255)
SndLib.bgs_play("D/ATMO EERIE Cave, Water Drips, Emptyness, Howling Interior Wind, Oppressive, LOOP",50)
SndLib.bgm_play("D/WarBossKeep-Keep-18 - tomb loop",70)
if $story_stats["UniqueCharUniqueOgreWarBoss"] != -1
	
	tmpOgreWarBossX,tmpOgreWarBossY,tmpOgreWarBossID = $game_map.get_storypoint("OgreWarBoss")
	tmpWarbossEV = get_character(tmpOgreWarBossID)
	if $story_stats["RapeLoop"] == 1
		tmpWarbossEV.actor.player_control_mode(on_off=true,canUseSkill=true)
		tmpWarbossEV.actor.shieldEV = $game_player
		$game_player.actor.is_object = true
		$game_player.actor.is_a_ProtectShield = true
		$game_player.actor.sta = 100 if $game_player.actor.sta < 100
		$game_player.transparent = true
		$game_player.opacity = 0
	end
end
enter_static_tag_map(nil,true) if $story_stats["ReRollHalfEvents"] == 1
summon_companion
eventPlayEnd
cam_follow(tmpOgreWarBossID,0) if $story_stats["RapeLoop"] == 1 && $story_stats["UniqueCharUniqueOgreWarBoss"] != -1
$game_player.opacity = 255 if $game_player.opacity == 0
get_character(0).erase
