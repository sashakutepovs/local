=begin
  這個模組用來處理隨機表情及預鑄表情級的載入等。
  包含$mood的產生以及 Mood 類別

=end

  
  module Moods
      attr_reader :moods
	  #$debug_moods=false
    def get_mood(moodName)
      update_persona
	  @actStat.check_stat
      return nil if $data_LonaMood[moodName].nil?
      $data_LonaMood[moodName].each{
       |md|
       return md if md.isWithinRange(@actStat)
      }
      return nil
    end
	

    #設定立繪的表情
    def set_mood(moodName,stat)
      get_mood(moodName).affectStat(stat)
    end
 
	def prtmood(moodName,update_first=true)
		curMood=get_mood(moodName) if moodName
		return p "mood not found for #{moodName}" if curMood.nil? && moodName
		update_lonaStat if update_first
		curMood.affectStat(self) if moodName
		@stat_changed=true
		portrait.reset_rotation
		portrait.update
	end

  
  def remove_json_comments_mood(jsonString)
    return jsonString.gsub(/<.*>/,"")
  end
    
    class Mood
    
		def initialize(jsonData)
			@mood_min=jsonData["mood_min"]
			@mood_max=jsonData["mood_max"]
			@mood_name=jsonData["mood_name"]
			@persona=jsonData["persona"]
			@sta_max=jsonData["sta_max"]
			@sta_min=jsonData["sta_min"]
			@facesets=jsonData["facesets"]
		end

      #檢查當下的sta是否在這個表情的sta範圍內
	def isWithinRange(stat)
		begin
			wMoodRange=isWithinMoodRange(stat)
			wStaRange=isWithinStaRange(stat)
			onPersona=isOnPersona(stat.get_stat("persona"))
			p "mood_name #{@mood_name} isWithinMoodRange #{wMoodRange} isWithinStaRange #{wStaRange} isOnPersona #{onPersona}"  if $debug_portrait
			return wMoodRange && wStaRange && onPersona
		rescue => error
			p "isWithinRange error: #{error}"
			return false
		end
	end
	def isWithinStaRange(stat)
		staVal= stat.get_stat("sta")
		staValMin = stat.get_stat_default["sta"][0][4]
		staVal= [staVal, staValMin].max.to_i # to protect sta out range
		return true if @sta_max.nil? || @sta_min.nil?
		return staVal< @sta_max.to_i && staVal>=@sta_min.to_i
	end
	def isWithinMoodRange(stat)
		moodVal = stat.get_stat("mood")
		moodValMax = stat.get_stat_default["mood"][0][3]
		moodValMin = stat.get_stat_default["mood"][0][4]
		moodVal= [[moodVal, moodValMin].max, moodValMax].min.to_i # to protect mood out range
		return true if @mood_max.nil? || @mood_min.nil?
		(moodVal<@mood_max.to_i || moodVal==@mood_max.to_i)and moodVal>=@mood_min.to_i
	end
      
		def isOnPersona(pers)
			return true if @persona.nil?
			return @persona.eql?(pers)
		end


      #讓這個Mood影響stat
		def affectStat(actor)
			randomValue=rand(@facesets.length)
			randomSet=@facesets[randomValue]
			randomKeys=randomSet.keys
			randomKeys.each{
				|rKey|
				rKeyVal=rand(randomSet[rKey].length)
				if(randomValue==1)
					actor.report_portrait_stat(rKey, randomSet[rKey][0])
				else
					actor.report_portrait_stat(rKey, randomSet[rKey][rKeyVal])
				end
			}
		end
    
  end
  
	class CHCGMood < Mood
		def initialize(jsonData)
			if (jsonData["sta"].eql?("plus"))
				@mood_min=100
				@mood_max=200
			end
			if(jsonData["sta"].eql?("minus"))
				@mood_min=0
				@mood_max=100
			end
			@mood_name=jsonData["mood_name"]
			@facesets=jsonData["facesets"]
		end
	end
    #檢查當下的sta是否在這個表情的sta範圍內
    def isWithinRange(cur)
       cur<mood_max and cur>=mood_min
    end
    
    
    #讓這個Mood影響stat
		def affectStat(actor)
			statNames=@facesets.keys
			for x in 0...statNames.length
				statName=statNames[x]
				randomRange=@facesets[statName].length-1
				actor.report_portrait_stat(statName, @facesets[statName][rand(0,randomRange)])
			end
		end
    
  end
    
    
  
