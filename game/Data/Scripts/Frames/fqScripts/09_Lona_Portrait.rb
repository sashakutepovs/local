#==============================================================================
# This script is created by Kslander
#==============================================================================

class Lona_Portrait < Moveable_Portrait
	attr_accessor :detached #是否跟遊戲狀態切斷連結，預設否
	attr_accessor :refStat  #斷線時使用的stat
	attr_accessor :base_char #用來取得portrait組裝資訊的Actor
	attr_accessor :part_key_blacklist #用來取得portrait組裝資訊的Actor

	def initialize(base_char,parts,defPose,name_order,canvas=[300,400,0,0])
		@allParts=parts
		@detached=false
		@pose=defPose   #腳色當下的pose
		@name_order=name_order
		super(base_char,@allParts[@pose],true,canvas)
		@part_key_blacklist = [] #= base_char.part_key_blacklist
		sort_all_parts #將暫時不會用到的其他part也排序
		setup_parts_hashes
	end

	def refresh
		#@part_key_blacklist = base_char.part_key_blacklist
		base_char.stat.each{|k,v|
					set_stat(k,v)
				}
	end

	def sort_all_parts
		@allParts.each{|key,value|
			next if key.eql?(@pose)
			@allParts[key]=sort_parts(value)
		}
	end


	def setup_parts_hashes
		if @stat_to_prts.nil? then#hash for fast search of which parts might be added or removed on that set_stat call
			@stat_to_prts = {}
		else
			@stat_to_prts.clear
		end
		@allprts = @prts
		@dirtPart = nil
		@prts = []#parts currently in portrait. Array for iteration.
		@parts_changed = false #do we need to reassemble portrait?
		@allprts.each{|prt|
					if prt.isDirt && prt.dirtKey != ""
						if @stat_to_prts[prt.dirtKey].nil? then
							@stat_to_prts[prt.dirtKey] = [prt]
						else
							@stat_to_prts[prt.dirtKey] << prt
						end
					end
					prt.set_name_order(@name_order)
					prt.nameOrder.each{|statName|
						if @stat_to_prts[statName].nil? then
							@stat_to_prts[statName] = [prt]
						else
							@stat_to_prts[statName] << prt
						end
						prt.set_value(statName, base_char.stat[statName])
						if !prt.bitmap.nil?
							@prts << prt
							@parts_changed=true
						end
					}
			}
	end

	def set_stat(statName, value)
		if value.nil? then
			value = 0
		end
		if statName == 'dirt'.freeze && @dirt_level != value then
			@dirt_level = value
			@parts_changed=true
		end
		arr = @stat_to_prts[statName]
		if !arr.nil?
			arr.each{|prt|
				prtOldBitmap = prt.bitmap
				prt.set_value(statName,value)
				prtNewBitmap = prt.bitmap
				if prtNewBitmap.nil? && @prts.include?(prt)
					@prts.delete(prt)
					@parts_changed = true
				elsif !prtNewBitmap.nil? && !@prts.include?(prt)
					sorted_insert(@prts, prt)
					@parts_changed = true
				elsif !prtNewBitmap.nil?
					if prtNewBitmap != prtOldBitmap
						@parts_changed=true
					end
				end
			}
		end
	end


	def test
		p "Current parts: "
		@prts.each{|prt| p "#{prt.part_name}" }
		p "All parts: "
		@allprts.each{|prt| p "#{prt.part_name} #{prt.nameOrder} #{prt.prtArrKey} #{prt.bitmaps}"}
	end

	def sorted_insert(arr, elem)
		for i in 0...arr.length
			if arr[i].layer >= elem.layer
				arr.insert(i, elem)
				return
			end
		end
		arr << elem
	end

	#取得當下的pose
	def pose
		@base_char.stat["pose"]
	end

	def update
		updatePose #先檢查pose在處理剩下的事情
		updateExtra
		super
	end

	def update_parts
		#@prts.each{|prt| prt.update(@base_char,@name_order)}
	end

	def delete_sprite
	end

	def updateExtra
		#實際內容在Editable/102_Lona_Portrait_Rule.rb
	end


  def updateCanvas
    @canvas=@base_char.statMap["canvas"][pose]
  end

	def updatePose
		return if pose.eql?(@pose)
		@pose=pose
		updateCanvas #重設畫布大小
		@prts=@allParts[@pose]
		setup_parts_hashes
		set_stat('dirt', @dirt_level)
	end

	def assemble_portrait
		return if !@parts_changed
			#super
			prt=Bitmap.new(@canvas[0],@canvas[1])
			prt.fill_rect(0,0,prt.width,prt.height,Color.new(0,255,0,0))
			@prts.each{|part|
				next if part.bitmap.nil?
				begin
					if @part_key_blacklist.include?(part.part_name)
						opa = 0
					else
						opa = part.opacity
					end
					opa = 255 if opa.nil?
					prt.blt(part.posX,part.posY,part.bitmap,part.bitmap.rect,opa)
				rescue =>err
					p "Portrait missing file err.message=>#{err.message}"
				end
			}
			@portrait.bitmap=prt
		@parts_changed = false
	end


	def updateParts
		if (@detached and @alternate)
			@prts.each{|prt|
				prt.update(@alternate)
				#prt.opacity = 0 if @part_key_blacklist.include?(prt.part_name)
			}
		else
			@prts.each{|prt|
				prt.update(@base_char)
				#prt.opacity = 0 if @part_key_blacklist.include?(prt.part_name)
			}
		end
	end

  def detach(alternate)
    @alternate=Simple_Char.new(alternate)
    @detach=true
  end

  def reattch
    @detach=false
  end

  #重設畫布大小
  def update_canvas
    @canvas=@base_char.statMap["canvas"][@pose]
  end

    def dispose
		p "disposing lona portrait"
		@allParts.each{
			|key,parts|
			parts.each{
				|part|
				next if part.bitmap.nil?
				part.bitmap.dispose
			}
		}
  end

  def shake
	SceneManager.scene.hud.perform_damage_effect
	super
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

  def base_x
	return -@canvas[2] if @flipped
	return Graphics.width-@canvas[0].to_i+@canvas[2].to_i
  end
end

#def porttst
#	$game_player.actor.portrait.test
#end
