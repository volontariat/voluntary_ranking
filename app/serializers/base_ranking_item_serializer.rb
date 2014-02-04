class BaseRankingItemSerializer < ActiveModel::Serializer
  attributes :id, :position, :thing_type, :thing_id, :thing_name, :best, :stars

  def thing_name
    object.thing.name
  end
end