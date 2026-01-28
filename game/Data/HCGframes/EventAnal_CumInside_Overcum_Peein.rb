return load_script("Data/HCGframes/EventAnal_CumInside_Overcum.rb") if $story_stats["Setup_UrineEffect"] == 0
if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
$game_player.actor.stat["AllowOgrasm"] = true
$game_player.actor.stat["EventTargetPart"] = "Anal"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} CumInside_Overcum_Peein"
$game_portraits.lprt.hide

if chcg_decider_basic_anal == "chcg5" #若CHCG為5則將擋住LOW PANNEL的事件暫時移除  並在事件結束時寫回去
	temp_mouth_record = $game_player.actor.stat["EventMouth"]
	temp_ext1_record = $game_player.actor.stat["EventExt1"]
	$game_player.actor.stat["LowPanel"] = 1
	$game_player.actor.stat["EventMouth"] = nil
	$game_player.actor.stat["EventExt1"] = nil
end


########################################################################frame 0###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside1"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
			#normal cam
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59 ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -138 ; $game_player.actor.stat["chcg_y"] = -65 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -165 ; $game_player.actor.stat["chcg_y"] = -89 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -203 ; $game_player.actor.stat["chcg_y"] = -103 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
#message control
$game_message.add("\\t[commonH:Lona/EventAnal_begin]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
=begin
$game_player.actor.stat["EventAnal"] ="CumInside1"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
$game_player.actor.stat["chcg_x"] = $game_player.actor.portrait.portrait.x
$game_player.actor.stat["chcg_y"] = $game_player.actor.portrait.portrait.y
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -186 end
$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
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
$game_player.actor.stat["EventAnal"] ="CumInside2"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
chcg_add_cums("EventAnalRace","CumsMoonPie")
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add anal cums
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 3###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside3"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)

			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -186 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
chcg_add_cums("EventAnalRace","CumsMoonPie")
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside1"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
#stats_batch3
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 4###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside2"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -186 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
chcg_add_cums("EventAnalRace","CumsMoonPie")
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add anal cums
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 5###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside3"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
chcg_add_cums("EventAnalRace","CumsMoonPie")
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add anal cums
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 1###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside1"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -186 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
#stats_batch3
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message


########################################################################frame 6###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside2"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
chcg_add_cums("EventAnalRace","CumsMoonPie")
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add anal cums
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 7###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInside3"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
chcg_add_cums("EventAnalRace","CumsMoonPie")
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add anal cums
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
$game_message.add("\\t[common:narrator/peein_anal]")
$game_map.interpreter.wait_for_message

########################################################################frame 9###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInsidePeein4"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -65 ; $game_player.actor.stat["chcg_y"] = -186 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
$game_actors[1].dirt += rand(6)+6
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 10###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInsidePeein5"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -59  ; $game_player.actor.stat["chcg_y"] = -98 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -141 ; $game_player.actor.stat["chcg_y"] = -50 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -58 ; $game_player.actor.stat["chcg_y"] = -125 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
$game_actors[1].dirt += rand(6)+6
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message

########################################################################frame 11###################################################################################################
$game_player.actor.stat["EventAnal"] ="CumInsidePeein6"
$game_player.actor.stat["analopen"] = 1
lona_mood "#{chcg_decider_basic_anal}fuck_#{chcg_mood_decider}"
#xy decider (anal)
			if $game_player.actor.stat["pose"] == "chcg1" then  $game_player.actor.stat["chcg_x"] = -24  ; $game_player.actor.stat["chcg_y"] = -163 end
			if $game_player.actor.stat["pose"] == "chcg2" then  $game_player.actor.stat["chcg_x"] = -206 ; $game_player.actor.stat["chcg_y"] = -27 end
			if $game_player.actor.stat["pose"] == "chcg3" then  $game_player.actor.stat["chcg_x"] = -70 ; $game_player.actor.stat["chcg_y"] = -20 end
			if $game_player.actor.stat["pose"] == "chcg4" then  $game_player.actor.stat["chcg_x"] = -62 ; $game_player.actor.stat["chcg_y"] = -283 end
			if $game_player.actor.stat["pose"] == "chcg5" then  $game_player.actor.stat["chcg_x"] = -276 ; $game_player.actor.stat["chcg_y"] = -79 end
			$game_player.actor.portrait.portrait.x= $game_player.actor.stat["chcg_x"] 
			$game_player.actor.portrait.portrait.y += $game_player.actor.stat["chcg_y"]
load_script("Data/Batch/chcg_basic_frame_anal.rb")
#stats_batch3
#stats_batch4
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_other_anal.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
#add_dirt
#message control
$game_message.add("\\t[commonH:Lona/frame#{talk_style}#{rand(10)}]")
$game_map.interpreter.wait_for_message
################################################################################################

if chcg_decider_basic_anal == "chcg5" #若CHCG為5則將擋住LOW PANNEL的事件暫時移除  並在事件結束時寫回去
$game_player.actor.stat["EventMouth"] = temp_mouth_record 
$game_player.actor.stat["EventExt1"] = temp_ext1_record
$game_player.actor.stat["LowPanel"] = 0
end

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$story_stats["sex_record_cumin_anal"] +=1
$story_stats["sex_record_anal_wash"] +=1

