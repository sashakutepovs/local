#module GCControl
#	@last_gc_time = Time.now
#	@interval = 15         # Seconds between GC runs (tweak as needed)
#	@min_allocations = 100000  # Allocation threshold to force GC
#
#	def self.setup
#		@last_gc_time = Time.now
#		@last_gc_count = GC.stat[:count] rescue 0
#		@last_alloc = ObjectSpace.each_object.count rescue nil
#	end
#
#	def self.update
#		return unless SceneManager.scene.is_a?(Scene_Map) # only on map
#
#		time_elapsed = Time.now - @last_gc_time
#		current_alloc = ObjectSpace.each_object.count rescue nil
#
#		need_gc = time_elapsed > @interval
#		need_gc ||= current_alloc && @last_alloc && (current_alloc - @last_alloc > @min_allocations)
#
#		if need_gc
#			GC.start
#			@last_gc_time = Time.now
#			@last_alloc = current_alloc
#		end
#	end
#end
#GCControl.setup
