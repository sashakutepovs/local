#本事件會複寫除了 VAG以外所有的EVENT KEY 但不包含RACE KEY 本流程以RACE KEY偵測那些FRAME需要撥放之
#先頭旗標 清除所有的EVENT KEY
return if $story_stats["Setup_UrineEffect"] ==0
if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	$game_player.actor.stat["allow_ograsm_record"] = true
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
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_Peeon"
$game_portraits.lprt.hide

chcg_background_color
#half_event_key_cleaner
chcg_decider_peeon(pose=rand(2)+1)
case chcg_decider_peeon
 when "chcg3" ; chcg_decider_basic(pose=3)
 when "chcg4" ; chcg_decider_basic(pose=4)
end
########################################################################frame 0 至中畫面 準備撥放###################################################################################################
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -165 ; $game_player.actor.stat["chcg_y"] = -89 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/peeon_begin]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 6###################################################################################################
if $game_player.actor.stat["EventMouthRace"] != nil #若本SLOT 非空白則撥放之
$game_player.actor.stat["EventMouth"] ="Peeon"
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -298 ; $game_player.actor.stat["chcg_y"] = -68 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -69 ; $game_player.actor.stat["chcg_y"] = -182 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
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
if $game_player.actor.stat["EventAnalRace"] != nil #若本SLOT 非空白則撥放之
$game_player.actor.stat["EventAnal"] ="Peeon"
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -77 ; $game_player.actor.stat["chcg_y"] = -19 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -174 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
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
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -261 ; $game_player.actor.stat["chcg_y"] = -61 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -29 ; $game_player.actor.stat["chcg_y"] = -21 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
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

########################################################################frame 2###################################################################################################
if $game_player.actor.stat["EventExt1Race"] != nil #若本SLOT 非空白則撥放之
$game_player.actor.stat["EventExt1"] ="Peeon"
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -203 ; $game_player.actor.stat["chcg_y"] = -99 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -67 ; $game_player.actor.stat["chcg_y"] = -2 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
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
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -229 ; $game_player.actor.stat["chcg_y"] = -147 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -84 ; $game_player.actor.stat["chcg_y"] = -76 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
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

########################################################################frame 4###################################################################################################
if $game_player.actor.stat["EventExt3Race"] != nil #若本SLOT 非空白則撥放之
$game_player.actor.stat["EventExt3"] ="Peeon"
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -103 ; $game_player.actor.stat["chcg_y"] = -119 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -53 ; $game_player.actor.stat["chcg_y"] = -82 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
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
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -61 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -57 ; $game_player.actor.stat["chcg_y"] = -274 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
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

########################################################################frame 99 至中畫面 結束###################################################################################################
lona_mood "#{chcg_decider_peeon}fuck_#{chcg_shame_mood_decider}"
if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -165 ; $game_player.actor.stat["chcg_y"] = -89 end
if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -30 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
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
