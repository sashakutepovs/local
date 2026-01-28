
######## mostly use in console.
module EvLib

	def self.sum(name,tmpX=$game_player.x,tmpY=$game_player.y,tmpSd=nil)
		$game_map.reserve_summon_event(name,tmpX,tmpY,-1,tmpSd)
	end
	def self.camF(tar,spd=0)
		$game_map.interpreter.cam_follow(tar,spd)
	end
	
	def self.help
		prp "UpLang => update Text data"
		prp "sum => (x,y,summon_data)"
		prp "gain_item =>(item,)"
		prp "ToTitle =>to title screen"
		prp "GM =>$game_map"
		prp "GMI =>$game_map.interpreter"
		prp "GME =>$game_map.events"
		prp "GP =>$game_player"
		prp "GPA =>$game_player.actor"
	end
	def self.UpLang
		DataManager.update_Lang
	end
	def self.gain_item(name,val=1)
		$game_party.gain_item(name,val)
	end
	
	def self.ToTitle
		SceneManager.goto(Scene_Title)
	end
	def self.GMI
		$game_map.interpreter
	end
	def self.GM
		$game_map
	end
	def self.GME
		$game_map.events
	end
	def self.GP
		$game_player
	end
	def self.GPA
		$game_player.actor
	end
	def self.NewEventCMD(script)
		RPG::EventCommand.new(355,0,[script])
	end

	def self.p_txt(obj) #export a text file in root   p_txt $game_player.actor.stats
		File.open("_p_txt.txt", "w") do |file|
			file.print(obj.inspect)
		end
		prp "Log generated at _put_text.txt",2
	end
end
