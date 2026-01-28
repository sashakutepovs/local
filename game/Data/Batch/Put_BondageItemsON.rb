
case rand(20)+$story_stats["WorldDifficulty"]
	when 0..25
		if ![$data_ItemName["ItemCuff"],$data_ItemName["ItemChainCuff"]].include?($game_player.actor.equips[0]) && ![$data_ItemName["ItemChainCollar"]].include?($game_player.actor.equips[5])
			$game_player.actor.change_equip(0, nil)
			$game_player.actor.change_equip(1, nil)
			$game_player.actor.change_equip(5, nil)
			$game_party.gain_item("ItemChainCollar", 1) 
			$game_player.actor.change_equip(5, "ItemChainCollar")
			$story_stats["dialog_collar_equiped"] =0
			SndLib.sound_equip_armor(100)
			call_msg("common:Lona/collar_on#{talk_style}")
		end
	when 26..50
		if ![$data_ItemName["ItemCuff"],$data_ItemName["ItemChainCuff"]].include?($game_player.actor.equips[0])
			$game_player.actor.change_equip(0, nil)
			$game_player.actor.change_equip(1, nil)
			$game_player.actor.change_equip(5, nil)
			$game_party.gain_item("ItemCuff", 1) 
			$game_player.actor.change_equip(0, "ItemCuff")
			$story_stats["dialog_cuff_equiped"] =0
			SndLib.sound_equip_armor(100)
			call_msg("common:Lona/cuff_on#{talk_style}")
		end
	else
		if ![$data_ItemName["ItemChainCuff"]].include?($game_player.actor.equips[0])
			$game_player.actor.change_equip(0, nil)
			$game_player.actor.change_equip(1, nil)
			$game_player.actor.change_equip(5, nil)
			$game_party.gain_item("ItemChainCuff", 1)
			$game_player.actor.change_equip(0, "ItemChainCuff")
			$story_stats["dialog_cuff_equiped"] =0
			SndLib.sound_equip_armor(100)
			call_msg("common:Lona/cuff_on#{talk_style}")
		end
end


$game_party.lose_item($data_ItemName["ItemChainCuff"], 99, include_equip =false)
$game_party.lose_item($data_ItemName["ItemChainCollar"], 99, include_equip =false)
$game_party.lose_item($data_ItemName["ItemChainMidExtra"], 99, include_equip =false)
$game_party.lose_item($data_ItemName["ItemCuff"], 99, include_equip =false)
$game_party.lose_item($data_ItemName["ItemChainCuff"], 99, include_equip =false)
