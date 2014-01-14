class Ranking < ActiveRecord::Base
  attr_accessible :adjective, :topic, :scope, :thing_type, :negative_adjective
  
  has_many :items, class_name: 'RankingItem', dependent: :destroy
  
  validates :adjective, presence: true
  validates :topic, presence: true, uniqueness: { scope: [:adjective, :scope] }
  validates :scope, presence: true
  
  #pusherable "#{Rails.env}_channel"
  
  def self.find_or_create_by_params(params)
    attributes = (params[:user_ranking_item] || params[:ranking_item] || params).clone
    attributes.symbolize_keys! unless params.is_a?(ActiveSupport::HashWithIndifferentAccess)
    
    if attributes[:ranking_id].present? then Ranking.find(attributes[:ranking_id])
    elsif attributes[:adjective].present?
      ranking  = Ranking.new
      
      attributes.each {|param, value| attributes.delete(param) unless ranking.respond_to?(param) }
      
      Ranking.where(attributes).first || Ranking.create(attributes)
    elsif attributes[:topic].present?
      begin 
        attributes[:topic].classify.constantize.ranking
      rescue NameError
      end
    end
  end
end