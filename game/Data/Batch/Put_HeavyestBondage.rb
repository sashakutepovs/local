
tmpFeet = ![$data_ItemName["ItemChainMidExtra"]].include?($game_player.actor.equips[6])
tmpHand = ![$data_ItemName["ItemChainCuff"]].include?($game_player.actor.equips[0])
if tmpFeet || tmpHand
	$game_player.actor.change_equip(0, nil)
	$game_player.actor.change_equip(1, nil)
	$game_player.actor.change_equip(6, nil)
	
	$game_party.gain_item("ItemChainMidExtra", 1) 
	$game_player.actor.change_equip(6, "ItemChainMidExtra")
	
	$game_party.gain_item("ItemChainCuff", 1) 
	$game_player.actor.change_equip(0, "ItemChainCuff")
	$story_stats["dialog_cuff_equiped"] =0
	SndLib.sound_equip_armor(100)
	call_msg("common:Lona/cuff_on#{talk_style}")
	
	$game_party.lose_item($data_ItemName["ItemChainCuff"], 99, include_equip =false)
	$game_party.lose_item($data_ItemName["ItemChainCollar"], 99, include_equip =false)
	$game_party.lose_item($data_ItemName["ItemChainMidExtra"], 99, include_equip =false)
	$game_party.lose_item($data_ItemName["ItemCuff"], 99, include_equip =false)
	$game_party.lose_item($data_ItemName["ItemChainCuff"], 99, include_equip =false)
end