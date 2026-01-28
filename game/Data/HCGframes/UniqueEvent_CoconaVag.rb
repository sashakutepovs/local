DataManager.write_rec_constant("RecHevUniqueEvent_CoconaVag",1)




portrait_hide
$story_stats["ForceChcgMode"] = 1
$game_player.force_update = false
chcg_background_color(200,0,200,40)
recRoomMode = $story_stats["tmpData"] && $story_stats["tmpData"][:recRoomMode]
if recRoomMode
	tmpCoconaWhoreEV_B_BackHumFuckerLHand	= $game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"]
	tmpCoconaWhoreEV_B_VagHumFucker			= $game_NPCLayerMain.stat["Cocona_VagHumFucker"]
	tmpCoconaWhoreEV_B_BackHumFuckerRHand	= $game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"]
	tmpCoconaWhoreEV_B_Effect_EffectPee		= $game_NPCLayerMain.stat["Cocona_Effect_EffectPee"]
	tmpCoconaWhoreEV_B_Effect_ButtShake		= $game_NPCLayerMain.stat["Cocona_Effect_ButtShake"]
	tmpCoconaWhoreEV_B_Effect_HeadShock		= $game_NPCLayerMain.stat["Cocona_Effect_HeadShock"]
	tmpCoconaWhoreEV_B_Effect_EyesShock		= $game_NPCLayerMain.stat["Cocona_Effect_EyesShock"]
	tmpCoconaWhoreEV_B_Effect_EyesTear		= $game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]
	tmpCoconaWhoreEV_B_Effect_BodyShake		= $game_NPCLayerMain.stat["Cocona_Effect_BodyShake"]
	tmpCoconaWhoreEV_B_Effect_CumButtR		= $game_NPCLayerMain.stat["Cocona_Effect_CumButtR"]
	tmpCoconaWhoreEV_B_Effect_CumButtL		= $game_NPCLayerMain.stat["Cocona_Effect_CumButtL"]
	tmpCoconaWhoreEV_B_Effect_CreamPie		= $game_NPCLayerMain.stat["Cocona_Effect_CreamPie"]
	tmpCoconaWhoreEV_B_VagOpen				= $game_NPCLayerMain.stat["Cocona_VagOpen"]
	tmpCoconaWhoreEV_B_Effect_Wet			= $game_NPCLayerMain.stat["Cocona_Effect_Wet"]
	tmpCoconaWhoreEV_B_Dress				= $game_NPCLayerMain.stat["Cocona_Dress"]
	tmpCoconaWhoreEV_B_Body					= $game_NPCLayerMain.stat["Cocona_Body"]
	tmpCoconaWhoreEV_B_Eyes					= $game_NPCLayerMain.stat["Cocona_Eyes"]
	tmpCoconaWhoreEV_B_Mouth				= $game_NPCLayerMain.stat["Cocona_Mouth"]
	tmpCoconaWhoreEV_B_HeadBase				= $game_NPCLayerMain.stat["Cocona_HeadBase"]
	tmpCoconaWhoreEV_B_BOX					= $game_NPCLayerMain.stat["Cocona_BOX"]
	tmpCoconaWhoreEV_B_VagXray				= $game_NPCLayerMain.stat["Cocona_VagXray"]
	tmpCocona_lowerDamageVagLvlReq			= $game_NPCLayerMain.stat["Cocona_lowerDamageVagLvlReq"]
	tmpCocona_exp_vag						= $game_NPCLayerMain.stat["Cocona_exp_vag"]
	tmpCocona_Arousal						= $game_NPCLayerMain.stat["Cocona_Arousal"]
	tmpCocona_Will							= $game_NPCLayerMain.stat["Cocona_Will"]
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"]	=0
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"]		=0
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"]	=0
	$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"]	=0
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"]	=0
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"]	=0
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"]	=0
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]		=0
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"]	=0
	$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"]		=0
	$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"]		=0
	$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"]		=0
	$game_NPCLayerMain.stat["Cocona_VagOpen"]				=0
	$game_NPCLayerMain.stat["Cocona_Effect_Wet"]			=0
	$game_NPCLayerMain.stat["Cocona_Dress"]				= ["Nude","Maid"].sample
	$game_NPCLayerMain.stat["Cocona_Body"]				=0
	$game_NPCLayerMain.stat["Cocona_Eyes"]				=0
	$game_NPCLayerMain.stat["Cocona_Mouth"]				=0
	$game_NPCLayerMain.stat["Cocona_HeadBase"]			=0
	$game_NPCLayerMain.stat["Cocona_BOX"]					=0
	$game_NPCLayerMain.stat["Cocona_VagXray"]				=0
	$game_NPCLayerMain.stat["Cocona_lowerDamageVagLvlReq"]			=0
	$game_NPCLayerMain.stat["Cocona_exp_vag"]						=0
	$game_NPCLayerMain.stat["Cocona_Arousal"]						=0
	$game_NPCLayerMain.stat["Cocona_Will"]							=800
	coconaEV = false
