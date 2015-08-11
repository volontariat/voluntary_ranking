class Argument < ActiveRecord::Base
  belongs_to :topic, class_name: 'ArgumentTopic'
  belongs_to :thing
  
  scope :compare_two_things, ->(side, left_thing_name, right_thing_name) do
    left_thing_name, right_thing_name = right_thing_name, left_thing_name if side == 'right'
      
    left_thing = Thing.where('LOWER(name) = ?', left_thing_name.downcase).first
    right_thing = Thing.where('LOWER(name) = ?', right_thing_name.downcase).first
    
    scope = joins(:topic).select('arguments.id, arguments.value, arguments.topic_id, argument_topics.name AS topic_name, arguments2.id AS right_id, arguments2.value AS right_value').
    joins("#{side == 'both' ? 'INNER' : 'LEFT'} JOIN arguments arguments2 ON arguments2.thing_id = #{sanitize(right_thing.id)} AND arguments2.topic_id = arguments.topic_id")
    scope = scope.where('arguments2.id IS NULL') unless side == 'both'
    scope.where('arguments.thing_id = ?', left_thing.id)
  end
  
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