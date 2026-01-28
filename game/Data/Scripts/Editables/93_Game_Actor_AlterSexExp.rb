
class Game_Actor < Game_Battler
	
	def alter_sex_exp(occupied_holes)
		self.stat["EventVagRace"] = nil
		self.stat["EventAnalRace"] = nil
		self.stat["EventMouthRace"] = nil
		for i in 0...occupied_holes.length
			case occupied_holes[i][0]
				when "vag";
					$story_stats["sex_record_vaginal_count"] +=1
					$story_stats.sex_record_vag(["DataNpcName:race/#{occupied_holes[i][1]}" , "DataNpcName:name/#{occupied_holes[i][2]}" , "DataNpcName:part/penis"])
					self.stat["EventVagRace"] =occupied_holes[i][1]
					self.stat["EventVag"] = "CumInside1" #if $game_map.interpreter.IsChcg?
				when "anal";
					$story_stats["sex_record_anal_count"] +=1
					$story_stats.sex_record_anal(["DataNpcName:race/#{occupied_holes[i][1]}" , "DataNpcName:name/#{occupied_holes[i][2]}" , "DataNpcName:part/penis"])
					self.stat["EventAnalRace"] =occupied_holes[i][1]
					self.stat["EventAnal"] = "CumInside1" #if $game_map.interpreter.IsChcg?
				when "mouth";
					$story_stats["sex_record_mouth_count"] +=1
					$story_stats.sex_record_mouth(["DataNpcName:race/#{occupied_holes[i][1]}" , "DataNpcName:name/#{occupied_holes[i][2]}" , "DataNpcName:part/penis"])
					self.stat["EventMouthRace"] = occupied_holes[i][1]
					self.stat["EventMouth"] = "CumInside1" if $game_map.interpreter.IsChcg?
			end
		end
		
		
		#play playlist bvegin
		
	end


end
