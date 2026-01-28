#shield unique AI
class Npc_Shield_Launcher < Game_DestroyableObject
	def skill_result_check_ignore_tgt(character,skill)
		return true if super
		return true if @event.summon_data[:target] && character != @event.summon_data[:target] #NPC will with target.  this will only allly to tgt
	end
	#def skill_result_check_break(character,skill)
	#	false
	#end

end