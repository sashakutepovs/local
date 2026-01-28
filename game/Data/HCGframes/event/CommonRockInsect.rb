if $game_map.threat
	SndLib.sys_ChangeMapFailed(80,80)
	return $game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
elsif $game_player.actor.sta <=0
	SndLib.sys_ChangeMapFailed(80,80)
	return $game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
end
get_character(0).switch1_id = 3 if !get_character(0).switch1_id
return get_character(0).trigger = -1 if get_character(0).switch1_id <= 0


get_character(0).switch1_id -= 1
$game_player.animation = $game_player.animation_atk_sh
SndLib.sound_FlameCast(60,180)
SndLib.sound_equip_armor(80,70)
get_character(0).effects=["CutTree",0,false,nil,nil,[true,false].sample]
$game_player.actor.sta -= 1
optain_item($data_items[48]) #AnimalRoach
EvLib.sum("StaticRockInsect",get_character(0).x,get_character(0).y,{:user=>get_character(0)}) if get_character(0).switch1_id <= 0
