return load_script("Data/HCGframes/EventVag_CumInside_Overcum.rb") if $story_stats["Setup_UrineEffect"] == 0
if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Vag"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} CumInside_Overcum_Peein"
$game_portraits.lprt.hide

if chcg_decider_basic_vag == "chcg5" #若CHCG為5則將擋住LOW PANNEL的事件暫時移除  並在事件結束時寫回去
	temp_mouth_record = $game_player.actor.stat["EventMouth"]
	temp_ext1_record = $game_player.actor.stat["EventExt1"]
	$game_player.actor.stat["LowPanel"] = 1
	$game_player.actor.stat["EventMouth"] = nil
	$game_player.actor.stat["EventExt1"] = nil
end

#######################################################################frame 0###################################################################################################
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "#{chcg_decider_basic_vag}fuck_#{chcg_mood_decider}"
			#normal cam
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -138 ; $game_player.actor.stat["chcg_y"] = -65 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -165 ; $game_player.actor.stat["chcg_y"] = -89 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -64 ; $game_player.actor.stat["chcg_y"] = -78 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -203 ; $game_player.actor.stat["chcg_y"] = -103 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
$game_message.add("\\t[commonH:Lona/EventVag_begin]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
=begin
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "#{chcg_decider_basic_vag}fuck_#{chcg_mood_decider}"

$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -88 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -78 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -137 ; $game_player.actor.stat["chcg_y"] = -57 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -66 ; $game_player.actor.stat["chcg_y"] = -119 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_vag.rb")
#stats_batch3
#stats_batch4
#stats_batch5
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
=end
########################################################################frame 2###################################################################################################
$game_player.actor.stat["EventVag"] ="CumInside2"
$game_player.actor.stat["vagopen"] = 1
lona_mood "#{chcg_decider_basic_vag}fuck_#{chcg_mood_decider}"
			#vag
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -88 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -78 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -137 ; $game_player.actor.stat["chcg_y"] = -57 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -66 ; $game_player.actor.stat["chcg_y"] = -139 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_vag.rb")
chcg_add_cums("EventVagRace","CumsCreamPie")
#stats_batch4
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add vag cums by race
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 3###################################################################################################
$game_player.actor.stat["EventVag"] ="CumInside3"
$game_player.actor.stat["vagopen"] = 1
lona_mood "#{chcg_decider_basic_vag}fuck_#{chcg_mood_decider}"
			#vag
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -88 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -78 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -137 ; $game_player.actor.stat["chcg_y"] = -57 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -66 ; $game_player.actor.stat["chcg_y"] = -119 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_vag.rb")
chcg_add_cums("EventVagRace","CumsCreamPie")
#stats_batch4
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add vag cums by race
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 4###################################################################################################
$game_player.actor.stat["EventVag"] ="CumInsidePeein4"
$game_player.actor.stat["vagopen"] = 1
lona_mood "#{chcg_decider_basic_vag}fuck_#{chcg_mood_decider}"
			#vag
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -88 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -78 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -137 ; $game_player.actor.stat["chcg_y"] = -57 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -66 ; $game_player.actor.stat["chcg_y"] = -139 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_vag.rb")
$game_actors[1].dirt += rand(6)+6
#stats_batch4
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[common:narrator/peein_vag]")
$game_map.interpreter.wait_for_message

########################################################################frame 5###################################################################################################
$game_player.actor.stat["EventVag"] ="CumInsidePeein5"
$game_player.actor.stat["vagopen"] = 1
lona_mood "#{chcg_decider_basic_vag}fuck_#{chcg_mood_decider}"
			#vag
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -88 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -78 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -137 ; $game_player.actor.stat["chcg_y"] = -57 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -66 ; $game_player.actor.stat["chcg_y"] = -139 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_vag.rb")
$game_actors[1].dirt += rand(6)+6
#stats_batch4
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 6###################################################################################################
$game_player.actor.stat["EventVag"] ="CumInsidePeein6"
$game_player.actor.stat["vagopen"] = 1
lona_mood "#{chcg_decider_basic_vag}fuck_#{chcg_mood_decider}"
			#vag
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -88 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -158 ; $game_player.actor.stat["chcg_y"] = -78 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -137 ; $game_player.actor.stat["chcg_y"] = -57 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -66 ; $game_player.actor.stat["chcg_y"] = -139 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -315 ; $game_player.actor.stat["chcg_y"] = -51 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"]
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_vag.rb")
#stats_batch3
#stats_batch4
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################

if chcg_decider_basic_vag == "chcg5" #若CHCG為5則將擋住LOW PANNEL的事件暫時移除  並在事件結束時寫回去
$game_player.actor.stat["EventMouth"] = temp_mouth_record 
$game_player.actor.stat["EventExt1"] = temp_ext1_record
$game_player.actor.stat["LowPanel"] = 0
end

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$story_stats["sex_record_cumin_vaginal"] +=1
$story_stats["sex_record_pussy_wash"] +=1
