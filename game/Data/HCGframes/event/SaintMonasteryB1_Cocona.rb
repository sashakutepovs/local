return if $story_stats["RecQuestCocona"] != 16
return if $story_stats["UniqueCharUniqueCocona"] == -1
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
get_character(0).call_balloon(0)
tmpC15Cx,tmpC15Cy,tmpC15Cid=$game_map.get_storypoint("C15Cocona")

call_msg("CompCocona:cocona/RecQuestCocona_16_0")
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	get_character(0).npc_story_mode(true)
	get_character(0).animation = nil
	get_character(0).turn_toward_character($game_player)
	set_event_force_page(get_character(0).id,3)
	if $story_stats["RecQuestCoconaVagTaken"] == 1
		get_character(0).character_index = 3
	end
	SndLib.sound_equip_armor
	get_character(0).turn_toward_character($game_player)
	get_character(0).npc_story_mode(false)
chcg_background_color(0,0,0,255,-7)

#virgin check
call_msg("CompCocona:cocona/RecQuestCocona_16_1")
if $story_stats["RecQuestCoconaVagTaken"] == 1
	$game_temp.choice = -1
	$game_player.actor.stat["Prostitute"] == 1 ? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
	call_msg("CompCocona:cocona/RecQuestCocona_16_2_Lost") #[重要的人,重要的物<r=HiddenOPT0>]
	if $game_temp.choice == 0
		call_msg("CompCocona:cocona/RecQuestCocona_16_2_LostAns_pure") #非處 但依然以處女為主
	else
		call_msg("CompCocona:cocona/RecQuestCocona_16_2_LostAns_NoPure") #非處 接受物件交換
		$story_stats["RecQuestCoconaVagTaken"] = 2
	end
	call_msg("CompCocona:cocona/RecQuestCocona_16_2_LostAns_end")

# still virgin
else
	call_msg("CompCocona:cocona/RecQuestCocona_16_2_NoLost")
	$story_stats["RecQuestCoconaVagTaken"] = -1
end
portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	$story_stats["Captured"] = 0
	get_character($game_player.get_followerID(0)).set_this_companion_disband if $game_player.get_followerID(0) != nil
	get_character(0).delete
	$game_map.reserve_summon_event("UniqueCoconaMaid",tmpC15Cx,tmpC15Cy)
	wait(5)
	get_character($game_player.get_followerID(0)).npc.stat.set_stat_m("sta",0,[0]) if $story_stats["RecQuestCoconaVagTaken"] >= 1
	$story_stats["RapeLoop"] =1
	$story_stats["RapeLoopTorture"] =1
	$story_stats["Captured"] =1
chcg_background_color(0,0,0,255,-7)

call_msg("CompCocona:cocona/RecQuestCocona_16_3")
call_msg("CompCocona:cocona/RecQuestCocona_16_4")

$story_stats["RecQuestCocona"] = 17
eventPlayEnd