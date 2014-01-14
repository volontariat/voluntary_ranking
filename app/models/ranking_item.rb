class RankingItem < ActiveRecord::Base
  include Concerns::Model::BaseRankingItem
  
  attr_accessible :ranking_id, :thing, :thing_type, :thing_id, :best, :stars
  
  has_many :user_ranking_items, dependent: :destroy
  
  validates :thing_id, presence: true, uniqueness: { scope: [:ranking_id, :thing_type] }
  validate :type_equals_thing_type_of_ranking
  
  acts_as_list scope: :ranking
  
  private
  
  def type_equals_thing_type_of_ranking
    return unless ranking_thing_type = ranking.try(:thing_type)

    unless ranking_thing_type == thing_type
      errors[:thing_type] << I18n.t('activerecord.errors.models.ranking_item.attributes.thing_type.no_valid_type_for_list') 
    end
  end
end