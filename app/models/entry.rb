class Entry < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_many :attachments, :dependent=>:nullify
  
  validates_presence_of :title
  validates_presence_of :posted_at
  validates_uniqueness_of :path, :scope=>:site_id
  validates_uniqueness_of :identify_string
  validates_format_of :path, :with => /^(\/[\w\-_]+)+$/
  validates_presence_of :path_suggestion, :on => :create
  validates_format_of :path_suggestion, :on => :create, :with => /^(\/([\w\-_]+|(\$\{[\w\-_]+\})))+$/
  
  composed_of :posted_at_local, :class_name => 'Time'
  
  after_initialize :setup_etc
  before_validation :setup_path, :on => :create
  before_validation :setup_description
  before_validation :update_formated_text
  
  attr_accessor :path_suggestion
  attr_accessor :identify_string_temp
  
  def setup_etc
    self.posted_at = DateTime.now unless self.posted_at
    self.path_suggestion = "/#{self.posted_at_local.strftime('%Y')}/#{self.posted_at_local.strftime('%m')}/#{self.posted_at_local.strftime('%d')}/#{self.posted_at_local.strftime('%H-%M-%S')}" unless self.path_suggestion
    self.identify_string_temp = get_unique_string(:identify_string) unless self.identify_string
    self.is_public = true unless self.is_public
    if self.format_type.nil? && self.user && self.site
      writing = Writing.find_by_user_id_and_site_id(self.user.id, self.site.id)
      self.format_type = writing.default_format_type 
    end
  end
  
  def setup_path
    self.path = self.path_suggestion
    self.uniquirize_path!
  end
  
  def setup_description
    if self.description.nil? || self.description.empty?
      self.description = self.body_text.gsub(/<.+?>/,'').split('')[0, 253].join('')
    end
  end
  
  def update_formated_text
    type = FormatType.find(self.format_type)
    self.formated_body_text   = type.format(self.body_text)
    self.formated_extend_text = type.format(self.extend_text)
  end
  
  # i don't know, create_time_zone_conversion_attribute? is what work.
  def self.create_time_zone_conversion_attribute?(name, column)
    if name.to_sym == :posted_at_local
      true
    else
      super
    end
  end
  
  def posted_at_local=(time)
    self.posted_at = time - self.site.tz.utc_offset
  end
  
  def posted_at_local
    self.posted_at + self.site.tz.utc_offset
  end
  
  def uniquirize_path!
    tmp_path = self.path.dup
    self.path = get_unique_string(:path, tmp_path)
    self.path
  end
  
  def get_unique_string property_name, seed=create_seed
    while Entry.where(:site_id => self.site_id, property_name => seed).count > 0
      seed.succ!
    end
    seed
  end
  
  def create_seed
    characters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    seed = Array.new(78){characters[rand(characters.size)]}.join
    seed
  end
  
  def attachments_attributes=(attachments_attributes=[])
    attachments_attributes.each do |a|
      attachment = Attachment.find_by_id(a[:id])
      self.attachments << attachment if attachment && (attachment.entry != self)
    end
  end
end
