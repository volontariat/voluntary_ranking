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
    item_on_top_of_page = user.ranking_items.where(ranking_id: ranking_id).order('position').paginate(page: page, per_page: 10).first
    self.stars = item_on_top_of_page.stars
    self.best = item_on_top_of_page.best
    insert_at(item_on_top_of_page.position)
  end
  
  def set_position(value)
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