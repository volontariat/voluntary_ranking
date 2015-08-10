class Argument < ActiveRecord::Base
  belongs_to :topic, class_name: 'ArgumentTopic'
  belongs_to :thing
  
  validates :topic_id, presence: true
  validates :thing_id, presence: true, uniqueness: { scope: :topic_id }
  validates :value, presence: true
  
  attr_accessible :topic_id, :thing_id, :value
  
  def self.create_with_topic(attributes)
    topic = ArgumentTopic.where('LOWER(name) = ?', attributes[:topic_name].to_s.strip.downcase).first
    
    unless topic
      topic = ArgumentTopic.create(name: attributes[:topic_name].to_s.strip)
    end
    
    if topic.valid?
      argument = Argument.create(topic_id: topic.id, thing_id: attributes[:thing_id], value: attributes[:value])
      
      if argument.valid?
        argument
      else
        { errors: argument.errors.to_hash }
      end
    else
      { errors: { topic: topic.errors.to_hash } }
    end
  end
end