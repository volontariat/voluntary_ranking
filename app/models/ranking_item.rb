class RankingItem < ActiveRecord::Base
  include Concerns::Model::BaseRankingItem
  
  attr_accessible :ranking_id, :thing, :thing_id, :best, :stars
  
  has_many :user_ranking_items, dependent: :destroy
  
  validates :thing_id, presence: true, uniqueness: { scope: :ranking_id }
  
  acts_as_list scope: :ranking_id
  
  def update_position
    other_ranking_item = RankingItem.where(
      'ranking_id = ? AND stars_sum >= ? AND id <> ?', ranking_id, stars_sum, id
    ).order('position DESC').first
  
    if other_ranking_item
      if RankingItem.where(ranking_id: ranking_id).count >= other_ranking_item.position + 1
        #puts "update_position.1.1 (#{thing.name} with #{stars_sum}): #{other_ranking_item.position + 1}"
        insert_at other_ranking_item.position + 1
      else
        #puts "update_position.1.2 (#{thing.name} with #{stars_sum}): #{other_ranking_item.position}"
        insert_at other_ranking_item.position
      end
    else
      #puts "update_position.2 (#{thing.name} with #{stars_sum}): 1"
      insert_at 1
    end
  end
end