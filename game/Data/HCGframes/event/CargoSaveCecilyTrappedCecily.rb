#when battle
if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end

return delete if $story_stats["UniqueCharUniqueCecily"] == -1
return delete if $story_stats["UniqueCharUniqueGrayRat"] == -1
return delete if $story_stats["RecQuestSaveCecily"] == -1
tmpCeX,tmpCeY,tmpCeID=$game_map.get_storypoint("Cecily")
tmpCeTX,tmpCeTY,tmpCeTID=$game_map.get_storypoint("CeTrapped")
tmpEx1X,tmpEx1Y,tmpEx1ID=$game_map.get_storypoint("ExitPoint")
tmpEx2X,tmpEx2Y,tmpEx2ID=$game_map.get_storypoint("ExitPoint2")
#tmpBr1X,tmpBr1Y,tmpBr1ID=$game_map.get_storypoint("Broke1")
#tmpBr2X,tmpBr2Y,tmpBr2ID=$game_map.get_storypoint("Broke2")
$story_stats["QuProgSaveCecily"] = 4
portrait_off
call_msg("TagMapCargoSaveCecily:CecilyRape/trapped_raped") if $story_stats["RecQuestSaveCecilyRaped"] ==1
call_msg("TagMapCargoSaveCecily:CecilyRape/trapped") if $story_stats["RecQuestSaveCecilyRaped"] !=1

portrait_hide
chcg_background_color(0,0,0,0,7)
portrait_off
	tmpX = get_character(0).x
	tmpY = get_character(0).y
	get_character(tmpCeID).set_alternative_summon_data(:UniqueNpc=>"Cecily",:Armored=>true)
	get_character(tmpCeID).opacity = 255
	get_character(tmpCeID).moveto(tmpX,tmpY)
	get_character(tmpCeID).direction = 8
	#set_event_force_page(tmpCeID,1)
	
	
	
	get_character(tmpCeID).set_this_event_companion_back("UniqueCecily",true,$game_date.dateAmt+1)
	get_character(tmpCeID).npc.fraction_mode =2
	##################################################################################
	get_character(0).delete
	portrait_hide
	wait(30)
	SndLib.sound_equip_armor
	wait(30)
	SndLib.sound_equip_armor
	wait(30)
SndLib.sound_equip_armor
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapCargoSaveCecily:CecilyRape/trapped2")
chcg_background_color(0,0,0,0,7)
tmpGrX,tmpGrY,tmpGrID=$game_map.get_storypoint("UniqueGrayRat")
#get_character(tmpBr1ID).opacity = 255
#get_character(tmpBr2ID).opacity = 255
#set_event_force_page(tmpGrID,1)
get_character(tmpGrID).set_alternative_summon_data(:UniqueNpc=>"GrayRat",:Armored=>true)
get_character(tmpGrID).npc_story_mode(true)
get_character(tmpGrID).moveto(tmpCeTX,tmpCeTY-2)
get_character(tmpGrID).npc.death_event = "EffectUniqueGrayRatDed"
get_character(tmpGrID).set_this_event_companion_front("UniqueGrayRat",true,$game_date.dateAmt+1)
get_character(tmpGrID).npc.fraction_mode =2
#####################################################################################################
chcg_background_color(0,0,0,255,-7)
call_msg("TagMapCargoSaveCecily:CecilyRape/trapped3")
call_msg("TagMapCargoSaveCecily:CecilyRape/trapped4_raped") if $story_stats["RecQuestSaveCecilyRaped"] ==1
call_msg("TagMapCargoSaveCecily:CecilyRape/trapped4") if $story_stats["RecQuestSaveCecilyRaped"] !=1
call_msg("TagMapCargoSaveCecily:CecilyRape/trapped5")
get_character(tmpGrID).npc_story_mode(false)
get_character(tmpEx1ID).call_balloon(28,-1)
get_character(tmpEx2ID).call_balloon(28,-1)
eventPlayEnd