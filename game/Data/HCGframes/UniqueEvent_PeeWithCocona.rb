return if !cocona_in_group?
return if !get_character($game_player.get_followerID(0))
coconaEV = get_character($game_player.get_followerID(0))



slotList = $data_system.equip_type_name
!equip_slot_removetable?("MH")		? equips_MH_id = -1 :		equips_MH_id =		$game_player.actor.equips[slotList["MH"]].item_name		#0
!equip_slot_removetable?("SH")		? equips_SH_id = -1 :		equips_SH_id =		$game_player.actor.equips[slotList["SH"]].item_name		#1
!equip_slot_removetable?("Top")		? equips_Top_id = -1 :		equips_Top_id =		$game_player.actor.equips[slotList["Top"]].item_name	#2
!equip_slot_removetable?("Mid")		? equips_Mid_id = -1 :		equips_Mid_id =		$game_player.actor.equips[slotList["Mid"]].item_name	#3
!equip_slot_removetable?("Bot")		? equips_Bot_id = -1 :		equips_Bot_id =		$game_player.actor.equips[slotList["Bot"]].item_name	#4
!equip_slot_removetable?("TopExt")	? equips_TopExt_id = -1 :	equips_TopExt_id =	$game_player.actor.equips[slotList["TopExt"]].item_name	#5
!equip_slot_removetable?("MidExt")	? equips_MidExt_id = -1 :	equips_MidExt_id =	$game_player.actor.equips[slotList["MidExt"]].item_name	#6
!equip_slot_removetable?("Hair")	? equips_Hair_id = -1 :		equips_Hair_id =	$game_player.actor.equips[slotList["Hair"]].item_name	#7
!equip_slot_removetable?("Head")	? equips_Head_id = -1 :		equips_Head_id =	$game_player.actor.equips[slotList["Head"]].item_name	#8
!equip_slot_removetable?("Neck")	? equips_Neck_id = -1 :		equips_Neck_id =	$game_player.actor.equips[slotList["Neck"]].item_name	#14
!equip_slot_removetable?("Vag")		? equips_Vag_id = -1 :		equips_Vag_id =		$game_player.actor.equips[slotList["Vag"]].item_name	#15
!equip_slot_removetable?("Anal")	? equips_Anal_id = -1 :		equips_Anal_id =	$game_player.actor.equips[slotList["Anal"]].item_name	#16

tmp_fucker_id = nil
$game_map.npcs.each do |event| 
	next if event.summon_data == nil
	#next if event.summon_data[:NapFucker] == nil
	#next if !event.summon_data[:NapFucker]
	next if event.npc.target != nil
	next if !["Human","Moot","Deepone"].include?(event.npc.race)
	next if event.npc.friendly?($game_player) || event.npc.master == $game_player
	next if event.actor.action_state != nil && event.actor.action_state !=:none
	next if !event.near_the_target?($game_player,5)
	next if !event.actor.target.nil?
	next if event.opacity != 255
	next if event.actor.sensors[0].get_signal(event,$game_player)[2] <=15 #[target,distance,signal_strength,sensortype]
	event.summon_data[:NapFucker] = false
	tmp_fucker_id = event.id
end

$story_stats["dialog_dress_out"] = 0
if !$game_player.innocent_spotted? || !tmp_fucker_id.nil?
	call_msg("commonCommands:Lona/Excretion_begin2")
else
$game_message.add("\\t[commonCommands:Lona/Bath_begin3_FuckerSight#{talk_style}]") if $game_player.actor.stat["Exhibitionism"] !=1
$game_message.add("\\t[commonCommands:Lona/Bath_begin3_FuckerSight_slut]") if $game_player.actor.stat["Exhibitionism"] ==1
	$game_map.interpreter.wait_for_message
	case $game_player.actor.stat["persona"] #主角處於視線下 檢測PERSONA來決定屬性變化
		when "typical"
			$game_player.actor.mood -=rand(10)+5
		when "gloomy"
			$game_player.actor.mood -=rand(5)+3
		when "tsundere"
			$game_player.actor.mood -=rand(10)+20
		when "slut"
			$game_player.actor.mood +=rand(10)+5
	end
	$game_player.actor.mood +=rand(10)+20 if $game_player.actor.stat["Exhibitionism"] ==1
end
if equips_2_id != -1#檢查裝備 並脫裝
	$game_player.actor.change_equip(2, nil)
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end

if equips_6_id != -1#檢查裝備 並脫裝
	$game_player.actor.change_equip(6, nil)
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
if equips_4_id != -1#檢查裝備 並脫裝
	$game_player.actor.change_equip(4, nil)
	SndLib.sound_equip_armor(100)
	player_force_update
	wait(30)
end
coconaEV.turn_toward_character($game_player)
call_msg("CompCocona:WhoreEV/first_begin0")
call_msg("CompCocona:WhoreEV/first_begin0_1")
call_msg("CompCocona:PeePeeTogeter/begin0")



