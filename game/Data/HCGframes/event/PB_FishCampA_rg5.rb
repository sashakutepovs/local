tmpFriendly = false
if $story_stats["RecQuestAriseVillageFish"] == 1 && $game_player.record_companion_name_ext == "AriseVillageCompExtConvoy"
	tmpQuTarX,tmpQuTarY,tmpQuTarID = $game_map.get_storypoint("QuTar")
	tmpCorpseX,tmpCorpseY,tmpCorpseID = $game_map.get_storypoint("Corpse")
	tmpFishExplorerX,tmpFishExplorerY,tmpFishExplorerID = $game_map.get_storypoint("FishExplorer")
	tmpFollower=$game_player.get_followerID(-1)
	$story_stats["RecQuestAriseVillageFish"] = 2
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		get_character(tmpCorpseID).call_balloon(0)
		get_character(tmpFollower).set_this_companion_disband
		$game_player.moveto(tmpCorpseX+1,tmpCorpseY)
		$game_player.direction = 4
		get_character(tmpQuTarID).moveto(tmpCorpseX+1,tmpCorpseY-6)
		get_character(tmpFishExplorerID).moveto(tmpCorpseX-1,tmpCorpseY)
		get_character(tmpFishExplorerID).direction = 6
		get_character(tmpFishExplorerID).opacity = 255
		get_character(tmpQuTarID).npc_story_mode(true)
		get_character(tmpFishExplorerID).npc_story_mode(true)
		cam_follow(tmpCorpseID,0)
	chcg_background_color(0,0,0,255,-7)
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_0") ; portrait_hide
	3.times{
		get_character(tmpQuTarID).direction = 2 ; get_character(tmpQuTarID).move_forward_force ; wait(35)
	}
	get_character(tmpQuTarID).animation = get_character(tmpQuTarID).animation_atk_shoot_hold
	SndLib.sound_shield_up
	$game_player.direction = 8
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_1")
	get_character(tmpFishExplorerID).jump_to($game_player.x,$game_player.y-1) ; get_character(tmpFishExplorerID).direction = 8
	SndLib.sound_Stomp
	get_character(tmpQuTarID).call_balloon(8)
	wait(60)
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_2") ; portrait_hide
	get_character(tmpQuTarID).animation = nil
	get_character(tmpQuTarID).jump_to(get_character(tmpQuTarID).x,get_character(tmpQuTarID).y)
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_3")
	SndLib.sound_equip_armor
	get_character(tmpQuTarID).animation = get_character(tmpQuTarID).animation_grabber_qte(tmpFishExplorerID)
	get_character(tmpFishExplorerID).animation = get_character(tmpFishExplorerID).animation_grabber_qte(tmpQuTarID)
	
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_4")
	
	portrait_hide
	chcg_background_color(0,0,0,0,7)
		portrait_off
		cam_center(0)
		$game_player.moveto(tmpFishExplorerX+1,tmpFishExplorerY)
		$game_player.direction = 4
		get_character(tmpFishExplorerID).direction = 6
		get_character(tmpQuTarID).animation = nil
		get_character(tmpFishExplorerID).animation = nil
		get_character(tmpFishExplorerID).moveto(tmpFishExplorerX,tmpFishExplorerY)
		#get_character(tmpFishExplorerID).call_balloon(28,-1)
		get_character(tmpQuTarID).moveto(tmpQuTarX,tmpQuTarY)
		get_character(tmpQuTarID).direction = 4
		get_character(tmpQuTarID).npc_story_mode(false)
	chcg_background_color(0,0,0,255,-7)
	get_character(tmpFishExplorerID).direction = 6
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_5")
	get_character(tmpFishExplorerID).animation = get_character(tmpFishExplorerID).animation_atk_mh
	optain_item($data_items[51],4)
	wait(30)
	optain_exp(5000)
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_6")
	get_character(tmpQuTarID).direction = 2
	$game_player.direction = 8
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_7") ; portrait_hide
	$game_player.direction = 4
	call_msg("TagMapPB_FishCampA:AriseVillage/1to2_rg5_8")
	
	get_character(tmpQuTarID).npc_story_mode(false)
	get_character(tmpFishExplorerID).npc_story_mode(false)
	get_character(tmpQuTarID).direction = 4
	get_character(tmpFishExplorerID).direction = 8
	get_character(tmpFishExplorerID).call_balloon(28,-1) if $story_stats["RecQuestAriseVillageFish"] == 2
	cam_center(0)
	eventPlayEnd
end
get_character(0).erase