else
	return if !cocona_in_group?
	return if !get_character($game_player.get_followerID(0))
	coconaEV = get_character($game_player.get_followerID(0))
	$story_stats["record_CoconaVag"] +=1
end

#chcg_init_cocona
$game_NPCLayerMain.stat["Cocona_Hsta"] = coconaEV.actor.battle_stat.get_stat("sta") if coconaEV
$game_NPCLayerMain.stat["Cocona_Hhealth"] = coconaEV.actor.battle_stat.get_stat("health") if coconaEV
#tmpO_Wet = $game_NPCLayerMain.stat["Cocona_Effect_Wet"]
tmpO_CumButtR = $game_NPCLayerMain.stat["Cocona_Effect_CumButtR"]
tmpO_CumButtL = $game_NPCLayerMain.stat["Cocona_Effect_CumButtL"]
tmpO_CreamPie = $game_NPCLayerMain.stat["Cocona_Effect_CreamPie"]
tmpO_VagOpen = $game_NPCLayerMain.stat["Cocona_VagOpen"]
tmpO_VagLVL = $game_NPCLayerMain.stat["Cocona_exp_vag"]
tmpO_AroLVL = $game_NPCLayerMain.stat["Cocona_Arousal"]
#$game_NPCLayerMain.stat["Cocona_Will"] #tmp
cumLVL = tmpO_CumButtR+tmpO_CumButtL+tmpO_CreamPie
$game_NPCLayerMain.stat["pose"] = "CoconaWhoreEV_B"
$game_NPCLayerMain.stat["EventVagRace"] = "Human"
$game_NPCLayerMain.stat["EventVagRace"] = $story_stats["tmpData"][:race] if $story_stats["tmpData"] && $story_stats["tmpData"][:race]
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 0
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"] = 0 #make a over ev for her
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"] = 1 if cumLVL >= 3 #rec
$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] = 1 if cumLVL >= 2 #rec
$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] = 1 if cumLVL >= 1 #rec
$game_NPCLayerMain.stat["Cocona_VagOpen"] = 1 if $game_NPCLayerMain.stat["Cocona_exp_vag"] >= $game_NPCLayerMain.stat["Cocona_lowerDamageVagLvlReq"]
tmpWombPunch = [true,false].sample #var controlled by evv
#$game_NPCLayerMain.stat["Cocona_Effect_Wet"] = 0 #rec
#$game_NPCLayerMain.stat["Cocona_Dress"] = ["Nude","Maid"].sample ################# var controlled by ev
$game_NPCLayerMain.stat["Cocona_Body"] = 1
$game_NPCLayerMain.stat["Cocona_Eyes"] = 1
$game_NPCLayerMain.stat["Cocona_Mouth"] = 1
$game_NPCLayerMain.stat["Cocona_HeadBase"] = 1
$game_NPCLayerMain.stat["Cocona_BOX"] = rand(2)
$game_NPCLayerMain.stat["Cocona_VagXray"] = 0
setRprt("NPCLayerMain")

###################################################################################################################################################################################
#1 begin
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 0
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 0
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 0
$game_NPCLayerMain.portrait.mirror = true
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125,-58)
call_msg("CompCocona:WhoreEV/fuck0")


###################################################################################################################################################################################
#2 show hands co shake
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 0
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 1
$game_NPCLayerMain.stat["Cocona_Eyes"] = 2
$game_NPCLayerMain.stat["Cocona_Mouth"] = 2
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125-10,-58-20)
$game_NPCLayerMain.portrait.shake
SndLib.sound_equip_armor
call_msg("CompCocona:WhoreEV/fuck1")

###################################################################################################################################################################################
#3 Show fucker enter
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 1
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 0
$game_NPCLayerMain.stat["Cocona_Eyes"] = 2
$game_NPCLayerMain.stat["Cocona_Mouth"] = 1
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125-10,-58-20)
$game_NPCLayerMain.portrait.shake
SndLib.sound_equip_armor
call_msg("CompCocona:WhoreEV/fuck2")

