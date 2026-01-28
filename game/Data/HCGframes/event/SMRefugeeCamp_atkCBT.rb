tmpDuabBiosID=$game_map.get_storypoint("DualBios")[2]
tmpAtkEFXX,tmpAtkEFXY,tmpAtkEFXID=$game_map.get_storypoint("AtkEFX")
tmpHitEFXX,tmpHitEFXY,tmpHitEFXID=$game_map.get_storypoint("HitEFX")
tmpCurX,tmpCurY,tmpCurID=$game_map.get_storypoint("CannonCur")
tmpCBTvictimX,tmpCBTvictimY,tmpCBTvictimID=$game_map.get_storypoint("CBTvictim")
tmpCBTvictimGrapID=$game_map.get_storypoint("CBTvictimGrap")[2]
tmpCurVictimID = get_character(tmpDuabBiosID).summon_data[:CurVictimID]

$bg.erase
get_character(0).switch1_id[1] = 0
get_character(0).switch1_id[0] = 0
SndLib.sound_whoosh(100,170)
SndLib.sys_trigger(100)
get_character(tmpHitEFXID).moveto(get_character(tmpCurID).x,get_character(tmpCurID).y)
get_character(tmpHitEFXID).set_animation("animation_CBTatkEFX")
$game_map.interpreter.screen.start_shake(5,5,5)
if get_character(tmpCurID).x == get_character(tmpCBTvictimID).x && get_character(tmpCurID).y == get_character(tmpCBTvictimID).y
	get_character(tmpCurID).opacity = 0
	$game_map.interpreter.screen.start_shake(24,20,15)
	SndLib.sound_punch_hit(100)
	SndLib.sound_punch_hit(100)
	SndLib.sound_punch_hit(100)
	get_character(tmpAtkEFXID).moveto(get_character(tmpCurID).x,get_character(tmpCurID).y-3)
	get_character(tmpAtkEFXID).set_animation("animation_effect_PunchHit")
	get_character(tmpCurVictimID).summon_data[:hp] -= 1 if get_character(tmpCurVictimID).summon_data[:hp] > 0
	set_event_force_page(tmpCBTvictimID,get_character(tmpCurVictimID).summon_data[:hp]+1)
	get_character(tmpCBTvictimID).move_type = 3 
	#set hit
	# final HP
	if get_character(tmpCurVictimID).summon_data[:hp] <= 0
		SndLib.sound_goblin_death
		set_event_force_page(tmpCBTvictimGrapID,5)
		get_character(tmpCBTvictimGrapID).pattern = 1
		5.times{
			get_character(tmpCBTvictimGrapID).forced_x = rand(5)
			wait(2)
			get_character(tmpCBTvictimGrapID).forced_x = -rand(5)
			wait(2)
		}
		get_character(tmpCBTvictimGrapID).forced_x = 0
		wait(30)
		SndLib.sound_gore(100)
		set_event_force_page(tmpCBTvictimGrapID,6)
		get_character(tmpCBTvictimGrapID).pattern = 0
		wait(10)
		get_character(tmpCBTvictimGrapID).pattern = 1
		wait(10)
		get_character(tmpCBTvictimGrapID).pattern = 2
		wait(10)
		set_event_force_page(tmpCBTvictimGrapID,7)
		wait(60)
		return set_this_event_force_page(3) #exit because he is dead
	# Not ded yet
	else
		set_event_force_page(tmpCBTvictimGrapID,5)
		tmpPattern = get_character(tmpCBTvictimID).x - tmpCBTvictimX
		get_character(tmpCBTvictimGrapID).pattern = tmpPattern
		SndLib.sound_goblin_death
		15.times{
			get_character(tmpCBTvictimGrapID).forced_x = rand(5)
			wait(2)
			get_character(tmpCBTvictimGrapID).forced_x = -rand(5)
			wait(2)
		}
		get_character(tmpCBTvictimGrapID).forced_x = 0
	end
	
	#update to basic graphics
	set_event_force_page(tmpCBTvictimGrapID,get_character(tmpCurVictimID).summon_data[:hp]+1)
	tmpPattern = get_character(tmpCBTvictimID).x - tmpCBTvictimX
	get_character(tmpCBTvictimGrapID).pattern = tmpPattern
end

get_character(tmpCurID).opacity = 255
set_this_event_force_page(4)