#==============================================================================
# This script is created by Kslander 
#==============================================================================
=begin
這個類別是測試用的臨時類別，主要用來測試portrait系統的運作
2019-07 : 這個類別現在被用來作為NPC_Portrait的設定資料載體。
=end
class Simple_Char
  attr_accessor :statMap  #所有跟繪圖相關的數值
  attr_accessor :charName
  
  def initialize(statMap,charName)
    @statMap=statMap
    @charName=charName
  end
  
  
end