$story_stats["ForceChcgMode"] = 1
$game_player.force_update = false
$game_map.interpreter.player_sex_get_tar_key if $game_player.actor.action_state == :sex && $game_player.manual_sex != true
$game_player.actor.stat["pose"] = "chcg2"
$game_player.actor.stat["pose"] == "chcg2"
#############################################################CHCG FRAME PEE ON##################################################################################
$game_player.actor.stat["EffectPee"] = 0
lona_mood "#{chcg_decider_basic_arousal(2)}fuck_#{chcg_shame_mood_decider}"
		
chcg_background_color(200,0,200,40)
#chcg_init_cocona
#$game_NPCLayerMain.stat["Cocona_Hsta"] = coconaEV.actor.battle_stat.get_stat("sta")
#$game_NPCLayerMain.stat["Cocona_Hhealth"] = coconaEV.actor.battle_stat.get_stat("health")
#tmpO_Wet = $game_NPCLayerMain.stat["Cocona_Effect_Wet"]
tmpO_CumButtR = $game_NPCLayerMain.stat["Cocona_Effect_CumButtR"] = 0
tmpO_CumButtL = $game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] = 0
tmpO_CreamPie = $game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] = 0
tmpO_VagOpen = $game_NPCLayerMain.stat["Cocona_VagOpen"]
tmpO_VagLVL = $game_NPCLayerMain.stat["Cocona_exp_vag"]
tmpO_AroLVL = $game_NPCLayerMain.stat["Cocona_Arousal"]
$game_NPCLayerMain.stat["Cocona_Will"] #tmp
cumLVL = tmpO_CumButtR+tmpO_CumButtL+tmpO_CreamPie
$game_NPCLayerMain.stat["pose"] = "CoconaWhoreEV_B"
$game_NPCLayerMain.stat["EventVagRace"] = "Human"
$game_NPCLayerMain.stat["Cocona_BackHumFuckerLHand"] = 0
$game_NPCLayerMain.stat["Cocona_VagHumFucker"] = 0
$game_NPCLayerMain.stat["Cocona_BackHumFuckerRHand"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"] = 0 #make a over ev for her
$game_NPCLayerMain.stat["Cocona_Effect_ButtShake"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_HeadShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesShock"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_EyesTear"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_BodyShake"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_CumButtR"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_CreamPie"] = 0
$game_NPCLayerMain.stat["Cocona_Effect_CumButtL"] = 0
$game_NPCLayerMain.stat["Cocona_VagOpen"] = 1 if $game_NPCLayerMain.stat["Cocona_exp_vag"] >= $game_NPCLayerMain.stat["Cocona_lowerDamageVagLvlReq"]
$game_NPCLayerMain.stat["Cocona_Dress"] = "Maid" ################# var controlled by ev
#$game_NPCLayerMain.stat["Cocona_Effect_Wet"] = 0 #rec 
$game_NPCLayerMain.stat["Cocona_Body"] = 1
$game_NPCLayerMain.stat["Cocona_Eyes"] = 5
$game_NPCLayerMain.stat["Cocona_Mouth"] = 1
$game_NPCLayerMain.stat["Cocona_HeadBase"] = 1
$game_NPCLayerMain.stat["Cocona_BOX"] = 0
$game_NPCLayerMain.stat["Cocona_VagXray"] = 0
setLprt("NPCLayerMain")




$game_NPCLayerMain.portrait.zoom_x = 0.8
$game_NPCLayerMain.portrait.zoom_y = 0.8
$game_NPCLayerMain.portrait.angle = 10

$game_player.actor.portrait.zoom_x = 0.65
$game_player.actor.portrait.zoom_y = 0.65
$game_player.actor.portrait.angle = -30
$game_player.actor.portrait.mirror = false
x_fix = -50
y_fix = 20
$game_portraits.lprt.set_position(-200 +x_fix,-0 +y_fix) #cocona
$game_portraits.rprt.set_position(330  +x_fix,-100+y_fix) #lona
call_msg("commonH:Lona/pee#{rand(5)}")
temp_1st_worm = rand(100) if $game_player.actor.state_stack("ParasitedPotWorm") !=0
call_msg("common:Lona/PeePotWorm") if $game_player.actor.state_stack("ParasitedPotWorm") !=0 && temp_1st_worm >=50
$game_NPCLayerMain.stat["Cocona_Effect_Wet"] = 1
6.times{
	load_script("Data/Batch/Command_PeeControl.rb")
	lona_mood "#{chcg_decider_basic_arousal(2)}fuck_#{chcg_shame_mood_decider}"
	$game_NPCLayerMain.stat["Cocona_Eyes"] = [5,1].sample
	
	
	SndLib.sound_chcg_pee(100,400)
	$game_player.actor.stat["EffectPee"] = 1
	$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"] = 0
	$game_NPCLayerMain.portrait.update
	$game_player.actor.portrait.update
	setLprt("NPCLayerMain")

	$game_NPCLayerMain.portrait.zoom_x = 0.8
	$game_NPCLayerMain.portrait.zoom_y = 0.8
	$game_NPCLayerMain.portrait.angle = 10
	$game_player.actor.portrait.zoom_x = 0.65
	$game_player.actor.portrait.zoom_y = 0.65
	$game_player.actor.portrait.angle = -30
	$game_player.actor.portrait.mirror = false
	
	$game_portraits.lprt.set_position(-200 -3+rand(7)+x_fix,-0  -3+rand(7)+y_fix) #cocona
	$game_portraits.rprt.set_position(330  -3+rand(7)+x_fix,-100-3+rand(7)+y_fix) #lona
	
	
	
	wait(30)
	SndLib.sound_chcg_pee(100,400)
	$game_player.actor.stat["EffectPee"] = 0
	$game_NPCLayerMain.stat["Cocona_Effect_EffectPee"] = 1
	$game_NPCLayerMain.portrait.update
	$game_player.actor.portrait.update
	setLprt("NPCLayerMain")

	$game_NPCLayerMain.portrait.zoom_x = 0.8
	$game_NPCLayerMain.portrait.zoom_y = 0.8
	$game_NPCLayerMain.portrait.angle = 10
	$game_player.actor.portrait.zoom_x = 0.65
	$game_player.actor.portrait.zoom_y = 0.65
	$game_player.actor.portrait.angle = -30
	$game_player.actor.portrait.mirror = false
	
	$game_portraits.lprt.set_position(-200 -3+rand(7)+x_fix,-0  -3+rand(7)+y_fix) #cocona
	$game_portraits.rprt.set_position(330  -3+rand(7)+x_fix,-100-3+rand(7)+y_fix) #lona
	wait(30)

}
wait(30)
portrait_off
call_msg("commonCommands:Lona/Excretion_end")

	
$game_actors[1].urinary_level =0
temp_1st_worm = rand(100) if $game_player.actor.state_stack("ParasitedPotWorm") !=0
if $game_player.actor.state_stack("ParasitedPotWorm") !=0 #控制寄生蟲
	prev_worm_birth = $story_stats["sex_record_birth_PotWorm"]
	if $game_player.actor.state_stack("ParasitedPotWorm") >=1 && temp_1st_worm >= 50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedPotWorm") >=2 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedPotWorm") >=3 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedPotWorm") >=4 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	if $game_player.actor.state_stack("ParasitedPotWorm") >=5 && rand(100) >=50
		$game_map.reserve_summon_event("PlayerAbominationPotWorm",$game_player.x,$game_player.y) if !$game_map.isOverMap
		$game_player.actor.urinary_damage += 150
		$story_stats["sex_record_birth_PotWorm"] +=1
	end
	call_msg("common:Lona/BirthedWorms") if prev_worm_birth != $story_stats["sex_record_birth_PotWorm"]
end
EvLib.sum("WastePee",coconaEV.x,coconaEV.y) if coconaEV
#EvLib.sum("WasteRandom3",$game_player.x,$game_player.y) 
chk_force_aggro_around_player(tmpIgnoreRace=["Human","Deepone","Moot"],tmpInRange=5,tmpSensorStr=7,tmpAggroTime=300)

$story_stats["sex_record_peed"] +=1
$story_stats["sex_record_seen_peeing"] +=1 if $game_player.innocent_spotted?

$story_stats["record_CoconaPeeWith"] +=1
$game_actors[1].portrait.zoom_x = 1
$game_actors[1].portrait.zoom_y = 1
$game_actors[1].portrait.angle = 0
$game_actors[1].portrait.mirror = false
$game_NPCLayerMain.portrait.zoom_x = 1
$game_NPCLayerMain.portrait.zoom_y = 1
$game_NPCLayerMain.portrait.angle = 1
$game_NPCLayerMain.portrait.mirror = false
$story_stats["ForceChcgMode"] = 0
$game_player.force_update = true
whole_event_end
half_event_key_cleaner









if tmp_fucker_id == nil
	if equips_4_id != -1#檢查裝備 並穿裝
		$game_player.actor.change_equip(4, $data_armors[equips_4_id]) 
		SndLib.sound_equip_armor(100)
		player_force_update
		wait(30)
	end
	
	if equips_6_id != -1#檢查裝備 並穿裝
		$game_player.actor.change_equip(6, $data_armors[equips_6_id])
		SndLib.sound_equip_armor(100)
		player_force_update
		wait(30)
	end
	if equips_2_id != -1#檢查裝備 並穿裝
		$game_player.actor.change_equip(2, $data_armors[equips_2_id])
		SndLib.sound_equip_armor(100)
		player_force_update
		wait(30)
	end
	optain_state("DailyPlusMood",1) if $game_player.actor.state_stack("DailyPlusMood") < 1
else # not nil
	get_character(tmp_fucker_id).opacity = 255
	get_character(tmp_fucker_id).animation = nil
	get_character(tmp_fucker_id).npc.stat.set_stat("mood",0) #so they dont yell for help
	get_character(tmp_fucker_id).call_balloon(5)
	wait(80)
	get_character(tmp_fucker_id).turn_toward_character($game_player)
	get_character(tmp_fucker_id).actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300)
end


eventPlayEnd
