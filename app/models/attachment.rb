require 'fileutils'
class Attachment < ActiveRecord::Base
  MAX_FILE_SIZE       = 3.megabyte
  MAX_WIDTH_OR_HEIGHT = 400
  
  belongs_to :entry
  belongs_to :site
  
  validates_presence_of :filename
  validates_inclusion_of :size, :in => (1..MAX_FILE_SIZE)
  
  before_create :save_image_to_disk
  after_destroy :delete_upload_images
  
  attr_accessor :adjust_size
    
  def file=(file)
    self.filename = file.original_filename if file.respond_to?(:original_filename)
    self.content_type = file.content_type  if file.respond_to?(:content_type)
    self.size = file.size                  if file.respond_to?(:size)
    @tmp = file
  end
  
  def validate
    ImageScience.with_image(@tmp.path) {|image| } if @tmp
  rescue
    errors.add(:file, t('activerecord.errors.messages.file_is_not_image'))
  end
  
  def disk_filepath
    File.join(self.site.path, self.filepath)
  end
  
  def iconpath
    "#{self.filepath}_icon.png"
  end
  
  def disk_iconpath
    "#{self.disk_filepath}_icon.png"
  end
  
  def save_image_to_disk
    raise 'Site is not set.' unless self.site
    self.filepath = calc_filepath
    FileUtils.mkdir_p(File.dirname(self.disk_filepath)) unless File.exist?(File.dirname(self.disk_filepath))
    
    ImageScience.with_image(@tmp.path) do |image|
      if adjust_size == '1'
        image.thumbnail(MAX_WIDTH_OR_HEIGHT) do |thumb|
          thumb.save self.disk_filepath
          self.width  = thumb.width
          self.height = thumb.height
        end
      else
        image.save self.disk_filepath
        self.width  = image.width
        self.height = image.height
      end

      image.cropped_thumbnail(100) do |cropped|
        cropped.save self.disk_iconpath
      end
    end
  rescue
    delete_upload_images
    return false
  end
  
  def delete_upload_images
    File.delete disk_filepath if File.exist? disk_filepath
    File.delete disk_iconpath if File.exist? disk_iconpath
  end
  
  protected
  # Returns an ASCII or hashed filename
  def calc_filepath
    datestamp = DateTime.now.strftime("/%Y/%m/%d")
    ascii = ''
    index = ''
    if filename =~ %r{^[a-zA-Z0-9_\.\-]*$}
      ascii = filename
    else
      ascii = Digest::MD5.hexdigest(filename)
      # keep the extension if any
      ascii << $1 if filename =~ %r{(\.[a-zA-Z0-9]+)$}
    end
    extname   = File.extname(ascii)
    basename  = File.basename(ascii, extname)
    while File.exist?(File.join(self.site.path, datestamp, "#{basename}#{index}#{extname}"))
      if index.empty?
        index = '_01'
      else
        index.succ!
      end
    end
    File.join(datestamp, "#{basename}#{index}#{extname}")
  end
end
