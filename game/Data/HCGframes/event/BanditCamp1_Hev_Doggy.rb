chcg_background_color(0,0,0,0,7)

tmpWkX,tmpWkY,tmpWkID =  $game_map.get_storypoint("WakeUp")
tmpTorX,tmpTorY,tmpTorID =  $game_map.get_storypoint("TorPT")
tmpMcX,tmpMcY,tmpMcID =  $game_map.get_storypoint("MapCont")
tmpDgX,tmpDgY,tmpDgID =  $game_map.get_storypoint("Doggy")
get_character(tmpDgID).force_update = true
get_character(tmpWkID).switch2_id[1] = 0
get_character(tmpWkID).switch2_id[3] = 1
get_character(tmpMcID).trigger = -1
set_event_force_page(tmpTorID,2)
$game_player.moveto(tmpTorX,tmpTorY)
$game_player.direction = 2
$game_player.actor.setup_state(161,10)

tmpFaker = nil
$game_map.npcs.any?{|event|
 next if event.summon_data == nil
 next if !event.summon_data[:customer]
 next if event.actor.action_state == :death
tmpFaker = event
}
tmpFaker = $game_player if tmpFaker == nil

##set NPC to dancer
$game_map.npcs.each do |event|
 next if event.summon_data == nil
 next if !event.summon_data[:customer]
 next if event.actor.action_state == :death
 next if event.actor.action_state == :stun
 posi=$game_map.region_map[14].sample
 event.animation =  nil
 event.moveto(posi[0],posi[1])
end



$game_map.npcs.each do |event| 
 next if event.summon_data == nil
 next if !event.summon_data[:customer]
 next if event.actor.action_state == :death
 next if event.actor.action_state == :stun
 next if event.faced_character?(get_character(tmpTorID))
 event.turn_toward_character(get_character(tmpTorID))
end


#call_msg("doggy event begin dialog")

wait(1)
SndLib.dogSpot
wait(60)
SndLib.dogAtk
wait(60)
SndLib.dogSpot
wait(60)
portrait_hide
get_character(tmpDgID).moveto(tmpTorX,tmpTorY+2)
cam_follow(tmpDgID,0)
chcg_background_color(0,0,0,255,-7)
########################################################
########################################################
########################################################
########################################################
######################################################## 


########################################################  第一次犬交?
if $story_stats["RecordBanditCampFirstTimeDoggy"] == 0
	$story_stats["RecordBanditCampFirstTimeDoggy"] = 1
	call_msg("TagMapBanditCamp1:HevDoggy/begin1_fristTime0")
	$game_player.actor.stat["Nymph"] == 0 ? call_msg("TagMapBanditCamp1:HevDoggy/begin1_fristTime1") : call_msg("TagMapBanditCamp1:HevDoggy/begin1_fristTime1_nymph")
	call_msg("TagMapBanditCamp1:HevDoggy/begin1_fristTime2")
else
	call_msg("TagMapBanditCamp1:HevDoggy/begin1")
end
portrait_off

########################################################  正撥放
get_character(tmpDgID).move_forward
wait(30)
SndLib.dogSpot
call_msg("TagMapBanditCamp1:HevDoggy/begin2")

######################################################################################## 
set_event_force_page(tmpTorID,3)
$game_player.transparent = true
get_character(tmpDgID).delete
#get_character(tmpDgID).moveto(1,1)
SndLib.dogHurt
call_msg("TagMapBanditCamp1:HevDoggy/begin3")

get_character(tmpTorID).force_update = true
load_script("Data/Batch/VagDilatation_control.rb")
$story_stats.sex_record_vag(["DataNpcName:race/Dog" , "DataNpcName:part/penis"])
$story_stats["sex_record_vaginal_count"] +=1
check_over_event
cam_follow(tmpTorID,0)
########################################################################################
#lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
#lona_mood "chcg2fuck_#{chcg_mood_decider}"
#$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))

call_msg("TagMapBanditCamp1:HevDoggy/begin4")
portrait_off
$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-148+rand(10),-65+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event

call_msg("TagMapBanditCamp1:HevDoggy/begin5")
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-148+rand(10),-65+rand(10))

call_msg("TagMapBanditCamp1:HevDoggy/begin6")
portrait_off
########################################################################################

10.times{
$game_player.actor.take_skill_effect(tmpFaker.actor,$data_arpgskills["BasicSexDmg_receiver"])
SndLib.sound_chs_dopyu(60)
SndLib.dogHurt if rand(100) >= 60
check_over_event
wait(40)
}