###################################################################################################################################################################################
#4 male penis touch VAG
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 2
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Eyes"] = 2
$game_NPCLayerMain.stat["Cocona_Mouth"] = 2
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125-10,-58-20)
$game_NPCLayerMain.portrait.shake
SndLib.sound_chs_dopyu(80) ; wait(25)
call_msg("CompCocona:cocona/RecQuestCocona_HEV3_19")

###################################################################################################################################################################################
#4 male penis put in
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 3
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Eyes"] = 4
$game_NPCLayerMain.stat["Cocona_Mouth"] = 4
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125-50,-58-60)
$game_NPCLayerMain.portrait.shake
SndLib.sound_chs_dopyu(80) ; wait(25)
call_msg("CompCocona:cocona/RecQuestCocona_HEV3_17")

###################################################################################################################################################################################
#5 putin dirty talk   tie 
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 4
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = 0
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 0
$game_NPCLayerMain.stat["Cocona_VagOpen"] = 1
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125,-58)
SndLib.sound_chs_dopyu(80,80) ; wait(10)

$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125,-58)
wait(5)

$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 6
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Eyes"] = 3
$game_NPCLayerMain.stat["Cocona_Mouth"] = rand(3)+2
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125,-88)
$game_NPCLayerMain.portrait.shake
if tmpWombPunch
	call_msg("CompCocona:WhoreEV/fuck3")
	if coconaEV
		coconaEV.actor.set_health(coconaEV.actor.battle_stat.get_stat("health")-20)
		coconaEV.actor.update_npc_stat
		$game_NPCLayerMain.stat["Cocona_GroinDamaged"] = 3
		3.times{coconaEV.actor.add_state("WoundGroin")}
	end
	SndLib.sound_chs_dopyu(80,80) ; wait(10)
	$game_NPCLayerMain.portrait.shake
	wait(30)
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 7
	$game_NPCLayerMain.stat["Cocona_VagXray"] = 1
	$game_NPCLayerMain.stat["Cocona_Eyes"] = 4
	$game_NPCLayerMain.stat["Cocona_Mouth"] = 4
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-125,-38)
	$game_NPCLayerMain.portrait.shake
	SndLib.sound_punch_hit(100,150)
	SndLib.sound_chs_dopyu(80,80) ; wait(10)
	wait(20)
	$game_NPCLayerMain.portrait.shake
	SndLib.sound_punch_hit(100,150)
	SndLib.sound_chs_dopyu(80,80) ; wait(10)
	wait(30)
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_Roar2")
	$game_NPCLayerMain.stat["Cocona_VagXray"] = 0
else
	$game_NPCLayerMain.stat["Cocona_VagXray"] = 0
	call_msg("CompCocona:cocona/RecQuestCocona_HEV3_16")
end
###################################################################################################################################################################################
#6 Start Moving

call_msg("CompCocona:WhoreEV/fuck4_#{rand(3)}")
4.times{
	SndLib.sound_chs_dopyu(80,80)
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-90-50,-58-20)
	wait(6)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 4
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-120-50,-58-40)
	wait(10)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-90-50,-58-20)
	wait(10)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 6
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = rand(5)+1
	$game_NPCLayerMain.stat["Cocona_Mouth"] = rand(3)+2
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-80-50,-58-10)
	#$game_NPCLayerMain.portrait.shake
	wait(30)
	$game_NPCLayerMain.stat["Cocona_Arousal"] += 30
	load_script("Data/HCGframes/UniqueEvent_CoconaOgrasm.rb") if  $game_NPCLayerMain.stat["Cocona_Arousal"] > $game_NPCLayerMain.stat["Cocona_Will"]
}
call_msg("CompCocona:cocona/#{["RecQuestCocona_HEV3_2","RecQuestCocona_HEV3_3","RecQuestCocona_HEV3_Roar2","RecQuestCocona_HEV3_Roar5"].sample}")
###################################################################################################################################################################################
#7 move fast

