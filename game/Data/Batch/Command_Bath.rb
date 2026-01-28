temp_CumsCreamPie =$game_player.actor.cumsMeters["CumsCreamPie"]
temp_CumsMoonPie =$game_player.actor.cumsMeters["CumsMoonPie"]
temp_CumsHead	=$game_player.actor.cumsMeters["CumsHead"]
temp_CumsTop	=$game_player.actor.cumsMeters["CumsTop"]
temp_CumsMid	=$game_player.actor.cumsMeters["CumsMid"]
temp_CumsBot	=$game_player.actor.cumsMeters["CumsBot"]
temp_dirt = $game_player.actor.dirt
!equip_slot_removetable?(0) ? equips_0_id = -1 : equips_0_id = $game_player.actor.equips[0].id #Weapon
if !$game_player.player_cuffed?
	$game_player.actor.healCums("CumsMoonPie", (temp_CumsMoonPie * 0.05).round)
	$game_player.actor.healCums("CumsCreamPie", (temp_CumsCreamPie * 0.05).round)
	$game_player.actor.healCums("CumsHead", (temp_CumsHead * 0.5).round)
	$game_player.actor.healCums("CumsTop", (temp_CumsTop * 0.5).round)
	$game_player.actor.healCums("CumsMid", (temp_CumsMid * 0.5).round)
	$game_player.actor.healCums("CumsBot", (temp_CumsBot * 0.5).round)
	$game_player.actor.healCums("CumsMouth", $game_player.actor.cumsMeters["CumsMouth"])
	$game_player.actor.dirt -= (temp_dirt * 0.5).round
else
	$game_player.actor.healCums("CumsMoonPie", (temp_CumsMoonPie * 0.025).round)
	$game_player.actor.healCums("CumsCreamPie", (temp_CumsCreamPie * 0.025).round)
	$game_player.actor.healCums("CumsHead", (temp_CumsHead * 0.25).round)
	$game_player.actor.healCums("CumsTop", (temp_CumsTop * 0.25).round)
	$game_player.actor.healCums("CumsMid", (temp_CumsMid * 0.25).round)
	$game_player.actor.healCums("CumsBot", (temp_CumsBot * 0.25).round)
	$game_player.actor.healCums("CumsMouth", $game_player.actor.cumsMeters["CumsMouth"])
	$game_player.actor.dirt -= (temp_dirt * 0.25).round
end

$game_player.actor.erase_state(28)#clear wet
$game_player.actor.erase_state(37)#clear Vagbleed
$game_player.actor.erase_state(40)#clear Analbleed
$game_player.actor.erase_state(39)#clear Analbleed
$game_player.actor.erase_state(44)#clear Masturbationed

tmpSight = $game_player.innocent_spotted?
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
#tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.5 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
#tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp = rand(65)+$game_player.actor.level
case $game_player.actor.stat["persona"]
	when "typical"
		tmpExp = ((tmpExp*0.5)*tmpBouns).round
	when "gloomy"
		tmpExp = ((tmpExp*0.3)*tmpBouns).round
	when "tsundere"
		tmpExp = ((tmpExp*0.4)*tmpBouns).round
	when "slut"
		tmpExp = ((tmpExp*0.5)*tmpBouns).round
end
$game_player.actor.gain_exp(tmpExp)
#-------------------------------------------------------------
