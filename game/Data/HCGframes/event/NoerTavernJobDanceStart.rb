$game_map.interpreter.chcg_background_color(0,0,0,0,7)


get_character(0).switch2_id[2] = $game_party.gold
tmpX,tmpY,tmpID =  $game_map.get_storypoint("Dancer")
get_character(tmpID).delete

$game_player.moveto(tmpX,tmpY)
$game_player.direction = 2

##set NPC to dancer
$game_map.npcs.each do |event| 
	next if event.actor.action_state == :death
	event.npc_story_mode(true)
	next if event.summon_data == nil
	next event.npc_story_mode(true,false) if event.summon_data[:SkipJob]
	next if !event.summon_data[:customer]
	event.summon_data[:od]=event.direction
	event.summon_data[:ox]=event.x
	event.summon_data[:oy]=event.y
	event.summon_data[:ot]=event.trigger
	event.summon_data[:throwed_money]=false
	event.summon_data[:wanna_fuck]=false
	next if event.actor.action_state == :stun
	next if event.region_id == 2
	posi=$game_map.region_map[2].sample
	next if $game_map.events_xy(posi[0],posi[1]).any?{|ev| ev.npc?}
	event.setup_audience
	event.moveto(posi[0],posi[1])
end



$game_map.npcs.each do |event| 
	next if event.actor.action_state == :death
	next if event.summon_data == nil
	next if !event.summon_data[:customer]
	event.trigger=-1
	next if event.actor.action_state == :stun
	next if event.faced_character?($game_player)
	event.turn_toward_character($game_player)
end


tmpID=$game_map.get_storypoint("DdrBox")[2]
get_character(tmpID).opacity=255
get_character(tmpID).call_balloon(19,-1)
posi=$game_map.region_map[3].sample
get_character(tmpID).moveto(posi[0],posi[1])


$game_map.interpreter.chcg_background_color(0,0,0,255,-7)

call_timer(10,60)

set_this_event_force_page(4)
