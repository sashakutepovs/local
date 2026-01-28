#==============================================================================
# This script is created by Kslander 
#==============================================================================
#這個檔案室Lona遊戲裡面使用的Sensor的雛型

module Sensors
	
	
	class Basic_Sensor
		
		def self.type;				"basic";	end
		def self.sight_hp;			4;			end
		def self.ignore_dead?;		true;		end
		def self.ignore_object?;	true;		end
		def self.water_only?	;	false;		end
		def self.ignore_user?	;	false;		end
		def self.use_iff?;			true;		end
		def self.friendly_only?;	false;		end
		def self.detection_array
			[
				[0.1,0.1,0.1,0.1,0.1],#↓ ,dir=2 ，預設面對下方 
				[0.1,0.5,999,0.5,0.1],#999 = 自身
				[0.2,0.8,100,0.8,0.2],
				[0.3,0.6,0.8,0.6,0.3],
				[0.2,0.4,0.7,0.4,0.2],
				[0.1,0.3,0.6,0.3,0.1],
				[0.1,0.2,0.5,0.2,0.1],
				[0.1,0.1,0.4,0.1,0.1],
				[0.1,0.1,0.2,0.1,0.1],
				[0.1,0.1,0.1,0.1,0.1]
			]
		end
		
		
		def self.center
			return @center if @center
			d_array=detection_array
			for i in 0...d_array.length
				if d_array[i].include?(999)
					y_index=i
					x_index=d_array[i].index(999)
					#[y,x]，考量到實際上的數值使用順序
					@center = [y_index,x_index]
					break
				end
			end
			@center
		end
		
		def self.area_dimension
			return @area_dimension if @area_dimension
			#[height,width]，考量到實際上的數值使用順序
			@area_dimension=[detection_array.length , detection_array[0].length]
			@area_dimension
		end
		
		#針對大量目標取得偵測數據，回傳數值最大的偵測結果。
		#檢測目標是否被發現，若被發現，回傳帶有各種所需資訊的陣列，若無，回傳nil
		#陣列規格： [目標,距離,訊號強度,感測器類型]
		def self.sense(character,targets=$game_map.all_characters)
			signal=nil
			targets.each{
				|tgt|
				next if tgt.erased || tgt.deleted?
				new_signal = get_signal(character,tgt)
				signal = new_signal if signal.nil? ||  signal[2] < new_signal[2]
			}
			signal
		end
		
		#因應戰鬥系統新增的項目。回傳所有偵測結果不為0的物件
		def self.scan(character,targets=$game_map.all_characters)
			signals=Array.new
			targets.each{
				|tgt|
				next if tgt.erased || tgt.deleted?
				new_signal = get_signal(character,tgt)
				signals.push(new_signal) if new_signal!=0
			}
			signals
		end
		
		def self.any_friendly_inrange?(character,targets=$game_map.all_characters)
			targets.each{
				|tgt|
				next if tgt.erased || tgt.deleted?
				new_signal=get_signal(character,tgt)
				return true if new_signal!=0 && character.actor.friendly_signal?(new_signal)
			}
			return false
		end
		
		#針對單一目標取得偵測數據
		#檢測目標是否被發現，若被發現，回傳帶有各種所需資訊的陣列，若無，回傳nil
		#陣列規格： [目標,距離,訊號強度,感測器類型]
		def self.signal_IgnoreCheck(character,target,track_mode=false)
			return true if !target.is_actor?
			return true if same_char?(target,character)
			return true if ignore_dead? && target.npc.action_state == :death #less
			return true if ignore_obj_chk(character,target)
			return true if use_iff? && character.actor.friendly?(target)
			return true if friendly_only? && !character.actor.friendly?(target)
		end
		
		def self.ignore_obj_chk(character,target)
			return true if ignore_object? && target.npc.is_object && !target.npc.hit_LinkToMaster
		end
		
		def self.get_signal(character,target,track_mode=false)
			return 0 if signal_IgnoreCheck(character,target,track_mode=false)
			
			return 0 if (mine_value=mine_number(character,target,track_mode)).nil? || mine_value==0
			return 0 if (visual_info=calc_sight_hp_and_dist(character,target))[0] < 0
			return [target,visual_info[1],calc_signal_strength(character,target ,visual_info[0], mine_value), type]
		end
		
		
		def self.same_char?(character,target)
			target==character
		end
		
		
		#檢查是否處在detection_array的範圍中
		def self.mine_number(character,target,track_mode)
			dheight,dwidth=area_dimension
			mineY,mineX = get_mine_xy(character,target,track_mode)
			return nil if mineY >=dheight || mineY <0
			return nil if mineX >=dwidth || mineX <0
			return detection_array[mineY][mineX]
		end
		
		#HitBox維修請看這 注意 此也將影響NPC SENSOR
		def self.get_mine_xy(character,target,track_mode)
			tgtx,tgty=target.real_x-0.1,target.real_y-0.1
			chx,chy=character.real_x-0.1,character.real_y-0.1
			#tgtx,tgty=target.real_x.round,target.real_y.round #old
			#chx,chy=character.real_x.round,character.real_y.round #old
			centY,centX = center
			#return [character.x,character.y] if !centY || !centX ## a blocker if bugged
			direction = track_mode ? 2 : character.direction
			case direction
				when 2; 
					mx = tgtx - chx  + centX
					my = tgty - chy  + centY
				when 4;
					mx = tgty - chy  + centX
					my = chx -  tgtx + centY
				when 6;
					mx = chy -  tgty + centX
					my = tgtx - chx  + centY
				else;
					mx = tgtx - chx  + centX
					my = chy  - tgty + centY
			end	
			return [my.round,mx.round]
			#return [my,mx] #old
		end
		
	    def self.calc_sight_hp_and_dist(character,target)
			shp=sight_hp
			line=get_line(character.x,character.y,target.x,target.y)
			last=line.last
			#line=line.slice(0,line.length-1) if line.last[:x]!=target.x || line.last[:y]!=target.y
				for point in 0...line.length
					terrain_tag=$game_map.terrain_tag(line[point][:x],line[point][:y])
					terrain_tag== 4 ? shp= -1 : shp-= terrain_tag
					break if shp<0
				end
				tgt_dist=line.length== 0 ? 0 : line.length-1
			[shp,tgt_dist] #回傳sight_hp及距離
	    end
		
		
		def self.calc_signal_strength(character,target,sight_hp,mine_value)
			sight_hp * character.scoutcraft * mine_value 
		end

  
		def self.get_line(x0,y0,x1,y1)
		  points = []
		  steep = ((y1-y0).abs) > ((x1-x0).abs)
		  if steep
			x0,y0 = y0,x0
			x1,y1 = y1,x1
		  end
		  if x0 > x1
			x0,x1 = x1,x0
			y0,y1 = y1,y0
		  end
		  deltax = x1-x0
		  deltay = (y1-y0).abs
		  error = (deltax / 2).to_i
		  y = y0
		  ystep = nil
		  if y0 < y1
			ystep = 1
		  else
			ystep = -1
		  end

  		  x0=x0.to_i
		  x1=x1.to_i
		  for x in x0..x1
			if steep
			  points << {:x => y, :y => x}
			else
			  points << {:x => x, :y => y}
			end
			error -= deltay
			if error < 0
			  y += ystep
			  error += deltax
			end
		  end
		  return points
		end

  
	end
				
end
	


