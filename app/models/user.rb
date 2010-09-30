class User < ActiveRecord::Base
  has_many :entries, :dependent=>:nullify
  validates_length_of :name, :within => 3..64, :allow_blank => true, :allow_nil => true
  validates_length_of :email, :within => 0..255, :allow_blank => true, :allow_nil => true
  
  def display_name
    return self.name unless self.name.nil? || self.name.empty?
    return self.cas_id
  end
  
  def author? site
    return false unless site.kind_of? Site
    site.writings.each do |w|
      return true if w.user_id == self.id
    end
    false
  end
end
