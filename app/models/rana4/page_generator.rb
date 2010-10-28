require 'rana4'

class Rana4::PageGenerator
  attr_reader :site
  attr_reader :entry
  attr_reader :file_fetcher
  
  def initialize site, entry=nil
    @site         = site
    @entry        = entry
    @file_fetcher = FileFetcher.new(site)
  end
  
  def generate
    generate_file = self.file_fetcher.fetch_path('generator/generate.rb')
    eval generate_file, binding
  end
  
  def rebuild
    rebuild_file = self.file_fetcher.fetch_path('generator/rebuild.rb')
    eval rebuild_file, binding
  end
  
end
