tmpTsX,tmpTsY,tmpTsID=$game_map.get_storypoint("TicketSeller")
tmpBiosID = $game_map.get_storypoint("DualBios")[2]
tmpG1X,tmpG1Y,tmpG1ID=$game_map.get_storypoint("Gate1")
tmpG2X,tmpG2Y,tmpG2ID=$game_map.get_storypoint("Gate2")
scanResult = get_character(0).summon_data[:scanResult]
scanCompareTar = get_character(0).summon_data[:scanCompareTar]



p "draw?  =>#{ scanResult.nil? && scanCompareTar.nil?}"
p "win?  =>#{ scanResult.nil? && !scanCompareTar.nil? }"
get_character(tmpTsID).call_balloon(28,-1)
get_character(tmpG1ID).call_balloon(0)
get_character(tmpG2ID).call_balloon(0)

get_character(tmpBiosID).summon_data[:PtPayed] = 0

if scanResult.nil? && !scanCompareTar.nil?
	get_character(tmpBiosID).summon_data[:MatchEnd] = true
	get_character(tmpBiosID).summon_data[:Winner] = scanCompareTar
	$story_stats["HiddenOPT0"] = $game_text["TagMapNoerArena:name/#{scanCompareTar}"]
	call_msg("TagMapNoerArena:NewMatch/WinnerIS") ; SndLib.ppl_CheerGroup(70)
	$story_stats["HiddenOPT0"] = "0"
	
else #draw
	get_character(tmpBiosID).summon_data[:MatchEnd] = true
	get_character(tmpBiosID).summon_data[:Winner] = "Draw"
	get_character(tmpBiosID).summon_data[:LosMultiple] = 1
	get_character(tmpBiosID).summon_data[:Multiple] = 1
	call_msg("TagMapNoerArena:NewMatch/Draw") ; SndLib.ppl_BooGroup(90)
end

portrait_hide