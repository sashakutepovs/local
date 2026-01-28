
#Because CG scripts call actor.stat[<name>]=<something> I have to intercept them.
class Portrait_Stat_Proxy
	attr_accessor :actor
	def initialize(actor)
		@actor = actor
	end
	def [](key)
		return @actor.portrait_stat_value[key]
	end
	def []=(key, value)
		@actor.report_portrait_stat(key,value)
	end
	def each
		@actor.portrait_stat_value.each{|k,v|
						oldVal = v
						yield(k,v)
						@actor.report_portrait_stat(k,v) if oldVal != v
					}
	end
end