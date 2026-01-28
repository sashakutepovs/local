

DataManager.saveFileDeleteDoom if $story_stats["Setup_Hardcore"] >= 2


portrait_off
SndLib.bgm_stop(2000)
SndLib.bgs_stop(2000)
$hudForceHide = true
$balloonForceHide = true
$game_temp.choice = -1 #還原OPTION
$game_player.unset_chs_sex if $game_player.actor.action_state == :sex
$game_player.cancel_stun_effect if $game_player.actor.action_state == :stun
$game_player.actor.cancel_holding if $game_player.actor.action_state == :skill
$game_player.animation = $game_player.animation_overkill_melee_reciver_loop if !$game_player.animation
if $game_player.actor.health <= 0 #why i made this check for 140 frames wait?  i dont know.
	wait(10)
	if $game_player.actor.stat["RaceRecord"] == "Abomination"
		#EvLib.sum("EffectOverKill",$game_player.x,$game_player.y)
		EvLib.sum("EffectAbomLonaDed",$game_player.x,$game_player.y)
		until $game_player.opacity <= 0
			$game_player.opacity -= 5
			wait(1)
		end
		wait(120)
	end
	wait(130)
end
SndLib.sys_GameOver
screen.start_tone_change(Tone.new(-100,-100,-100,255),60)
wait(60)
screen.start_tone_change(Tone.new(-255,-255,-255,255),60)
wait(60)
map_background_color(0,0,0,255,0)
chcg_background_color(0,0,0,255)
if [0,1].include?($story_stats["RecQuestSewerSawGoblin"]) # <0 or 1 = =still in Tutorial
	GabeSDK.getAchievement("DedTutorial")
else
	GabeSDK.getAchievement("GameOver")
end
$cg = TempCG.new(["event_death"])
wait(120)
call_msg("commonEnding:Lona/hp0_begin")
load_script("Data/HCGframes/OverEvent_RebirthCheck.rb")
if !$inheritance
	call_msg("commonEnding:Lona/hp0_end")
end

$cg.erase
portrait_hide
wait(60)
portrait_off
SceneManager.goto(Scene_Gameover)

#end若以後新增條件 請放這
