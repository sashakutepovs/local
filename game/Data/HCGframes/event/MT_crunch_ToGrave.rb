if $game_map.threat
	SndLib.sys_buzzer
	$game_map.popup(0,"QuickMsg:Lona/incombat#{rand(2)}",0,0)
	return
end
tmpData = ["UnderGround",nil,nil,nil, #shadow
nil, #Fog
nil,nil,nil, #weather
128,128,40,60,0, #MAP BG
"D/07 - undead loop",70,80,nil, #BGM
"forest_unname",10,nil,nil] #BGS
moveto_teleport_point("ToCave",tmpData,4)
