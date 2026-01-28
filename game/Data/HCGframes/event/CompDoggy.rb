get_character(0).turn_toward_character($game_player)
get_character(0).prelock_direction = get_character(0).direction
SndLib.dogSpot



tmpPicked = ""
tmpQuestList = []
tmpQuestList << [$game_text["commonComp:Companion/Follow"]			,"Follow"]
tmpQuestList << [$game_text["commonComp:Companion/Wait"]			,"Wait"]
tmpQuestList << [$game_text["commonComp:Companion/SetFoe"]			,"SetFoe"]
tmpQuestList << [$game_text["commonComp:Companion/Disband"]			,"Disband"]
		cmd_sheet = tmpQuestList
		cmd_text =""
		for i in 0...cmd_sheet.length
			cmd_text.concat(cmd_sheet[i].first+",")
			p cmd_text
		end
		call_msg("commonComp:CompDoggy/Command",0,2,0)
		show_npc_info(get_character(0),extra_info=false,"\\optB[#{cmd_text}]")

		$game_temp.choice == -1 ? tmpPicked = false : tmpPicked = cmd_sheet[$game_temp.choice][1]
		$game_temp.choice = -1




case tmpPicked
	when "Follow"
		SndLib.dogSpot
		get_character(0).follower[1] =1

	when "Wait"
		SndLib.dogHurt
		get_character(0).follower[1] =0
		
	when "SetFoe"
		$game_temp.choice = 0
		!get_character(0).npc.fated_enemy.include?(4)	? $story_stats["HiddenOPT0"] = "1" : $story_stats["HiddenOPT0"] = "0"
		!get_character(0).npc.fated_enemy.include?(5)	? $story_stats["HiddenOPT1"] = "1" : $story_stats["HiddenOPT1"] = "0"
		!get_character(0).npc.fated_enemy.include?(8)	? $story_stats["HiddenOPT2"] = "1" : $story_stats["HiddenOPT2"] = "0"
		!get_character(0).npc.fated_enemy.include?(9)	? $story_stats["HiddenOPT3"] = "1" : $story_stats["HiddenOPT3"] = "0"
		!get_character(0).npc.fated_enemy.include?(10)	? $story_stats["HiddenOPT4"] = "1" : $story_stats["HiddenOPT4"] = "0"
		call_msg("commonComp:CompDoggy/SetupFateEnemy") #[還原預設,邪惡生物,正義生物,動物<r=HiddenOPT0>,類獸人<r=HiddenOPT1>,魚人<r=HiddenOPT2>,肉魔<r=HiddenOPT3>,不死<r=HiddenOPT4>]
		case $game_temp.choice
		when 0 #default
			get_character(0).npc.set_fated_enemy([])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 1 #attack evil
			get_character(0).npc.set_fated_enemy([])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"morality"=>[0, "<"]}
			get_character(0).npc.assaulter_condition={"morality"=>[0, "<"]}
		when 2 #attack justice
			get_character(0).npc.set_fated_enemy([])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"morality"=>[49, ">"]}
			get_character(0).npc.assaulter_condition={"morality"=>[49, ">"]}
		when 3 #nature animal 4
			get_character(0).npc.add_fated_enemy([4])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 4 #goblin 5
			get_character(0).npc.add_fated_enemy([5])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 5 #fishkind 8
			get_character(0).npc.add_fated_enemy([8,14])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 6 #abom 9
			get_character(0).npc.add_fated_enemy([9])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		when 7 #undead 10
			get_character(0).npc.add_fated_enemy([10])
			get_character(0).npc.fucker_condition={"sex"=>[65535, "="]}
			get_character(0).npc.killer_condition={"sex"=>[65535, "="]}
			get_character(0).npc.assaulter_condition={"sex"=>[65535, "="]}
		end
	when "Disband"
		call_msg("commonComp:CompDoggy/Comp_disband")
		call_msg("common:Lona/Decide_optB")
		cam_center(0)
		if $game_temp.choice == 1
			portrait_hide
			chcg_background_color(0,0,0,0,7)
				portrait_off
				get_character(0).set_this_companion_disband
			chcg_background_color(0,0,0,255,-7)
			SndLib.dogSpot
		end
	SndLib.dogSpot
end



#fraction" 3 Human nature side							中立
#fraction" 4 nature										自然生物
#fraction" 5 goblin/orkind								類獸人
#fraction" 6 Guard										諾爾守衛
#fraction" 7 human Slave Trader(or any evil human)		不法份子
#fraction" 8 fishkind/deepone							漁人
#fraction" 9 Abomination								肉魔
#fraction" 10 Undead									不死生物
#fraction" 11 Elise										伊莉希
#fraction" 12 sybaris									席芭莉絲


$story_stats["HiddenOPT0"] = "0"
$story_stats["HiddenOPT1"] = "0"
$story_stats["HiddenOPT2"] = "0"
$story_stats["HiddenOPT3"] = "0"
$story_stats["HiddenOPT4"] = "0"
eventPlayEnd