if $game_player.actor.stat["AllowOgrasm"] == true then $game_player.actor.stat["allow_ograsm_record"]=true
	else 
	$game_player.actor.stat["allow_ograsm_record"] = false 
end
if $game_actors[1].state_stack(106) !=0
	$game_player.actor.stat["AllowOgrasm"] = true
	else
	$game_player.actor.stat["AllowOgrasm"] = false
end
$game_player.actor.stat["EventTargetPart"] = "Torture"
p "Playing HCGframe : #{$game_player.actor.stat["EventTargetPart"]} UniqueEvent_Piercing"
$game_portraits.lprt.hide


$cg = TempCG.new(["event_needle_begin"])
call_msg("commonH:Lona/Piercing_begin")
call_msg("commonH:Lona/grab#{talk_style}#{rand(3)}")
$cg.erase



tmpDoHowManyTimes = 4
tmpCurrentDoTimes = 0
tmpGoldPiercing = ["PreDeepone","TrueDeepone"].include?($game_player.actor.stat["RaceRecord"]) || $game_player.actor.sexy >= 100
#$game_player.actor.stat["vagopen"] =0
#$game_player.actor.stat["analopen"] =0

			#$game_player.actor.itemUseBatch($data_items[241]) #AddPiercingNose
			#$game_player.actor.itemUseBatch($data_items[242]) #AddPiercingEar
			#$game_player.actor.itemUseBatch($data_items[243]) #AddPiercingChest
			#$game_player.actor.itemUseBatch($data_items[244]) #AddPiercingBelly
			#$game_player.actor.itemUseBatch($data_items[245]) #AddPiercingArms
			#$game_player.actor.itemUseBatch($data_items[246]) #AddPiercingAnal
			#$game_player.actor.itemUseBatch($data_items[247]) #AddPiercingVag
			#$game_player.actor.itemUseBatch($data_items[248]) #AddPiercingBack
			
			#$game_player.actor.itemUseBatch($data_items[249]) #AddPiercingNoseG
			#$game_player.actor.itemUseBatch($data_items[250]) #AddPiercingEarG
			#$game_player.actor.itemUseBatch($data_items[251]) #AddPiercingChestG
			#$game_player.actor.itemUseBatch($data_items[252]) #AddPiercingBellyG
			#$game_player.actor.itemUseBatch($data_items[253]) #AddPiercingArmsG
			#$game_player.actor.itemUseBatch($data_items[254]) #AddPiercingAnalG
			#$game_player.actor.itemUseBatch($data_items[255]) #AddPiercingVagG
			#$game_player.actor.itemUseBatch($data_items[256]) #AddPiercingBackG
			
