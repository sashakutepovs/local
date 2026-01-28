#==============================================================================
# This script is created by Kslander 
#==============================================================================

=begin
  這個模組主要用來從NOTE中讀取寫入的資料，格式一般是固定的。
=end

module Note
  
  
  #從指定的格式去取得資料 
  #格式 KEY=VALUE (CRLF)
  def self.get_data(source)
    str=source.split("\r\n")
    data=Hash.new
    str.each{
    |unit|
      split=unit.split("=")
      data[split[0]]=split[1]
    }
    data
  end
  
  def self.clearGTcomments(commentedString)
    str=commentedString.gsub(/\s/,"")
    return str.gsub(/<.*>/,"")
  end
  
  
end