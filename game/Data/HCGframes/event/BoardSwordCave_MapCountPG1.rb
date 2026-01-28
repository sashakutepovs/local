SndLib.bgm_stop
SndLib.bgs_stop
SndLib.bgs_play("WindMountain",80,200)
tmpBoardSwordX,tmpBoardSwordY,tmpBoardSwordID= $game_map.get_storypoint("BoardSword")
tmpDatSwordX,tmpDatSwordY,tmpDatSwordID = $game_map.get_storypoint("DatSword")
get_character($game_map.get_storypoint("Block1")[2]).trigger = -1
get_character($game_map.get_storypoint("Block2")[2]).trigger = -1
get_character($game_map.get_storypoint("Block3")[2]).trigger = -1
get_character($game_map.get_storypoint("BoardSword")[2]).trigger = -1
get_character($game_map.get_storypoint("Block1")[2]).effects=["FadeOutDelete",0,false,nil,nil,nil]
get_character($game_map.get_storypoint("Block2")[2]).effects=["FadeOutDelete",0,false,nil,nil,nil]
get_character($game_map.get_storypoint("Block3")[2]).effects=["FadeOutDelete",0,false,nil,nil,nil]
get_character($game_map.get_storypoint("BoardSword")[2]).effects=["FadeOutDelete",0,false,nil,nil,nil]
get_character(tmpDatSwordID).moveto(tmpBoardSwordX,tmpBoardSwordY)
set_this_event_force_page(10)
