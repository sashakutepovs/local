#===============================================================================
# Map Scroll Glitch Fix v1.0 by wltr3565 (RMVX ACE only)
# 
# In widescreen resolution (640x360) the bottom of the map shows up some upmost
# part of the map. This one fixes this.
# But it's only for 640x360 for now, so if there's need for fixing in many
# aspects, let me know. It's rare for an RM game to have a different resolution
# other from either 544x416 or 640x480.
#
# Just paste this above main, and as above as possible above other custom 
# scripts.
#===============================================================================
#Graphics.resize_screen(640,360)   #<< moved to f11 full screen++
class Game_Map
  def scroll_down(distance)
    if loop_vertical?
      @display_y += distance
      @display_y %= @map.height
      @parallax_y += distance if @parallax_loop_y
    else
      last_y = @display_y
      @display_y = [@display_y + distance, height - screen_tile_y, height - screen_tile_y - (Graphics.height % 32 * 1.0 / 32)].min
      @parallax_y += @display_y - last_y
    end
  end

  def set_display_pos(x, y)
    x = [0, [x, width - screen_tile_x].min].max unless loop_horizontal?
    y = [0, [y, height - screen_tile_y].min].max unless loop_vertical?
    @display_x = (x + width) % width
    @display_y = (y + height) % height
    @display_y = (y + height) % height -  (Graphics.height % 32 * 1.0 / 32) if @display_y >= @map.height - 12
    @parallax_x = x
    @parallax_y = y
  end
end