$game_NPCLayerMain.stat["Cocona_Effect_Wet"] = 1
10.times{
	SndLib.sound_chs_dopyu(80-10,80)
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-70-10-40,-65-30)
	wait(3)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 4
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-100-10-40,-65-50)
	wait(5)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-70-10-40,-65-30)
	wait(5)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 6
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = rand(5)+1
	$game_NPCLayerMain.stat["Cocona_Mouth"] = rand(3)+2
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-60-10-40,-65-20)
	wait(15)
	$game_NPCLayerMain.stat["Cocona_Arousal"] += 30
	load_script("Data/HCGframes/UniqueEvent_CoconaOgrasm.rb") if  $game_NPCLayerMain.stat["Cocona_Arousal"] > $game_NPCLayerMain.stat["Cocona_Will"]
}
$game_NPCLayerMain.portrait.shake
call_msg("CompCocona:cocona/#{["RecQuestCocona_HEV3_2","RecQuestCocona_HEV3_3","RecQuestCocona_HEV3_Roar2","RecQuestCocona_HEV3_Roar5"].sample}")
10.times{
	SndLib.sound_chs_dopyu(80,90)
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-70-20-30,-75-30)
	wait(2)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 4
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-100-20-30,-75-40)
	wait(3)
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-70-20-30,-75-30)
	wait(3)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 6
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = rand(5)+1
	$game_NPCLayerMain.stat["Cocona_Mouth"] = rand(3)+2
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-60-20-30,-75-20)
	wait(10)
	$game_NPCLayerMain.stat["Cocona_Arousal"] += 30
	load_script("Data/HCGframes/UniqueEvent_CoconaOgrasm.rb") if  $game_NPCLayerMain.stat["Cocona_Arousal"] > $game_NPCLayerMain.stat["Cocona_Will"]
}
$game_NPCLayerMain.portrait.shake
call_msg("CompCocona:cocona/#{["RecQuestCocona_HEV3_2","RecQuestCocona_HEV3_3","RecQuestCocona_HEV3_Roar2","RecQuestCocona_HEV3_Roar5"].sample}")
10.times{
	SndLib.sound_chs_dopyu(80)
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-70-30-20,-80-30)
	wait(1)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 4
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-100-30-20,-80-40)
	wait(2)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-70-30-20,-80-30)
	wait(2)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 6
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = [4,5].sample
	$game_NPCLayerMain.stat["Cocona_Mouth"] = rand(3)+2
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-60-30-20,-80-20)
	wait(5)
	$game_NPCLayerMain.stat["Cocona_Arousal"] += 30
	load_script("Data/HCGframes/UniqueEvent_CoconaOgrasm.rb") if  $game_NPCLayerMain.stat["Cocona_Arousal"] > $game_NPCLayerMain.stat["Cocona_Will"]
}
call_msg("CompCocona:WhoreEV/fuck5")
call_msg("CompCocona:cocona/#{["RecQuestCocona_HEV3_2","RecQuestCocona_HEV3_3","RecQuestCocona_HEV3_Roar2","RecQuestCocona_HEV3_Roar5"].sample}")

###################################################################################################################################################################################

4.times{
	SndLib.sound_chs_dopyu(80,80)
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 5
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-125,-108)
	wait(4)
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 8
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = [2,5].sample#rand(5)+1
	$game_NPCLayerMain.stat["Cocona_Mouth"] = rand(3)+2
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-115,-108)
	$game_NPCLayerMain.portrait.shake
	wait(40)
	$game_NPCLayerMain.stat["Cocona_Arousal"] += 30
	load_script("Data/HCGframes/UniqueEvent_CoconaOgrasm.rb") if  $game_NPCLayerMain.stat["Cocona_Arousal"] > $game_NPCLayerMain.stat["Cocona_Will"]
}
call_msg("CompCocona:WhoreEV/fuck6")
call_msg("CompCocona:cocona/#{["RecQuestCocona_HEV3_2","RecQuestCocona_HEV3_3","RecQuestCocona_HEV3_Roar2","RecQuestCocona_HEV3_Roar5"].sample}")

###################################################################################################################################################################################

$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"] = 1 if $game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] >= 1
$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] = 1 if $game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] >= 1
$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] = 1
2.times{
	SndLib.sound_chs_dopyu(80,50)
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 7
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = 4
	$game_NPCLayerMain.stat["Cocona_Mouth"] = 2
	$game_NPCLayerMain.stat["Cocona_VagXray"] = 2
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-125+25,-28)
	$game_NPCLayerMain.portrait.shake
	wait(60)
	$game_NPCLayerMain.stat["Cocona_Arousal"] += 30
	load_script("Data/HCGframes/UniqueEvent_CoconaOgrasm.rb") if  $game_NPCLayerMain.stat["Cocona_Arousal"] > $game_NPCLayerMain.stat["Cocona_Will"]
}
call_msg("CompCocona:cocona/#{["RecQuestCocona_HEV3_2","RecQuestCocona_HEV3_3","RecQuestCocona_HEV3_Roar2","RecQuestCocona_HEV3_Roar5"].sample}")

