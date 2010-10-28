require 'rana4'

class Rana4::FileFetcher
  FILE_LOAD_PATH = ["#{Rails.root}/config/rana4", "#{Rails.root}/rana4"]
  
  attr_reader :load_path
  
  def initialize site
    @load_path = FILE_LOAD_PATH.dup
    @load_path.unshift("#{site.path.chomp('/')}/WEB-INF")
  end
  
  def fetch_path relative_path
    self.load_path.each do |path|
      path = File.join(path, relative_path)
      return path if File.file?(path)
    end
  end
end
