class UserRankingItem < ActiveRecord::Base
  include Concerns::Model::BaseRankingItem
  
  attr_accessible :ranking, :ranking_id, :thing, :thing_type, :thing_id, :best, :stars
  
  belongs_to :user
  belongs_to :ranking_item
  
  validates :user_id, presence: true
  validates :ranking_item_id, presence: true, uniqueness: { scope: [:user_id] }
  validates :stars, presence: true
  validate :stars_and_best
  
  after_validation :copy_validation_errors_from_ranking_item # or before?
  
  acts_as_list scope: [:user_id, :ranking_id]
  
  def move_to_top_of_page(page)
    position = user.ranking_items.order('position').where(ranking_id: ranking_id).paginate(page: page, per_page: 3).first.position
    insert_at(position)
  end
  
  # TODO: still needed?
  def set_position(value)
=begin    
    user_ranking_items = UserRankingItem.where(
      'ranking_item_id = :ranking_item_id AND (position >= :position - 1 AND position <= :position + 1)', 
      ranking_item_id: ranking_item_id, position: value
    ).order('position ASC')
    
    previous_item = user_ranking_items.select{|item| item.position < value}.first
    item = user_ranking_items.select{|item| item.position == value}.first
    next_item = user_ranking_items.select{|item| item.position > value}.first
    
    item_to_copy_stars_from = if position > value
      # 2 > 1
      # 4 > 2
      # down
      previous_item.present? ? previous_item : item
    else
      # 1 > 2
      # 2 > 4
      # up
      previous_item.present? ? previous_item : item
    end
=end

    #raise [UserRankingItem.all.map{|item| [item.position, item.ranking_item_id]}, UserRankingItem.where(
    #  'ranking_item_id = :ranking_item_id AND position = :position', ranking_item_id: ranking_item_id, position: value
    #).to_sql].inspect

    item = UserRankingItem.where(
      'ranking_id = :ranking_id AND position = :position', ranking_id: ranking_id, position: value
    ).first
    
    self.stars = item.stars; self.best = item.best;
    
    insert_at(value)
    
    reload
  end
  
  private
  
  def copy_validation_errors_from_ranking_item
    return if self.ranking_item.blank? || self.ranking_item.valid?
    
    self.ranking_item.errors.each do |field, ranking_item_errors| 
      ranking_item_errors = [ranking_item_errors] unless ranking_item_errors.is_a?(Array)
      
      ranking_item_errors.each do |error| 
        unless attributes.has_key?(field.to_s)
          field = :base
          error = "#{field.to_s.humanize}: #{error}" 
        end
        
        self.errors[field] << error unless self.errors[field].include? error
      end
    end
  end
  
  def stars_and_best
    if self.stars >= 3 && !self.best
      self.errors[:best] << 'Item cannot be worst with more stars than 3.'
    elsif self.stars <= 2 && self.best
      self.errors[:best] << 'Item cannot be best with less stars than 3.'
    end
  end
end