2.times{
	SndLib.sound_chs_dopyu(80,50)
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 1
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 9
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
	$game_NPCLayerMain.stat["Cocona_Eyes"] = 5
	$game_NPCLayerMain.stat["Cocona_Mouth"] = 2
	$game_NPCLayerMain.stat["Cocona_VagXray"] = 3
	$game_NPCLayerMain.portrait.update
	$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-125+25,-28)
	#$game_portraits.rprt.set_position(-179+50,-28)
	$game_NPCLayerMain.portrait.shake
	wait(60)
	$game_NPCLayerMain.stat["Cocona_Arousal"] += 30
	load_script("Data/HCGframes/UniqueEvent_CoconaOgrasm.rb") if  $game_NPCLayerMain.stat["Cocona_Arousal"] > $game_NPCLayerMain.stat["Cocona_Will"]
}
call_msg("CompCocona:cocona/#{["RecQuestCocona_HEV3_2","RecQuestCocona_HEV3_3","RecQuestCocona_HEV3_Roar2","RecQuestCocona_HEV3_Roar5"].sample}")

SndLib.sound_chs_dopyu(80,50)
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 0
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 8
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = rand(2)
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = rand(2)
$game_NPCLayerMain.stat["Cocona_Eyes"] = 5
$game_NPCLayerMain.stat["Cocona_Mouth"] = 2
$game_NPCLayerMain.stat["Cocona_VagXray"] = 0
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
	$game_portraits.rprt.set_position(-125+25,-28)
#$game_portraits.rprt.set_position(-179,-110)
$game_NPCLayerMain.portrait.shake
call_msg("CompCocona:WhoreEV/fuck_end0")
call_msg("CompCocona:WhoreEV/fuck1")

SndLib.sound_chs_dopyu(80,50)
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 0
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 10
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = 1
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 1
$game_NPCLayerMain.stat["Cocona_Eyes"] = 5
$game_NPCLayerMain.stat["Cocona_Mouth"] = 1
$game_NPCLayerMain.stat["Cocona_VagXray"] = 0
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-228+80,-178)
$game_NPCLayerMain.portrait.shake
call_msg("CompCocona:WhoreEV/fuck_end1")
call_msg("CompCocona:WhoreEV/fuck1")

$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 0
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 0
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = 1
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 0
$game_NPCLayerMain.stat["Cocona_Eyes"] = 2
$game_NPCLayerMain.stat["Cocona_Mouth"] = 1
$game_NPCLayerMain.stat["Cocona_VagXray"] = 0
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-125+50,-108)
$game_NPCLayerMain.portrait.shake
call_msg("................")
call_msg("............")
call_msg("......")

$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 0
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 0
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 1
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]  = 1
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 0
$game_NPCLayerMain.stat["Cocona_Eyes"] = 5
$game_NPCLayerMain.stat["Cocona_Mouth"] = 2
$game_NPCLayerMain.stat["Cocona_VagXray"] = 5
$game_NPCLayerMain.portrait.update
$game_portraits.rprt.focus
$game_portraits.rprt.set_position(-157,-34)
$game_NPCLayerMain.portrait.shake
call_msg("CompCocona:WhoreEV/fuck_end2_#{rand(2)}")
call_msg("............")
call_msg("......")
###################################################################################################################################################################################















###################################################################################################################################################################################
#end

