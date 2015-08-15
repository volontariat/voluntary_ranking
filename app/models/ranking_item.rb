class RankingItem < ActiveRecord::Base
  include Concerns::Model::BaseRankingItem
  
  attr_accessible :ranking_id, :thing, :thing_id, :best, :stars
  
  has_many :user_ranking_items, dependent: :destroy
  
  validates :thing_id, presence: true, uniqueness: { scope: :ranking_id }
  
  acts_as_list scope: :ranking
end