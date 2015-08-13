class Ranking < ActiveRecord::Base
  attr_accessible :adjective, :topic, :scope, :thing_type, :negative_adjective
  
  has_many :items, class_name: 'RankingItem', dependent: :destroy
  
  scope :for_thing, ->(thing_id) do
    select('DISTINCT(rankings.id), rankings.*').joins(:items).where('ranking_items.thing_id = ?', thing_id)
  end 
  
  validates :adjective, presence: true
  validates :topic, presence: true, uniqueness: { scope: [:adjective, :scope] }
  validates :scope, presence: true
  validate :one_ranking_per_topic_scope_and_one_of_the_adjectives
  
  #pusherable "#{Rails.env}_channel"
  
  def self.find_by_params(params)
    scope = if params[:negative_adjective].present?
      where(
        'LOWER(adjective) = ? AND LOWER(negative_adjective) = ?', 
        params[:adjective].downcase, params[:negative_adjective].downcase
      )
    else
      where(
        '(LOWER(adjective) = :adjective OR LOWER(negative_adjective) = :adjective)', 
        adjective: params[:adjective].downcase
      )
    end
     
    scope.where(
      'LOWER(topic) = ? AND LOWER(scope) = ?', params[:topic].downcase, params[:scope].downcase
    ).first
  end
  
  def self.find_or_create_by_params(params)
    attributes = (params[:user_ranking_item] || params[:ranking_item] || params).clone
    attributes.symbolize_keys! unless params.is_a?(ActiveSupport::HashWithIndifferentAccess)
    
    if attributes[:ranking_id].present? then Ranking.find(attributes[:ranking_id])
    elsif attributes[:adjective].present?
      rankings = Ranking
      ranking  = Ranking.new
      
      attributes.each do |param, value| 
        next if value.nil?
        
        if ranking.respond_to?(param)
          rankings = rankings.where("LOWER(#{param}) = ?", value.downcase)
        else
          attributes.delete(param)
        end
      end
       
      rankings.first || Ranking.create(attributes)
    end
  end
  
  private
  
  def one_ranking_per_topic_scope_and_one_of_the_adjectives
    if Ranking.where(
      '(' +
      '(adjective = :adjective OR negative_adjective = :adjective) AND ' +
      '(adjective = :negative_adjective OR negative_adjective = :negative_adjective)' +
      ') AND ' + 
      'topic = :topic AND scope = :scope',
      adjective: adjective, negative_adjective: negative_adjective, topic: topic, scope: scope
    ).any?
      errors[:base] << I18n.t(
        'activerecord.errors.models.ranking.attributes.base.' + 
        'one_ranking_per_topic_scope_and_one_of_the_adjectives'
      )
    end
  end
end