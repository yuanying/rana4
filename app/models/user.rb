class User < ActiveRecord::Base
  has_many :entries, :dependent=>:nullify
  validates_length_of :name, :within => 3..64, :allow_blank => true, :allow_nil => true
  validates_length_of :email, :within => 0..255, :allow_blank => true, :allow_nil => true
end
