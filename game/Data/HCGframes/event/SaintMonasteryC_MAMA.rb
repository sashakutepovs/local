
$game_temp.choice = -1
if get_character(0).summon_data[:charge] == false
	call_msg("CompCocona:cocona/RecQuestCocona_18_MaMaCharge") #optB[later,Go,DontGO]
	
	case $game_temp.choice
		when 1 #go
			call_msg("CompCocona:cocona/RecQuestCocona_18_MaMaCharge_go")
			get_character(0).summon_data[:charge] = true
			#tmpMJx,tmpMJy,tmpMJid=$game_map.get_storypoint("MamaJump")
			tmpMJx,tmpMJy,tmpMJid=$game_map.get_storypoint("Idiot2")
			get_character(0).call_balloon(0)
			get_character(0).trigger = -1
			#get_character(0).jump_to(tmpMJx,tmpMJy) ; get_character(0).direction = 2
			get_character(0).set_move_goto_xy(tmpMJx,tmpMJy)
		#when 2 #dont go
		#	call_msg("CompCocona:cocona/RecQuestCocona_18_MaMaCharge_wait")
		#	get_character(0).call_balloon(0)
		#	get_character(0).summon_data[:charge] = true
	end
else
	call_msg("CompCocona:cocona/RecQuestCocona_18_MaMaCharge_end")
end
get_character(0).call_balloon(8,-1) if get_character(0).summon_data[:charge] == false
eventPlayEnd