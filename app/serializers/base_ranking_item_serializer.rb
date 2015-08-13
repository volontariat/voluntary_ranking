class BaseRankingItemSerializer < ActiveModel::Serializer
  attributes :id, :position, :thing_type, :thing_id, :thing_name, :best, :stars, :ranking_adjective, :ranking_negative_adjective, :ranking_topic, :ranking_scope

  def thing_name
    object.thing.name
  end
  
  def ranking_adjective
    object.ranking.adjective
  end
  
  def ranking_negative_adjective
    object.ranking.negative_adjective
  end
  
  def ranking_topic
    object.ranking.topic
  end
  
  def ranking_scope
    object.ranking.scope
  end
end