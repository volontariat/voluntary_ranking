class ArgumentSerializer < ActiveModel::Serializer
  attributes :id, :topic_id, :topic_name, :thing_id, :thing_name, :value

  def thing_name
    object.thing.try(:name)
  end
  
  def topic_name
    object.topic.try(:name)
  end
end