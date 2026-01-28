
$game_player.actor.portrait.shake
$game_actors[1].mood -= (rand(3)+5) if $game_player.actor.stat["Prostitute"] ==0 #change to -mood
$game_actors[1].mood -= (rand(6)+5) if $game_player.actor.stat["IronWill"] ==1 #change to -mood
#Global.good_happen  if aggrement sex
$game_actors[1].mood += (rand(2)+8) if $game_player.actor.stat["Masochist"] ==1 #change to +mood
$game_actors[1].mood += (rand(2)+8) if $game_player.actor.stat["Nymph"] ==1

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
$game_actors[1].arousal += rand(50)
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Nymph"] ==1
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["Masochist"] ==1
$game_actors[1].arousal += rand(50) if $game_player.actor.stat["AsVulva_Anal"]  ==1
$game_actors[1].add_state(40) if $game_actors[1].state_stack(40) !=1 && $game_actors[1].state_stack(43) !=1 #add anal bleed if anal isnt dmged

SndLib.sound_Bubble(80,50)