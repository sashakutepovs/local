tmpLonaCapX,tmpLonaCapY,tmpLonaCapID=$game_map.get_storypoint("LonaCap")
tmpH_biosID = $game_map.get_storypoint("H_BIOS")[2]
enter_static_tag_map
summon_companion


if $story_stats["Captured"] == 1
	$game_player.transparent = true
	$game_player.moveto(tmpLonaCapX,tmpLonaCapY)
else
	$game_player.transparent = false
end

############################################ setup Heart
#if get_character(get_character(tmpH_biosID)).switch1_id != 1
#	tmpHeartID=$game_map.get_storypoint("AbomHive")[2]
#	
#	
#end
###############################################
chcg_background_color(0,0,0,255,-7) if $story_stats["ReRollHalfEvents"] ==1 || $story_stats["Captured"] == 1



tmpGiveUp = 0
tmpNap = 0
tmpGameOver = 0
if $story_stats["Captured"] == 1
	$game_player.actor.stat["EventVagRace"] =  "Abomination"
	$game_player.actor.stat["EventAnalRace"] = "Abomination"
	$game_player.actor.stat["EventMouthRace"] ="Abomination"
	$game_player.actor.stat["EventExt1Race"] = "Abomination"
	$game_player.actor.stat["EventExt2Race"] = "Abomination"
	$game_player.actor.stat["EventExt3Race"] = "Abomination"
	$game_player.actor.stat["EventExt4Race"] = "Abomination"
	$game_player.actor.stat["EventVag"] = "VagTouch"
	$game_player.actor.stat["EventAnal"] = "AnalTouch"
	$game_player.actor.stat["EventExt1"] = "BoobTouch"
	$game_player.actor.stat["EventMouth"] = "kissed"
	
	SndLib.sound_chcg_chupa(120)
	call_msg("TagMapRandAbomHive:Lona/CaptureWakeUp")
	
	until get_character(tmpH_biosID).summon_data[:StaCost] >= 100 || tmpGiveUp == 1 || tmpGameOver == 1
		$game_temp.choice = -1
		$game_player.actor.sta >= 10				? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		$game_player.actor.sta >= 30				? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		$game_player.actor.sta >= 50				? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		$story_stats["Ending_MainCharacter"] !=0	? $story_stats["HiddenOPT3"] = "1" : $story_stats["HiddenOPT3"] = "0"
		call_msg("TagMapRandAbomHive:Lona/CaptureStruggle")  #\optD[算了,抵抗10<r=HiddenOPT0>,抵抗30<r=HiddenOPT1>,抵抗50<r=HiddenOPT2>,接受自己的命運]
		case $game_temp.choice
		when 0 #算了
			call_msg("TagMapRandAbomHive:Lona/CaptureGiveUp")
			tmpGiveUp =1
		when 1 #抵抗10
			$game_player.actor.sta -= 10
			get_character(tmpH_biosID).summon_data[:StaCost] += 10
			p "STA cost  => #{get_character(tmpH_biosID).summon_data[:StaCost]}"
			get_character(tmpLonaCapID).jump_to(tmpLonaCapX,tmpLonaCapY)
			SndLib.sound_punch_hit(90,rand(10)+50)
			wait(60)
			call_msg("TagMapRandAbomHive:Lona/BondageStruggle")
			
		when 2 #抵抗30
			$game_player.actor.sta -= 30
			get_character(tmpH_biosID).summon_data[:StaCost] += 30
			p "STA cost  => #{get_character(tmpH_biosID).summon_data[:StaCost]}"
			get_character(tmpLonaCapID).jump_to(tmpLonaCapX,tmpLonaCapY)
			SndLib.sound_punch_hit(90,rand(10)+50)
			wait(60)
			call_msg("TagMapRandAbomHive:Lona/BondageStruggle")
			
		when 3 #抵抗50
			$game_player.actor.sta -= 50
			get_character(tmpH_biosID).summon_data[:StaCost] += 50
			p "STA cost  => #{get_character(tmpH_biosID).summon_data[:StaCost]}"
			get_character(tmpLonaCapID).jump_to(tmpLonaCapX,tmpLonaCapY)
			SndLib.sound_punch_hit(90,rand(10)+50)
			wait(60)
			call_msg("TagMapRandAbomHive:Lona/BondageStruggle")
			
		when 4 #接受自己的命運
			tmpGameOver = 1
		end
	end
	
	if get_character(tmpH_biosID).summon_data[:StaCost] >= 100
		chcg_background_color(0,0,0,0,7)
		half_event_key_cleaner
		whole_event_end
		$story_stats["Captured"] = 0
		$game_player.transparent = false
		get_character(tmpLonaCapID).delete
		chcg_background_color(0,0,0,255,-7)
		$game_map.reserve_summon_event("EffectOverKill",tmpLonaCapX,tmpLonaCapY)
		call_msg("TagMapRandAbomHive:Lona/StruggleWin")
	elsif tmpGiveUp == 1
		tmpNap = 1
		half_event_key_cleaner
		whole_event_end
	elsif tmpGameOver == 1
		half_event_key_cleaner
		whole_event_end
		load_script("Data/HCGframes/event/Ending_loaderBad.rb")
	end
elsif $story_stats["RecQuestLisa"] == 12 && $story_stats["Captured"] != 1
	chcg_background_color(0,0,0,255,-7)
	call_msg("CompLisa:Lisa12/Hive3_Bios")
	call_msg("CompLisa:Lisa12/Hive3_Bios_board")
	if $story_stats["UniqueCharUniqueElise"] != -1
		lisaID = $game_map.get_storypoint("Lisa")[2]
		lisaSTA = get_character(lisaID).actor.battle_stat.get_stat("sta")+100
		lisaHealth = get_character(lisaID).actor.battle_stat.get_stat("health")
		lisaCHK = [lisaHealth,lisaSTA].min
		call_timerCHK(lisaCHK)
		set_event_force_page($game_map.get_storypoint("QuestCount")[2],1)
	end
end
p "STA cost  => #{get_character(tmpH_biosID).summon_data[:StaCost]}"
eventPlayEnd
get_character(0).erase
$game_map.napEventId.nil? ?  handleNap : $game_map.call_nap_event if tmpNap == 1
