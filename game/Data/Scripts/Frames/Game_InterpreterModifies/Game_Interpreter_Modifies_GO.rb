#==============================================================================
# This script is created by Kslander 
#==============================================================================
module GIM_GO



		######################################## make store 
		#data 0item 1:weapon 2:armor
		#id
		#original price? 0,0   custom price? nil,price
		#good=[
		#	[0,50,nil,5000]
		#	]
	#def manual_shop(goods,purchase_only=false)
	#	SceneManager.goto(Scene_Shop)
	#	SceneManager.scene.prepare(goods, purchase_only)
	#	Fiber.yield
	#end


  #自動抓週圍角色進入sex
  def set_fuck(receiver)
	chars_nearby=Sensors::RangeTurretVision.scan(receiver)
	fuckers=Array.new
	fappers=Array.new
	for char in 0...3
		fuckers << chars_nearby[char][0]
	end
	
	for fap_char in 4...7
		fuckers << chars_nearby[fap_char][0]
	end
	go_fuck(receiver,fuckers,fappers)
  end
  
  
  def go_fuck_player(fuckers,fappers=Array.new)
	go_fuck($game_player,fuckers,fappers)
  end
  
  
  #receiver => Any Game_Character
  #fuckers => [Game_Character(Game_Event | Game_Player) ,  Game_Character]
  def go_fuck(receiver,fuckers,fappers=Array.new)
	  for fuk in 0...fuckers.length
		receiver.add_sex_gang(fuckers[fuk])
	  end
	  
	  for fap in 0...fappers.length
		receiver.add_fapper(fappers[fap])
	  end
	  receiver.fuckers.each{
		|fker|
		fker.actor.set_action_state(:sex,true)
		fker.actor.fucker_target=receiver
		fker.setup_npc_sex
		}
	  receiver.actor.set_action_state(:sex,true)
	  receiver.set_chs_sex_group
  end
	
  

end
