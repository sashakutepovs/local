
class Game_Map
	#search mode 0  return
	def set_around_NPCs_hate_unit_fraction(tmpUser=self,tmpTarget=$game_player,sightPower=15,searchRange=3+$story_stats["Setup_Hardcore"]*5,searchMode=$story_stats["Setup_Hardcore"])
		return if searchMode == 0
		@npcs.each do |event|
			next if event.actor.is_object
			next if event.actor.is_a?(Game_PorjectileCharacter)
			next if event.actor.is_a?(Game_DestroyableObject)
			next if event.actor.is_a?(GameTrap)
			next if event.actor.friendly?(tmpTarget)
			next if event.actor.master == tmpTarget
			next if event.actor.fraction != tmpUser.actor.fraction
			next if event.actor.fraction == tmpTarget.actor.fraction && event.actor.fraction != tmpUser.actor.fraction
			next if event.actor.action_state == :death
			next if event == tmpTarget.actor.fucker_target
			tmpSignal = event.actor.sensors[0].get_signal(event,tmpTarget)[2]
			#p "asdasdasds12 #{ event.actor.target == tmpTarget}  #{tmpSignal >= sightPower}   #{event.near_the_target?(tmpTarget,searchRange)}" if event.summon_data && event.summon_data[:asdasdasdasd]
			next unless tmpSignal > 0
			next unless event.actor.target == tmpTarget || tmpSignal >= sightPower || event.near_the_target?(tmpTarget,searchRange)
			
			#tmpTarget.actor.add_state(180) #weak_0_30
			case searchMode
				when 0
					event.search_target_unit(user=tmpTarget,target=event,balloon=2)
				when 1
					if event.actor.target == tmpTarget
						event.actor.set_aggro(tmpTarget.actor,$data_arpgskills["BasicNormal"],300)
					else
						event.search_target_unit(user=tmpTarget,target=event,balloon=2)
					end
				else #when 2 #set fatted enemy will bugged
					event.actor.add_fated_enemy([tmpTarget.actor.fraction])
					if event.actor.target == tmpTarget
						event.call_balloon(1)
					else
						event.search_target_unit(user=tmpTarget,target=event,balloon=2)
					end
			end #case
		end# each do
	end #def
end