if recRoomMode
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"]	=tmpCoconaWhoreEV_B_BackHumFuckerLHand
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"]		=tmpCoconaWhoreEV_B_VagHumFucker
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"]	=tmpCoconaWhoreEV_B_BackHumFuckerRHand
	$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"]	=tmpCoconaWhoreEV_B_Effect_EffectPee
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"]	=tmpCoconaWhoreEV_B_Effect_ButtShake
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"]	=tmpCoconaWhoreEV_B_Effect_HeadShock
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"]	=tmpCoconaWhoreEV_B_Effect_EyesShock
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"]		=tmpCoconaWhoreEV_B_Effect_EyesTear
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"]	=tmpCoconaWhoreEV_B_Effect_BodyShake
	$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"]		=tmpCoconaWhoreEV_B_Effect_CumButtR
	$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"]		=tmpCoconaWhoreEV_B_Effect_CumButtL
	$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"]		=tmpCoconaWhoreEV_B_Effect_CreamPie
	$game_NPCLayerMain.stat["Cocona_VagOpen"]				=tmpCoconaWhoreEV_B_VagOpen
	$game_NPCLayerMain.stat["Cocona_Effect_Wet"]			=tmpCoconaWhoreEV_B_Effect_Wet
	$game_NPCLayerMain.stat["Cocona_Dress"]				=tmpCoconaWhoreEV_B_Dress
	$game_NPCLayerMain.stat["Cocona_Body"]				=tmpCoconaWhoreEV_B_Body
	$game_NPCLayerMain.stat["Cocona_Eyes"]				=tmpCoconaWhoreEV_B_Eyes
	$game_NPCLayerMain.stat["Cocona_Mouth"]				=tmpCoconaWhoreEV_B_Mouth
	$game_NPCLayerMain.stat["Cocona_HeadBase"]			=tmpCoconaWhoreEV_B_HeadBase
	$game_NPCLayerMain.stat["Cocona_BOX"]					=tmpCoconaWhoreEV_B_BOX
	$game_NPCLayerMain.stat["Cocona_VagXray"]				=tmpCoconaWhoreEV_B_VagXray
	$game_NPCLayerMain.stat["Cocona_lowerDamageVagLvlReq"]			= tmpCocona_lowerDamageVagLvlReq
	$game_NPCLayerMain.stat["Cocona_exp_vag"]						= tmpCocona_exp_vag
	$game_NPCLayerMain.stat["Cocona_Arousal"]						= tmpCocona_Arousal
	$game_NPCLayerMain.stat["Cocona_Will"]							= tmpCocona_Will
else
	if $game_NPCLayerMain.stat["Cocona_exp_vag"] >= $game_NPCLayerMain.stat["Cocona_lowerDamageVagLvlReq"]
		coconaEV.actor.set_sta(coconaEV.actor.battle_stat.get_stat("sta")-50) if coconaEV
	else
		coconaEV.actor.set_sta(-1) if coconaEV && coconaEV.actor.battle_stat.get_stat("sta") > 0 if coconaEV
		coconaEV.actor.set_sta(coconaEV.actor.battle_stat.get_stat("sta")-25) if coconaEV
	end
	coconaEV.actor.update_npc_stat if coconaEV
	$game_NPCLayerMain.stat["Cocona_Hsta"] = coconaEV.actor.battle_stat.get_stat("sta")  if coconaEV#if !tmpIsRecRoom
	$game_NPCLayerMain.stat["Cocona_Hhealth"] = coconaEV.actor.battle_stat.get_stat("health")  if coconaEV #if !tmpIsRecRoom
	$game_NPCLayerMain.stat["Cocona_DidWhoreJob"] = true #if !tmpIsRecRoom
	#$game_NPCLayerMain.stat["Cocona_Arousal"] = tmpO_AroLVL if tmpIsRecRoom
	$game_NPCLayerMain.stat["Cocona_exp_vag"] +=1 #if !tmpIsRecRoom
	
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 0
	$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 0
	$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 0
	$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"] = 0
	$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = 0
	$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 0
	$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 0
	$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"] = 0
	$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 0
	#$game_NPCLayerMain.stat["Cocona_Effect_Wet"] = 0
	#$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"] = tmpO_CumButtR if tmpIsRecRoom
	#$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] = tmpO_CumButtL if tmpIsRecRoom
	#$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] = tmpO_CreamPie if tmpIsRecRoom
	#$game_NPCLayerMain.stat["Cocona_VagOpen"] = tmpO_VagOpen  if tmpIsRecRoom
	#$game_NPCLayerMain.stat["Cocona_Dress"] = "Maid"
	$game_NPCLayerMain.stat["Cocona_Body"] = 0
	$game_NPCLayerMain.stat["Cocona_Eyes"] = 0
	$game_NPCLayerMain.stat["Cocona_Mouth"] = 0
	$game_NPCLayerMain.stat["Cocona_HeadBase"] = 0
	$game_NPCLayerMain.stat["Cocona_BOX"] = 0
	$game_NPCLayerMain.stat["Cocona_VagXray"] = 0
	coconaEV.batch_cocona_setCHS if coconaEV
	coconaEV.batch_cocona_setHstats if coconaEV
	coconaEV.chs_need_update = true if coconaEV
	coconaEV.actor.update_npc_stat if coconaEV
end
$game_NPCLayerMain.stat["EventVagRace"] = nil
###################################################################################################################################################################################
#call_msg("TagMapCargoSaveCecily:CecilyRape/stage_rape_end")

$game_NPCLayerMain.portrait.mirror = false
chcg_background_color_off
$story_stats["ForceChcgMode"] = 0
$game_player.force_update = true
portrait_off
