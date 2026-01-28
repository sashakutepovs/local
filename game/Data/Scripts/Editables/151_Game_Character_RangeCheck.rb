###################################################################################################################
###################################################################################################################
######################################## Steal, for Lona only SYSTEM    #####################################################
###################################################################################################################
###################################################################################################################

class Game_Character < Game_CharacterBase

def check_cannibalDrop(tmpRace)
	return if $game_player.actor.stat["Cannibal"] != 1
	if ["Human","Moot"].include?(tmpRace)
		$game_map.reserve_summon_event("ItemHumanoidBrain",self.x,self.y)
		2.times{$game_map.reserve_summon_event("ItemHumanFlesh",self.x,self.y)}
	elsif ["Deepone","Fishkind","Orkind"].include?(tmpRace)
		1.times{$game_map.reserve_summon_event("ItemHumanoidFlesh",self.x,self.y)}
	end
end

	def is_stolen?
		charStealHashName = "#{$game_map.map_id}_#{self.id}".to_sym
		return false if !$story_stats["CharacterSteal"][charStealHashName]
		return true
	end
	
	
	def player_StealThisEvent()
		$game_player.target = nil
		return $game_map.interpreter.call_snd_popup("QuickMsg:Lona/Friendly") if self.npc.friendly?($game_player) #return pop friendly
		return $game_map.interpreter.call_snd_popup("QuickMsg:Lona/CannotWorks1") if !["Human","Moot","Deepone"].include?(self.npc.race) || self.npc.is_object#wrong target
		$game_player.actor.stat["moot"] == 1 ? tmpMootPlus = 10 : tmpMootPlus = 0
		tmpPlayerStealLVL = tmpMootPlus+$game_player.actor.scoutcraft_trait
		tmpNpcScoutcraft = self.npc.get_data_scoutcraft
		tmpNpcAntiStealLVL = (rand(tmpNpcScoutcraft)+self.actor.sensors[0].get_signal(self,$game_player)[2]).round
		tmpNpcAntiStealLVL = 0 if self.actor.action_state == :stun
		tmpStolen_ExpDate=rand(4)+1
		charStealHashName = "#{$game_map.map_id}_#{self.id}".to_sym
		tmpStolen = is_stolen?
		!@steal_diff ? @steal_diff = tmpNpcAntiStealLVL : @steal_diff += (tmpNpcScoutcraft*(self.npc.get_data_scoutcraft*0.1)).round

		return $game_map.interpreter.call_snd_popup("QuickMsg:Lona/Did") if tmpStolen # did on this character
		
		# check npc surround
		$game_map.npcs.each do |event|
			next if event.npc.is_object
			next if event.actor.is_a?(Game_DestroyableObject)
			next if event.actor.is_a?(GameTrap)
			next if event == self
			next if event.npc.friendly?($game_player)
			next if ![nil,:none].include?(event.actor.action_state)
			next if event.actor.action_state == :stun
			next if event.follower[0] ==1
			next if !["Human","Moot","Fishkind",].include?(event.npc.race)
			tmpHisSCU = event.actor.sensors[0].get_signal(event,$game_player)[2].round * (self.npc.get_data_scoutcraft*0.1).round
			@steal_diff += tmpHisSCU
		end
		#msgbox @steal_diff
		#msgbox tmpPlayerStealLVL
		tmpVsSteal_diff = rand(@steal_diff).round
		tmpSuccess = tmpPlayerStealLVL >= tmpVsSteal_diff
		if !tmpSuccess #|| rand(100) >= 90  #10 basic failed chance  
			tmpText = " #{tmpPlayerStealLVL} VS #{tmpVsSteal_diff}" #$game_text["QuickMsg:Lona/Failed"]
			SndLib.sys_buzzer
			$game_map.popup(0,tmpText,0,-1)
			return self.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],660)
		else
			$story_stats["CharacterSteal"][charStealHashName] = tmpStolen_ExpDate #steal succes  write stolen
			return $game_map.interpreter.call_snd_popup("QuickMsg:Lona/Empty2") if self.npc.drop_list.empty? #got nothing to steal
			tmpPickItem = self.npc.drop_list.sample
			# check any item can drop
			tmpItemMatch = $data_items.select{|item| 
				next if item.nil?
				next if !item.item_name.eql?(tmpPickItem)
				next if item.common_tags["cannot_steal"]
				!item.nil? && item.item_name.eql?(tmpPickItem)
			}
			return $game_map.interpreter.call_snd_popup("QuickMsg:Lona/Empty1") if tmpItemMatch.empty? #got nothing to steal
			tmpText = " #{tmpPlayerStealLVL} VS #{tmpVsSteal_diff}" #$game_text["QuickMsg:Lona/Success"]
			SndLib.sound_QuickDialog
			$game_map.popup(0,tmpText,0,1)
			$game_map.reserve_summon_event(tmpItemMatch[0].item_name,self.x,self.y)
		end
	end #def player_StealThisEvent
	
	
	def player_SetupTrap
		return if !self.summon_data || self.summon_data[:user] != $game_player
		$game_player.actor.stat["moot"] == 1 ? tmpMootPlus = 10 : tmpMootPlus = 0
		tmpPlayerStealLVL = tmpMootPlus + $game_player.actor.scoutcraft_trait
		@npc.user_redirect=true
		tmpGetChar = []
		tmpTrapDiff = 0
		$game_map.npcs.each do |event|
			next if event.npc.is_object
			next if event.actor.is_a?(Game_DestroyableObject)
			next if event.actor.is_a?(GameTrap)
			next if event.npc.master == $game_player
			next if event.npc.friendly?($game_player)
			next if event == self
			next if ![nil,:none].include?(event.actor.action_state)
			next if event.actor.action_state == :stun
			next if event.actor.action_state == :sex
			next if event.follower[0] ==1
			next unless self.x.between?(event.x-1,event.x+1) && self.y.between?(event.y-1,event.y+1)
			#next if !event.near_the_target?(self,3)
			tmpHisSCU = event.actor.sensors[0].get_signal(event,self)[2].round
			tmpTrapDiff += tmpHisSCU
			tmpGetChar << [tmpHisSCU,event.id]
		end
		return if tmpGetChar.empty?
		highest = tmpGetChar.max
		highest * tmpGetChar.count(highest)
		finalChar = $game_map.events[highest[1]]
		
		$game_player.actor.stat["moot"] == 1 ? tmpMootPlus = 30 : tmpMootPlus = 15
		tmpPlayerStealLVL = tmpMootPlus + $game_player.scoutcraft/2
		tmpNpcScoutcraft = finalChar.npc.get_data_scoutcraft
		tmpNpcAntiStealLVL = (rand(tmpNpcScoutcraft)+finalChar.actor.sensors[0].get_signal(finalChar,self)[2]).round
		tmpNpcAntiStealLVL = 0 if finalChar.actor.action_state == :stun
		tmpTrapDiff += (tmpNpcScoutcraft*(finalChar.npc.get_data_scoutcraft*0.1)).round
		#msgbox "#{tmpPlayerStealLVL}  VS #{tmpTrapDiff}"
		tmpSuccess = tmpPlayerStealLVL >= tmpTrapDiff
		finalChar.actor.set_aggro($game_player.actor,$data_arpgskills["BasicNormal"],300) if !tmpSuccess && finalChar
	end
	
end#class
