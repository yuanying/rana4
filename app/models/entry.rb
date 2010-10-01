class Entry < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  
  validates_presence_of :title
  validates_presence_of :posted_at
  validates_uniqueness_of :path, :scope=>:site_id
  validates_uniqueness_of :identify_string
  validates_format_of :path, :with => /^(\/[\w\-_]+)+$/
  validates_presence_of :path_suggestion, :on => :create
  validates_format_of :path_suggestion, :on => :create, :with => /^(\/([\w\-_]+|(\$\{[\w\-_]+\})))+$/
  
  composed_of :posted_at_local, :class_name => 'Time'
  
  attr_accessor :path_suggestion
  
  def after_initialize
    self.posted_at = DateTime.now
    self.path_suggestion = "/#{self.posted_at.strftime('%Y')}/#{self.posted_at.strftime('%m')}/#{self.posted_at.strftime('%d')}/#{self.posted_at.strftime('%H-%M-%S')}"
    self.identify_string = get_unique_string(:identify_string)
  end
  
  def before_validation_on_create
    self.path = self.path_suggestion
    self.uniquirize_path!
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
end
