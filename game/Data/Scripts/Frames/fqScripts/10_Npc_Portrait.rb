#==============================================================================
# This script is created by Kslander 
#==============================================================================

class NPC_layer_Portrait < Lona_Portrait
	def updateExtra()
	end
end
class NPC_Portrait < Moveable_Portrait
	attr_accessor		:prts
	attr_accessor		:base_char

  def initialize(base_char,parts,flipped=false,canvas=[300,400,0,0])
    super(base_char,parts,flipped,canvas)
  end
  
  def update
    super
  end
  
  def update_parts
    @prts.each{|prt| 
      prt.update(@base_char)}
    #p "npc part updated #{@charName}"
  end
  
  def focused?
	return true if $game_map.interpreter.IsChcg?
	super
  end
  
  def faded?
  	return true if $game_map.interpreter.IsChcg?
	super
  end
  
  def hidden?
  	return true if $game_map.interpreter.IsChcg?
	super
  end
  

	def self.fromHash(hash)
		base_char=Simple_Char.new(hash["statMap"],hash["char_name"])
		parts=Array.new
		hash["parts"].each{|part|
			part["x"].nil?  ?  x=0 : x=part["x"]
			part["y"].nil?  ?  y=0: y=part["y"] 
			defaultStat=base_char.statMap["NPCportrait"]
			npcpart=Portrait_Part.new(part["bmps"],x,y,part["layer"],part["part_name"],defaultStat)
			if part["root_folder"]
				npcpart.root_folder=part["root_folder"]
			else
				npcpart.root_folder="Graphics/Portrait/npc"
			end
			parts.push(npcpart)
		}
		npcprt=NPC_Portrait.new(base_char,parts,false,base_char.statMap["canvas"]["default"])
		npcprt.update
		return npcprt
	end
  
 
  
end
