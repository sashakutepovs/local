#basic frame damage
#SceneManager.scene.hud.perform_damage_effect #req map hud
$game_player.actor.portrait.shake
$game_player.actor.mood -= (rand(5)+10) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_player.actor.mood -= (rand(8)+20) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_player.actor.mood += (rand(5)+19) if $game_player.actor.stat["Masochist"] ==1 #change to +mood

tmpSight = true
#------------------------------------------------------------- #每FRAME EXP 接收
tmpBouns = 1
#tmpBouns += 0.2 if $game_player.actor.stat["Prostitute"] == 1
tmpBouns += 0.2 if $game_player.actor.stat["Exhibitionism"] == 1 && tmpSight
tmpBouns += 0.2 if $game_player.actor.stat["Masochist"] == 1
#tmpBouns += 0.2 if $game_player.actor.stat["SemenGulper"] == 1
tmpExp = rand(65)+$game_player.actor.level
case $game_player.actor.stat["persona"]
	when "typical"
		tmpExp = ((tmpExp*0.9)*tmpBouns).round
	when "gloomy"
		tmpExp = ((tmpExp*0.6)*tmpBouns).round
	when "tsundere"
		tmpExp = ((tmpExp*0.7)*tmpBouns).round
	when "slut"
		tmpExp = tmpExp*tmpBouns
end
$game_player.actor.gain_exp(tmpExp)
#-------------------------------------------------------------
$game_player.actor.dirt += rand(4)+7
$game_player.actor.arousal -= rand(10)
$game_player.actor.arousal += 1 * ($game_player.actor.stat["AsVulva_Skin"]*10) #皮膚性器化
$game_player.actor.arousal += rand(50) if $game_player.actor.stat["Masochist"] ==1
#$game_player.actor.sta += 10+rand(5)
$game_player.actor.health -= $game_player.actor.subtraction_health(7+rand(10))
$game_player.actor.lactation_level += $game_player.actor.stat["Lactation"] + ($game_player.actor.stat["Mod_MilkGland"]*5) #STATE增加乳汁
$game_player.actor.health -= $game_player.actor.subtraction_health(5+rand(10)) if $story_stats["Setup_Hardcore"] >= 1

$game_player.actor.add_wound("head")
$game_player.actor.add_wound("head")
$game_map.reserve_summon_event("WasteBlood") if !$game_map.isOverMap
$game_map.reserve_summon_event("WasteBlood") if !$game_map.isOverMap


SndLib.sound_gore(60)
