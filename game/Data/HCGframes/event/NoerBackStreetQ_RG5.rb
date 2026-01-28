
tmpMaaniID=$game_map.get_storypoint("Maani")[2]
tmpGangBossID=$game_map.get_storypoint("GangBoss")[2]
tmpSnipeID=$game_map.get_storypoint("Snipe")[2]
tmpSnipeHitID=$game_map.get_storypoint("SnipeHit")[2]
get_character(tmpGangBossID).direction = 2
get_character(tmpMaaniID).direction = 2
get_character(tmpMaaniID).animation = nil

call_msg("CompCecily:QuProg/20to21_SE")
GabeSDK.getAchievement("QuProgSaveCecily_21")
get_character(tmpMaaniID).delete
get_character(tmpGangBossID).delete
get_character(tmpSnipeID).delete
get_character(tmpSnipeHitID).delete
SndLib.bgm_stop
eventPlayEnd

get_character(0).erase