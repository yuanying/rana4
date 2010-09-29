class Site < ActiveRecord::Base
  has_many :writings, :dependent=>:destroy
  has_many :authors, :source => :user, :through => :writings
  has_many :entries, :dependent=>:nullify
  composed_of :tz,
              :class_name => 'TimeZone',
              :mapping => %w(time_zone name)
  validates_presence_of :title
  validates_presence_of :url
  validates_presence_of :path
  
  scope :written_by, lambda {|user| joins(:writings) & Writing.where( :user_id => user.id )}
end
