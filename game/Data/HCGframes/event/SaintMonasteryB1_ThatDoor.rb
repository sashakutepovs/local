tmpQ1 = $story_stats["RecQuestCocona"] != 15
tmpQ2 = $story_stats["UniqueCharUniqueCocona"] == -1
if tmpQ1 || tmpQ2
	SndLib.sys_DoorLock
	call_msg_popup("TagMapNoerCatacomb:Necropolis/Locked#{rand(2)}")
	return
end
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

tmpSEX =false
get_character(0).call_balloon(0)
tmpC15Px,tmpC15Py,tmpC15Pid=$game_map.get_storypoint("C15Priest")
tmpC15Cx,tmpC15Cy,tmpC15Cid=$game_map.get_storypoint("C15Cocona")
get_character(tmpC15Pid).npc_story_mode(true)
get_character(tmpC15Cid).npc_story_mode(true)
cam_follow(tmpC15Pid,0)
call_msg("CompCocona:cocona/RecQuestCocona_15_0_0")
get_character(tmpC15Pid).jump_to(get_character(tmpC15Pid).x,get_character(tmpC15Pid).y)
call_msg("CompCocona:cocona/RecQuestCocona_15_0_1")
portrait_hide
get_character(tmpC15Pid).move_forward_force
wait(35)
get_character(tmpC15Cid).jump_to(get_character(tmpC15Cid).x,get_character(tmpC15Cid).y)
call_msg("CompCocona:cocona/RecQuestCocona_15_0_2")
get_character(tmpC15Pid).animation = get_character(tmpC15Pid).animation_grabber_qte(get_character(tmpC15Cid))
get_character(tmpC15Cid).animation = get_character(tmpC15Cid).animation_grabbed_qte
SndLib.sound_equip_armor
call_msg("CompCocona:cocona/RecQuestCocona_15_0_3")
call_msg("CompCocona:cocona/RecQuestCocona_15_0_4")
set_event_force_page(tmpC15Cid,1) #strip dress
get_character(tmpC15Cid).batch_cocona_setCHS("-char-F-TEEN01",13,wipeEXT=true) #nude
get_character(tmpC15Cid).batch_cocona_setCHS
get_character(tmpC15Pid).animation = get_character(tmpC15Pid).animation_melee_touch_target(get_character(tmpC15Cid))
SndLib.sound_DressTear
wait(25)
get_character(tmpC15Pid).moveto(get_character(tmpC15Cid).x,get_character(tmpC15Cid).y)
get_character(tmpC15Pid).npc_story_mode(false)
get_character(tmpC15Cid).npc_story_mode(false)
npc_sex_service_main(get_character(tmpC15Pid),get_character(tmpC15Cid),"vag",4,1)

##################################################################################   PUT HEV HERE ##########################################################################
##################################################################################   PUT HEV HERE ##########################################################################
##################################################################################   PUT HEV HERE ##########################################################################
portrait_hide
wait(20)
portrait_off

$story_stats["HiddenOPT0"] = "0"
$story_stats["RecQuestCoconaVagTaken"] = -1
call_StoryHevent("RecHevCoconaPriest","HevCoconaPriest")
if $story_stats["HiddenOPT0"] == "1"
	$story_stats["RecQuestCoconaVagTaken"] = 1
	get_character(tmpC15Pid).npc_story_mode(true)
	get_character(tmpC15Cid).npc_story_mode(true)
	npc_sex_service_main(get_character(tmpC15Pid),get_character(tmpC15Cid),"anal",3,1)
end
##################################################################################   PUT HEV HERE ##########################################################################
##################################################################################   PUT HEV HERE ##########################################################################
##################################################################################   PUT HEV HERE ##########################################################################

call_msg("CompCocona:cocona/RecQuestCocona_15_1_4") if $story_stats["HiddenOPT0"] == "1" #break
$story_stats["HiddenOPT0"] = "0"


portrait_hide
chcg_background_color(0,0,0,0,7)
	portrait_off
	$game_player.direction = 2
	get_character(tmpC15Pid).npc_story_mode(false)
	get_character(tmpC15Cid).npc_story_mode(false)
	get_character(tmpC15Pid).unset_event_chs_sex
	get_character(tmpC15Cid).unset_event_chs_sex
	get_character(tmpC15Pid).through = false
	get_character(tmpC15Cid).through = false
	get_character(tmpC15Pid).moveto(get_character(tmpC15Cid).x,get_character(tmpC15Cid).y-1)
	#get_character(tmpC15Pid).animation = get_character(tmpC15Pid).animation_grabber_qte(get_character(tmpC15Cid))
	get_character(tmpC15Pid).animation = get_character(tmpC15Pid).animation_masturbation
	get_character(tmpC15Cid).animation = get_character(tmpC15Cid).animation_stun
	get_character(tmpC15Cid).balloon_XYfix = -33
	get_character(tmpC15Cid).call_balloon(28,-1)
	if $story_stats["RecQuestCoconaVagTaken"] == 1
		set_event_force_page(tmpC15Cid,2) #semen mode
		get_character(tmpC15Cid).batch_cocona_setCHS("-char-F-TEEN01",8,wipeEXT=false) #nude meat toileted
	end
	get_character(tmpC15Pid).set_npc("SaintHumanFatPriest")
	wait(3)
	get_character(tmpC15Pid).npc.set_fraction(13)
	get_character(tmpC15Pid).npc.fated_enemy = [5,8,9,10]
	get_character(tmpC15Pid).npc.fraction_mode = 4
	get_character(tmpC15Pid).npc.add_fated_enemy([0])
	
	SndLib.sound_step_chain(100,90+rand(20))
	wait(35)
chcg_background_color(0,0,0,255,-7)

call_msg("CompCocona:cocona/RecQuestCocona_15_end")
$story_stats["RecQuestCocona"] = 16
get_character(0).delete
eventPlayEnd