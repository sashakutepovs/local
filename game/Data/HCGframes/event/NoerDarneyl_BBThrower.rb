
get_character(0).opacity = 255
targetWindow = []
	$game_map.events.each{|event|
		next if !event[1].summon_data
		next if event[1].summon_data[:Window] != true
		targetWindow << event[1]
	}
targetWindow = targetWindow.sample
return if !targetWindow
#targetWindow.call_balloon(19) if targetWindow
get_character(0).opacity = 255
get_character(0).moveto(targetWindow.x,targetWindow.y)
mode = [true,false].sample #true = L   false = R
SndLib.openDoor(100,90)
SndLib.sound_MaleWarriorAtk(80,90)

if mode #left
	tmpThrowX = get_character(0).x
else #right
	tmpThrowX = get_character(0).x+1
end
EvLib.sum("Darneyl_BBThrow",tmpThrowX,get_character(0).y-1)
#tmpBB_id = $game_map.get_storypoint("Baby")[2]
#get_character(tmpBB_id).animation = nil
#get_character(tmpBB_id).moveto(tmpThrowX,get_character(0).y-1)
#get_character(tmpBB_id).summon_data[:begin] = true
#get_character(tmpBB_id).move_type = 3
#get_character(tmpBB_id).opacity = 0

if mode #left
	tmpAni =	[
		[0,0,6,0,0],
		[1,0,6,0,0],
		[2,0,6,0,0],
		[0,1,10,0,0],
		[1,1,15,0,0],
		[2,1,10,0,0],
		[0,3,5,0,0],
		[1,3,5,0,0],
		[2,3,5,0,0]
	]
else #right
	tmpAni =	[
		[0,0,6,0,0],
		[1,0,6,0,0],
		[2,0,6,0,0],
		[0,2,10,0,0],
		[1,2,15,0,0],
		[2,2,10,0,0],
		[0,3,5,0,0],
		[1,3,5,0,0],
		[2,3,5,0,0]
	]
end
get_character(0).animation = get_character(0).aniCustom(tmpAni,0)