$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-148+rand(10),-65+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin7")
portrait_off
call_msg("TagMapBanditCamp1:HevDoggy/begin8")
portrait_off

set_event_force_page(tmpTorID,4)
20.times{
$game_player.actor.take_skill_effect(tmpFaker.actor,$data_arpgskills["BasicSexDmg_receiver"])
SndLib.sound_chs_dopyu(60)
SndLib.dogHurt if rand(100) >= 80
check_over_event
wait(20)
}

$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-148+rand(10),-65+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin9")
portrait_off
call_msg("TagMapBanditCamp1:HevDoggy/begin9_1")
portrait_off


$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
chcg_add_cums("Others","CumsCreamPie")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin10")

$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
chcg_add_cums("Others","CumsCreamPie")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin11")

$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
chcg_add_cums("Others","CumsCreamPie")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin12")

$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
chcg_add_cums("Others","CumsCreamPie")
chcg_add_cums("Others","CumsCreamPie")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin13")
call_msg("TagMapBanditCamp1:HevDoggy/begin14")
portrait_off
set_event_force_page(tmpTorID,5)
call_msg("TagMapBanditCamp1:HevDoggy/begin14_1")
5.times{
$game_player.actor.take_skill_effect(tmpFaker.actor,$data_arpgskills["BasicSexDmg_receiver"])
SndLib.sound_chs_dopyu(60)
$game_map.interpreter.screen.start_shake(5,10,10)
SndLib.dogHurt
check_over_event
wait(60)
}

call_msg("TagMapBanditCamp1:HevDoggy/begin15")
portrait_off

$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside1"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin16")
$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside2"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin17")
portrait_off

2.times{
lona_mood "p5sta_damage"
$game_player.actor.portrait.shake
get_character(tmpTorID).move_goto_xy(tmpTorX-2,tmpTorY)
$game_player.moveto(get_character(tmpTorID).x,get_character(tmpTorID).y)
$game_player.actor.take_skill_effect(tmpFaker.actor,$data_arpgskills["BasicSexDmg_receiver"])
SndLib.sound_chs_dopyu(60)
check_over_event
wait(60)
}

call_msg("TagMapBanditCamp1:HevDoggy/begin18")
portrait_off


get_character(tmpTorID).mirror = true
4.times{
lona_mood "p5sta_damage"
$game_player.actor.portrait.shake
get_character(tmpTorID).move_goto_xy(tmpTorX+2,tmpTorY)
$game_player.moveto(get_character(tmpTorID).x,get_character(tmpTorID).y)
$game_player.actor.take_skill_effect(tmpFaker.actor,$data_arpgskills["BasicSexDmg_receiver"])
SndLib.sound_chs_dopyu(60)
check_over_event
wait(60)
}

call_msg("TagMapBanditCamp1:HevDoggy/begin19")


$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside3"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin20")
$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside3"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin21")
$game_player.actor.stat["EventVagRace"] = "Fishkind"
$game_player.actor.stat["EventVag"] ="CumInside3"
$game_player.actor.stat["vagopen"] = 1
lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
$game_portraits.rprt.set_position(-130+rand(10),-75+rand(10))
load_script("Data/Batch/chcg_basic_frame_vag.rb")
load_script("Data/Batch/take_other_vag.rb")
load_script("Data/Batch/take_sex_wound_groin.rb")
check_over_event
call_msg("TagMapBanditCamp1:HevDoggy/begin22")
portrait_off

########################################################
########################################################
########################################################
########################################################
######################################################## 
######################################################## recover all event 

chcg_background_color(0,0,0,0,7)
get_character(tmpTorID).force_update = false
get_character(tmpTorID).mirror = false
$game_player.transparent = false
$game_player.actor.sta = -100
$game_player.moveto(tmpTorX,tmpTorY)
get_character(tmpTorID).moveto(tmpTorX,tmpTorY)
set_event_force_page(tmpTorID,2)
cam_center(0)
$game_map.npcs.each do |event|
 next if event.summon_data == nil
 next if !event.summon_data[:customer]
 next if event.actor.action_state == :death
 next if event.actor.action_state == :stun
 posi=$game_map.region_map[12].sample
 event.animation =  nil
 event.turn_toward_character(get_character(tmpTorID))
 event.moveto(posi[0],posi[1])
end
call_msg("TagMapBanditCamp1:HevDoggy/begin23")
chcg_background_color(0,0,0,255,-7)

whole_event_end
portrait_off

