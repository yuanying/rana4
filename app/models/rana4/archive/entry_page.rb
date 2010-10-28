require 'rana4/archive'

class Rana4::Archive::EntryPage
  attr_reader   :entry, :site
  attr_accessor :next_page, :previous_page
  
  def initialize entry
    @entry  = entry
    @site   = entry.site
  end
end
