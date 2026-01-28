

$game_player.actor.portrait.shake
$game_player.actor.mood -= (rand(2)+1) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_player.actor.mood -= (rand(2)+1) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_player.actor.mood += (rand(2)+2) if $game_player.actor.stat["Nymph"] ==1 #change to +mood
$game_player.actor.mood += (rand(2)+2) if $game_player.actor.stat["Masochist"] ==1 #change to +mood


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
		tmpExp = tmpExp*tmpBouns
end
$game_player.actor.gain_exp(tmpExp)
#-------------------------------------------------------------
$game_player.actor.dirt += rand(6)
$game_player.actor.arousal += rand(3) * ($game_player.actor.stat["AsVulva_Skin"]*10) #皮膚性器化
$game_player.actor.arousal += rand(15)+(rand(2) * $game_player.actor.sensitivity_vag) #v敏感
$game_player.actor.arousal += rand(15) if $game_player.actor.stat["Nymph"] ==1
$game_player.actor.arousal += rand(15) if $game_player.actor.stat["Masochist"] ==1
$game_player.actor.arousal += rand(15) if $game_player.actor.stat["WeakSoul"] ==1
$game_player.actor.arousal += (10*$game_player.actor.state_stack(32)) # feels hot
$game_player.actor.arousal += 5 if $game_player.actor.state_stack(31) ==1 # feels warm 
$game_player.actor.sta -= 1

SndLib.sound_chcg_full(rand(10)+90)
