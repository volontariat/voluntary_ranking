class Ranking < ActiveRecord::Base
  attr_accessible :adjective, :topic, :scope, :negative_adjective
  
  has_many :items, class_name: 'RankingItem', dependent: :destroy
  has_many :user_items, class_name: 'UserRankingItem', dependent: :destroy
  
  scope :for_user, ->(user_name) do
    all.select('DISTINCT(rankings.id), rankings.*').joins(:user_items).
    where('user_ranking_items.user_id = ?', User.where('LOWER(name) = ?', user_name.downcase).first.id)
  end 

  scope :for_thing, ->(thing_id) do
    all.select('DISTINCT(rankings.id), rankings.*').joins(:items).where('ranking_items.thing_id = ?', thing_id)
  end 
  
  validates :adjective, presence: true
  validates :topic, presence: true, uniqueness: { scope: [:adjective, :scope], case_sensitive: false }
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
        if ranking.respond_to?(param) && value.present?
          rankings = rankings.where("LOWER(#{param}) = ?", value.downcase)
        else
          attributes.delete(param)
        end
      end
       
      rankings.first || Ranking.create(attributes)
    end
  end
  
  def self.autocomplete_attribute(attribute, term)
    unless ['adjective', 'negative_adjective', 'topic', 'scope'].include? attribute
      raise ActiveRecord::RecordNotFound
    end
    
    Ranking.select("DISTINCT(#{attribute})").order(attribute).limit(10).
    where("LOWER(#{attribute}) LIKE ?", "%#{term.strip.downcase}%").map(&attribute.to_sym).map{|v| { value: v }}
  end
  
  private
  
  def one_ranking_per_topic_scope_and_one_of_the_adjectives
    if Ranking.where(
      '(' +
      'LOWER(adjective) = :adjective OR LOWER(negative_adjective) = :adjective OR ' +
      'LOWER(adjective) = :negative_adjective OR LOWER(negative_adjective) = :negative_adjective' +
      ') AND ' + 
      'LOWER(topic) = :topic AND LOWER(scope) = :scope',
      adjective: adjective.downcase, negative_adjective: negative_adjective.downcase, 
      topic: topic.downcase, scope: scope.downcase
    ).any?
      errors[:base] << I18n.t(
        'activerecord.errors.models.ranking.attributes.base.' + 
        'one_ranking_per_topic_scope_and_one_of_the_adjectives'
      )
    end
  end
  
  def special_characters_excluded
    if adjective.match(/\//) || negative_adjective.match(/\//) || topic.match(/\//) || scope.match(/\//)
      errors[:name] << I18n.t(
        'activerecord.errors.models.ranking.attributes.name.unwanted_special_characters_included'
      )
    end
  end
end