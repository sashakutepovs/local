class Game_Actor

   def init_code_in_editable
    #init_talkstyle
    #init_persona
  end
  
  
  
def talkStyle
	{
	#[nymphomaniac,chaste,easy,low_mood,low_sta,mouth_block]
	[0,0,0,0,0,0]=>"_normal",
	[1,1,0,0,0,0]=>"_normal",
	[1,0,0,0,0,0]=>"_slut",
	[1,0,1,0,0,0]=>"_slut",
	[0,1,0,0,0,0]=>"_tsun",
	[0,1,1,0,0,0]=>"_tsun",
	[1,1,1,0,0,0]=>"_slut",
	
	[0,0,1,0,0,0]=>"_weak",
	[0,0,1,1,0,0]=>"_weak",
	[0,0,0,1,0,0]=>"_weak",
	[0,1,0,1,0,0]=>"_tsun",
	[1,0,0,1,0,0]=>"_slut",
	[1,1,0,1,0,0]=>"_slut",
	
	[0,0,0,0,1,0]=>"_overfatigue",
	[0,0,0,1,1,0]=>"_overfatigue",
	[0,0,1,0,1,0]=>"_overfatigue",
	[0,0,1,1,1,0]=>"_overfatigue",
	[0,1,0,0,1,0]=>"_overfatigue",
	[0,1,0,1,1,0]=>"_overfatigue",
	[0,1,1,0,1,0]=>"_overfatigue",
	[0,1,1,1,1,0]=>"_overfatigue",
	[1,0,0,0,1,0]=>"_overfatigue",
	[1,0,0,1,1,0]=>"_overfatigue",
	[1,0,1,0,1,0]=>"_overfatigue",
	[1,0,1,1,1,0]=>"_overfatigue",
	[1,1,0,0,1,0]=>"_overfatigue",
	[1,1,0,1,1,0]=>"_overfatigue",
	[1,1,1,0,1,0]=>"_overfatigue",
	[1,1,1,1,1,0]=>"_overfatigue",
	
	[0,0,0,0,0,1]=>"_mouth_block",
	[0,0,0,0,1,1]=>"_mouth_block",
	[0,0,0,1,0,1]=>"_mouth_block",
	[0,0,0,1,1,1]=>"_mouth_block",
	[0,0,1,0,0,1]=>"_mouth_block",
	[0,0,1,0,1,1]=>"_mouth_block",
	[0,0,1,1,0,1]=>"_mouth_block",
	[0,0,1,1,1,1]=>"_mouth_block",
	[0,1,0,0,0,1]=>"_mouth_block",
	[0,1,0,0,1,1]=>"_mouth_block",
	[0,1,0,1,0,1]=>"_mouth_block",
	[0,1,0,1,1,1]=>"_mouth_block",
	[0,1,1,0,0,1]=>"_mouth_block",
	[0,1,1,0,1,1]=>"_mouth_block",
	[0,1,1,1,0,1]=>"_mouth_block",
	[0,1,1,1,1,1]=>"_mouth_block",
	[1,0,0,0,0,1]=>"_mouth_block",
	[1,0,0,0,1,1]=>"_mouth_block",
	[1,0,0,1,0,1]=>"_mouth_block",
	[1,0,0,1,1,1]=>"_mouth_block",
	[1,0,1,0,0,1]=>"_mouth_block",
	[1,0,1,0,1,1]=>"_mouth_block",
	[1,0,1,1,0,1]=>"_mouth_block",
	[1,0,1,1,1,1]=>"_mouth_block",
	[1,1,0,0,0,1]=>"_mouth_block",
	[1,1,0,0,1,1]=>"_mouth_block",
	[1,1,0,1,0,1]=>"_mouth_block",
	[1,1,0,1,1,1]=>"_mouth_block",
	[1,1,1,0,0,1]=>"_mouth_block",
	[1,1,1,0,1,1]=>"_mouth_block",
	[1,1,1,1,0,1]=>"_mouth_block",
	[1,1,1,1,1,1]=>"_mouth_block"
	}
end 
 def lonaPersona
	{
	#[nymphomaniac,chaste,easy]
	[0,0,0]=>"typical",
	[0,0,1]=>"gloomy",
	[0,1,0]=>"tsundere",
	[0,1,1]=>"typical",
	[1,0,0]=>"slut",
	[1,0,1]=>"slut",
	[1,1,0]=>"slut",
	[1,1,1]=>"typical"
	}
	
 end

def talk_style #belong to common update
	arr=get_trait+[low_mood?,low_sta?,mouth_blocked?]
	arr=[self.stat["Nymph"],self.stat["IronWill"],self.stat["WeakSoul"],low_mood?,low_sta?,mouth_blocked?]
	return talkStyle[arr]
end
def talk_persona
	update_persona
	return "_#{self.stat["persona"]}"
end

def get_trait
	[self.stat["Nymph"],self.stat["IronWill"],self.stat["WeakSoul"]]
end

def low_mood?
#滿足low_mood的條件的話回傳1
	if self.mood <= -100
	then return 1
	else return 0
	end
end
 
def low_sta?
#滿足low_sta的條件的話回傳1
	if self.sta <= -75
	then return 1
	else return 0
	end
end

def mouth_block
 return @mouth_block
 end
 
def mouth_block=(val)
	if(val==1)
	p "set mouth_blocked"
	self.stat["mouth"]=0
	@mouth_block=1
	else
	@mouth_block=val
	end
end


def mouth_blocked?
#滿足mouth_block的條件的話回傳1，這邊因為下面已經有一個mouth_block?所以改用另一個名字
	if @mouth_block == 1 
		then return 1
		else return 0
	end
end

 def overfatigue?
   self.sta<=0 && mouth_block?
 end
 
  def mouth_block?
   self.stat["mouth"]==0
 end
 
def gloomy?
	#self.mood <=0  && self.sta >= 0
	self.stat["WeakSoul"] == 1

end


def get_persona
	update_persona
	return self.stat["persona"]
end

def update_persona
	#if gloomy?
	#	self.stat["persona"]="gloomy" 
	#	@actStat.set_stat("persona","gloomy")
	#	return 
	#else
		self.stat["persona"]=lonaPersona[get_trait]
		@actStat.set_stat("persona",lonaPersona[get_trait])
	#end
	
	#return 

end  

end
