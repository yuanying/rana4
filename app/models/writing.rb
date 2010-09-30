class Writing < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  
  validates_uniqueness_of :user_id, :scope => :site_id
end
