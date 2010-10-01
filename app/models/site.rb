class Site < ActiveRecord::Base
  has_many :writings, :dependent=>:destroy
  has_many :authors, :source => :user, :through => :writings
  has_many :entries, :dependent=>:nullify
  composed_of :tz,
              :class_name => 'ActiveSupport::TimeZone',
              :mapping => %w(timezone name)
  validates_presence_of :title
  validates_presence_of :url
  validates_presence_of :path
  
  scope :written_by, lambda {|user| joins(:writings) & Writing.where( :user_id => user.id )}
  
  def writings_attributes=(writings_attributes={})
    self.writings.delete_all
    writings_attributes.each do |k, v|
      v = v[:user_id].to_i
      w = Writing.new
      w.user_id = v
      self.writings << w
    end
  end
end
