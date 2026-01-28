tmpPicked = "Cancel"

lona_mood "p5shame" ; $game_portraits.rprt.shake
pose_commonH_decider(pose=$game_player.actor.stat["pose"],mood="shame")
$game_portraits.rprt.shake
if $game_player.actor.sta > 0
	[true,false].sample ? call_msg("commonH:Lona/DeepThroat_begin7") : call_msg("commonH:Lona/DeepThroat_end")
	tmpGotoTar = ""
	tmpTarList = []
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]				,"Cancel"]
	#tmpTarList << ["#{$game_text["commonCommands:Lona/BasicNeedsOpt_Cancel"]}"+"<t=5>"	,"Cancel"]
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Spit"]					,"CollectSemen"] #if $game_player.actor.sta > 0
	tmpTarList << [$game_text["commonCommands:Lona/BasicNeedsOpt_Swallow"]				,"SemenSwallow"] #if $game_player.actor.sta > 0
	cmd_sheet = tmpTarList
	cmd_text =""
	for i in 0...cmd_sheet.length
		cmd_text.concat(cmd_sheet[i].first+",")
	end
	call_msg("\\optB[#{cmd_text}]")
	$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
	tmpPicked = "Cancel" if [0,-1].include?($game_temp.choice)
	$game_temp.choice = -1
end
case tmpPicked
	when "Cancel"
		$game_player.actor.healCums("CumsMouth", 1)
	when "CollectSemen" ; chcg_clearn_mouth_semen_trans_items
	when "SemenSwallow" ; chcg_clearn_mouth_semen_eat
end