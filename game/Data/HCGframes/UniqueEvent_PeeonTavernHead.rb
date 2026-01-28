#本事件會複寫除了 VAG以外所有的EVENT KEY 但不包含RACE KEY 本流程以RACE KEY偵測那些FRAME需要撥放之
#先頭旗標 清除所有的EVENT KEY 
if $story_stats["Setup_UrineEffect"] !=1
half_event_key_cleaner
chcg_background_color_off
return portrait_hide
end
if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0 || $game_actors[1].state_stack(107) !=0
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture" if $game_actors[1].state_stack(106) !=0 && $game_actors[1].state_stack(107) ==0
$game_player.actor.stat["EventTargetPart"] = "Shame" if $game_actors[1].state_stack(107) ==1
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_PeeonHead"
$game_portraits.lprt.hide


chcg_background_color
#half_event_key_cleaner
chcg_decider_basic(pose=5)
########################################################################frame 0 至中畫面 準備撥放###################################################################################################
lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
$game_player.actor.stat["chcg_x"] = -177 ; $game_player.actor.stat["chcg_y"] = -149
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/PeeonHead_begin]")
$game_map.interpreter.wait_for_message
	########################################################################frame 6###################################################################################################
	if $game_player.actor.stat["EventMouthRace"] != nil #若本SLOT 非空白則撥放之
	$game_player.actor.stat["EventMouth"] ="Peeon"
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -238 ; $game_player.actor.stat["chcg_y"] = -117
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/FloorClearnPee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_dirt
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$story_stats["sex_record_golden_shower"] +=1
	end
	
	
	########################################################################frame 1###################################################################################################
	if $game_player.actor.stat["EventAnalRace"] != nil #若本SLOT 非空白則撥放之
	$game_player.actor.stat["EventAnal"] ="Peeon"
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -76 ; $game_player.actor.stat["chcg_y"] = -145
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/peeon_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_dirt
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$story_stats["sex_record_golden_shower"] +=1
	end
	
	########################################################################frame 1###################################################################################################
	if $game_player.actor.stat["EventVagRace"] != nil #若本SLOT 非空白則撥放之
	$game_player.actor.stat["EventVag"] ="Peeon"
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -182 ; $game_player.actor.stat["chcg_y"] = -91
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/FloorClearnPee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_dirt
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$story_stats["sex_record_golden_shower"] +=1
	end
	
	########################################################################frame 2###################################################################################################
	if $game_player.actor.stat["EventExt1Race"] != nil #若本SLOT 非空白則撥放之
	$game_player.actor.stat["EventExt1"] ="Peeon"
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -155 ; $game_player.actor.stat["chcg_y"] = -60
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/peeon_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_dirt
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$story_stats["sex_record_golden_shower"] +=1
	end
	
	########################################################################frame 3###################################################################################################
	if $game_player.actor.stat["EventExt2Race"] != nil #若本SLOT 非空白則撥放之
	$game_player.actor.stat["EventExt2"] ="Peeon"
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -227 ; $game_player.actor.stat["chcg_y"] = -128
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/FloorClearnPee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_dirt
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$story_stats["sex_record_golden_shower"] +=1
	end
	
	########################################################################frame 4###################################################################################################
	if $game_player.actor.stat["EventExt3Race"] != nil #若本SLOT 非空白則撥放之
	$game_player.actor.stat["EventExt3"] ="Peeon"
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -128 ; $game_player.actor.stat["chcg_y"] = -58
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/peeon_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_dirt
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$story_stats["sex_record_golden_shower"] +=1
	end
	
	########################################################################frame 5###################################################################################################
	if $game_player.actor.stat["EventExt4Race"] != nil #若本SLOT 非空白則撥放之
	$game_player.actor.stat["EventExt4"] ="Peeon"
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -60 ; $game_player.actor.stat["chcg_y"] = -98
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.stat["mouth"] = 4
	$game_player.actor.portrait.update
	load_script("Data/Batch/FloorClearnPee_control.rb")
	#stats_batch3
	#stats_batch4
	#stats_batch5
	#stats_batch6
	check_over_event
	#add_dirt
	#message control
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$story_stats["sex_record_golden_shower"] +=1
	end
	
	########################################################################frame 99 至中畫面 結束###################################################################################################
	lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
	$game_player.actor.stat["chcg_x"] = -136 ; $game_player.actor.stat["chcg_y"] = -112
	$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
	$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
	$game_player.actor.portrait.update
	#message control
	$game_message.add("\\t[commonH:Lona/peeon_end]")
	$game_map.interpreter.wait_for_message
	$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
	$game_map.interpreter.wait_for_message
	$game_message.add("\\t[commonH:Lona/peeon_end#{talk_style}]")
	$game_map.interpreter.wait_for_message
	###################################################################

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

half_event_key_cleaner
chcg_background_color_off
