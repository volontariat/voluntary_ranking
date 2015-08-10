class ArgumentTopic < ActiveRecord::Base
  has_many :arguments
  
  validates :name, presence: true, uniqueness: true
  
  attr_accessible :name, :text
end