class Message < ActiveRecord::Base
  
  attr_accessible :name, :message, :subject
  
  validates_presence_of :name
  validates_presence_of :message
  validates_presence_of :subject
  validates_length_of :name, :maximum => 30
  validates_length_of :subject, :maximum => 80
  validates_length_of :message, :maximum => 255
end
