if $game_player.actor.sta <=0
	SndLib.sys_ChangeMapFailed(80,80)
	$game_map.popup(0,"QuickMsg:Lona/sta_too_low#{rand(2)}",0,0)
else
	$game_player.animation = $game_player.animation_atk_mh
	begin 
		equips_0_id = $game_player.actor.equips[0].id 
	rescue 
		equips_0_id = -1
	end
	$game_player.actor.sta -= 1
	$game_player.actor.sta -= 1 if equips_0_id !=11 #玩家沒裝備十字搞
	get_character(0).summon_data[:HP] -= 1
	SndLib.sound_combat_sword_hit_sword
	if get_character(0).summon_data[:HP] % 3 ==0
		EvLib.sum("ItemSaltpeter",$game_player.x,$game_player.y)
		get_character(0).delete if get_character(0).summon_data[:HP] <= 0
	end
end