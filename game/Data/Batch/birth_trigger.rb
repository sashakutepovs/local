$game_player.actor.add_state(28) #add wet
$game_player.actor.sta -=1
flash_screen(Color.new(255,0,0,200),8,false)
SndLib.sound_Heartbeat(95)
SndLib.sound_chs_dopyu(100)
$game_message.add("\\t[common:Lona/preglv5_birth_start]") #使用p5來做到出產前的訊息撥放
$game_map.interpreter.wait_for_message
5.times{
	$game_player.actor.sta -=1
	flash_screen(Color.new(255,0,0,200),8,false)
	SndLib.sound_Heartbeat(95)
	SndLib.sound_chs_dopyu(100)
	$game_message.add("\\t[common:Lona/preglv5_birth_start_pain#{rand(5)}]") #rand pain dialog
	$game_map.interpreter.wait_for_message
}
$story_stats["dialog_wet"] =0 if $game_player.actor.stat["Nymph"] != 1
case $game_player.actor.baby_race
	when "Human"		;load_script("Data/HCGframes/BirthEvent_Human.rb")
	when "Moot"			;load_script("Data/HCGframes/BirthEvent_Moot.rb")
	when "Deepone"		;load_script("Data/HCGframes/BirthEvent_Human.rb")
	when "Fishkind"		;load_script("Data/HCGframes/BirthEvent_Fishkind.rb")
	when "Orkind"		;load_script("Data/HCGframes/BirthEvent_Orkind.rb")
	when "Goblin"		;load_script("Data/HCGframes/BirthEvent_Goblin.rb")
	when "Abomination"	;load_script("Data/HCGframes/BirthEvent_Abomination.rb")
	else ; "Others"		;load_script("Data/HCGframes/BirthEvent_Miscarriage.rb")
end

$game_player.actor.belly_size_control