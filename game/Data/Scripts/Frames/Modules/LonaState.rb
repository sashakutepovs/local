#==============================================================================
# This script is created by Kslander 
#==============================================================================
=begin
  這個腳本主要提供用途stat需要的物件。基本上所有被安裝LonaStat的內建類別都會被擺在這邊


=end

module LonaStatAdapter
   attr_reader :lonaStat
  def createLonaState(statHash)
    @lonaStat=LonaStat.from_stat_hash(statHash)
  end 
  
  class LonaStat  
	  attr_accessor :statName  #對應到的屬性值名稱
	  attr_accessor :statLink  #次要影響
	  attr_accessor :affectValue #影響屬性值的數值，因為改用堆疊數計算，裝備之類的可能會用到。
	  attr_accessor :initialValue #這個屬性的初值
	  attr_accessor :current #這個屬性當下的值，只會在Game_Actor中用到
	  #attr_accessor :maxStack #這個屬性的最大堆疊層次，暫時沒有用到。
		attr_accessor :type #這個屬性的類型
	  
	  
	  TYPE_NUMERIC="numeric"
	  TYPE_STRING="string"
	  

		def self.from_stat_hash(dataHash)
			stat=self.new
			stat.statName=dataHash["stat"]
			stat.statLink=dataHash["link"]
			stat.affectValue=dataHash["value"]
			stat.initialValue=dataHash["initial"]
			#stat.maxStack=dataHash["max_stack"]
			stat.type=dataHash["type"]
			stat
		end
	  
	  def isStringType?
		 @type.eql?(TYPE_STRING)
	  end

	end

  
end