until tmpCurrentDoTimes == tmpDoHowManyTimes
	tmpCurrentDoTimes +=1
	tmpCanDoArray = []
	tmpCanDoArray << "nose"		if !$game_player.actor.max_state_stack?("PiercingNose")		|| !$game_player.actor.max_state_stack?("PiercingNoseG")
	tmpCanDoArray << "noseB"	if !$game_player.actor.max_state_stack?("PiercingNoseB")	|| !$game_player.actor.max_state_stack?("PiercingNoseBG")
	tmpCanDoArray << "head"		if !$game_player.actor.max_state_stack?("PiercingEar")		|| !$game_player.actor.max_state_stack?("PiercingEarG")
	tmpCanDoArray << "chest"	if !$game_player.actor.max_state_stack?("PiercingChest")	|| !$game_player.actor.max_state_stack?("PiercingChestG")
	tmpCanDoArray << "belly"	if !$game_player.actor.max_state_stack?("PiercingBelly")	|| !$game_player.actor.max_state_stack?("PiercingBellyG")
	tmpCanDoArray << "arms"		if !$game_player.actor.max_state_stack?("PiercingArms")		|| !$game_player.actor.max_state_stack?("PiercingArmsG")
	tmpCanDoArray << "anal"		if !$game_player.actor.max_state_stack?("PiercingAnal")		|| !$game_player.actor.max_state_stack?("PiercingAnalG")
	tmpCanDoArray << "vag"		if !$game_player.actor.max_state_stack?("PiercingVag")		|| !$game_player.actor.max_state_stack?("PiercingVagG")
	tmpCanDoArray << "back"		if !$game_player.actor.max_state_stack?("PiercingBack")		|| !$game_player.actor.max_state_stack?("PiercingBackG")
	p "playable events = #{tmpCanDoArray}"
	tmpCanDoArray = ["nose","noseB","head","chest","belly","arms","anal","vag","back"] if tmpCanDoArray.empty?
	tmpCanDoArray = tmpCanDoArray.sample
	
	case tmpCanDoArray
		when "nose"
				curLV = $game_player.actor.state_stack(54) + $game_player.actor.state_stack(62) #AidPiercingNose 
				msxLV = !tmpGoldPiercing ? $data_states[54].max_stacks : $data_states[62].max_stacks
				3.times{$game_player.actor.itemUseBatch($data_items[221])} if curLV >= msxLV
				lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(-120+rand(15),-150+rand(15))
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg5fuck_#{chcg_cumming_mood_decider}"
				$game_portraits.rprt.set_position(-120+rand(15),-150+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_items[249]) #AddPiercingNoseG
				else
					$game_player.actor.itemUseBatch($data_items[241]) #AddPiercingNose
				end
		when "noseB"
				curLV = $game_player.actor.state_stack("PiercingNoseB") + $game_player.actor.state_stack("PiercingNoseBG") #AidPiercingNose 
				msxLV = !tmpGoldPiercing ? $data_StateName["PiercingNoseB"].max_stacks : $data_StateName["PiercingNoseBG"].max_stacks
				3.times{$game_player.actor.itemUseBatch($data_ItemName["AidPiercingNoseB"])} if curLV >= msxLV
				lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(-120+rand(15),-150+rand(15))
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg5fuck_#{chcg_cumming_mood_decider}"
				$game_portraits.rprt.set_position(-120+rand(15),-150+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_ItemName["AddPiercingNoseBG"])
				else
					$game_player.actor.itemUseBatch($data_ItemName["AddPiercingNoseB"])
				end
				
		when "head"
				curLV = $game_player.actor.state_stack(55) + $game_player.actor.state_stack(63) #AidPiercingEar 
				if $game_player.actor.state_stack(63) >= $data_states[63].max_stacks
					msxLV = 1
				else
					msxLV = !tmpGoldPiercing ? $data_states[55].max_stacks : $data_states[63].max_stacks
				end
				3.times{$game_player.actor.itemUseBatch($data_items[222])} if curLV >= msxLV
				lona_mood "chcg5fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(-120+rand(15),-150+rand(15))
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg5fuck_#{chcg_cumming_mood_decider}"
				$game_portraits.rprt.set_position(-120+rand(15),-150+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_items[250]) #AddPiercingEarG
				else
					$game_player.actor.itemUseBatch($data_items[242]) #AddPiercingEar
				end
				
				
		when "chest"
				$game_player.actor.change_equip(2, nil)
				$game_player.actor.change_equip(3, nil)
				curLV = $game_player.actor.state_stack(56) + $game_player.actor.state_stack(64) #AidPiercingChest 
				msxLV = !tmpGoldPiercing ? $data_states[56].max_stacks : $data_states[64].max_stacks
				3.times{$game_player.actor.itemUseBatch($data_items[223])} if curLV >= msxLV
				lona_mood "chcg4fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.stat["subpose"] =2
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(-79+rand(15),-86+rand(15))
				
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg4fuck_#{chcg_cumming_mood_decider}"
				$game_player.actor.stat["subpose"] =2
				$game_portraits.rprt.set_position(-79+rand(15),-86+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_items[251]) #AddPiercingChestG
				else
					$game_player.actor.itemUseBatch($data_items[243]) #AddPiercingChest
				end
				
				
		when "belly"
				curLV = $game_player.actor.state_stack(57) + $game_player.actor.state_stack(65) #AidPiercingBelly 
				msxLV = !tmpGoldPiercing ? $data_states[57].max_stacks : $data_states[65].max_stacks
				3.times{$game_player.actor.itemUseBatch($data_items[224])} if curLV >= msxLV
				lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(-125+rand(15),-93+rand(15))
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
				$game_portraits.rprt.set_position(-125+rand(15),-93+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_items[252]) #AddPiercingBellyG
				else
					$game_player.actor.itemUseBatch($data_items[244]) #AddPiercingBelly
				end
				
		when "arms"
				$game_player.actor.change_equip(2, nil)
				$game_player.actor.change_equip(3, nil)
				curLV = $game_player.actor.state_stack(58) + $game_player.actor.state_stack(66) #AidPiercingArms 
				msxLV = !tmpGoldPiercing ? $data_states[58].max_stacks : $data_states[66].max_stacks
				3.times{$game_player.actor.itemUseBatch($data_items[225])} if curLV >= msxLV
				lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(10+rand(15),-90+rand(15))
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
				$game_portraits.rprt.set_position(10+rand(15),-90+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_items[253]) #AddPiercingArmsG
				else
					$game_player.actor.itemUseBatch($data_items[245]) #AddPiercingArms
				end
				
		when "anal"
				curLV = $game_player.actor.state_stack(59) + $game_player.actor.state_stack(67) #AidPiercingAnal 
				msxLV = !tmpGoldPiercing ? $data_states[59].max_stacks : $data_states[67].max_stacks
				3.times{$game_player.actor.itemUseBatch($data_items[226])} if curLV >= msxLV
				lona_mood "chcg2fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(-130+rand(15),-90+rand(15))
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg2fuck_#{chcg_cumming_mood_decider}"
				$game_portraits.rprt.set_position(-130+rand(15),-90+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_items[254]) #AddPiercingAnalG
				else
					$game_player.actor.itemUseBatch($data_items[246]) #AddPiercingAnal
				end
				
		when "vag"
				curLV = $game_player.actor.state_stack(60) + $game_player.actor.state_stack(68) #AddPiercingVagG 
				msxLV = !tmpGoldPiercing ? $data_states[60].max_stacks : $data_states[68].max_stacks
				3.times{$game_player.actor.itemUseBatch($data_items[227])} if curLV >= msxLV
				lona_mood "chcg1fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(-65+rand(15),-103+rand(15))
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg1fuck_#{chcg_cumming_mood_decider}"
				$game_portraits.rprt.set_position(-65+rand(15),-103+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_items[255]) #AddPiercingVagG
				else
					$game_player.actor.itemUseBatch($data_items[247]) #AddPiercingVag
				end
				
		when "back"
				$game_player.actor.change_equip(2, nil)
				$game_player.actor.change_equip(3, nil)
				curLV = $game_player.actor.state_stack(61) + $game_player.actor.state_stack(69) #AidPiercingBack 
				msxLV = !tmpGoldPiercing ? $data_states[61].max_stacks : $data_states[69].max_stacks
				3.times{$game_player.actor.itemUseBatch($data_items[228])} if curLV >= msxLV
				lona_mood "chcg3fuck_#{chcg_shame_mood_decider}"
				$game_player.actor.actor_ForceUpdate
				$game_portraits.rprt.set_position(-180+rand(15),-103+rand(15))
				
				call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
				
				lona_mood "chcg3fuck_#{chcg_cumming_mood_decider}"
				$game_portraits.rprt.set_position(-180+rand(15),-103+rand(15))
				if tmpGoldPiercing
					$game_player.actor.itemUseBatch($data_items[256]) #AddPiercingBackG
				else
					$game_player.actor.itemUseBatch($data_items[248]) #AddPiercingBack
				end
	end
load_script("Data/Batch/needle_wounds_control.rb")
check_over_event
$game_player.actor.actor_ForceUpdate
call_msg("commonH:Lona/frame#{talk_style}#{rand(10)}")
end

$game_message.add("\\t[commonH:Lona/VagNeedle_end#{talk_style}]")
$game_map.interpreter.wait_for_message

$game_player.actor.stat["EventTargetPart"] = nil
$game_player.actor.stat["AllowOgrasm"] = false if $game_player.actor.stat["allow_ograsm_record"] == false

$story_stats["sex_record_torture"] +=1
half_event_key_cleaner
chcg_background_color_off
