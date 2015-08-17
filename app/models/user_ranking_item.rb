class UserRankingItem < ActiveRecord::Base
  include Concerns::Model::BaseRankingItem
  
  attr_accessible :ranking, :ranking_id, :thing, :thing_id, :best, :stars
  
  belongs_to :user
  belongs_to :ranking_item, counter_cache: true
  
  validates :user_id, presence: true
  validates :ranking_item_id, presence: true, uniqueness: { scope: [:user_id] }
  validates :stars, presence: true
  validate :stars_and_best
  
  after_validation :copy_validation_errors_from_ranking_item # or before?
  after_create :add_stars_to_ranking_item
  after_update :remove_or_add_stars_to_ranking_item, if: 'stars_changed?'
  
  after_destroy :destroy_ranking_item, if: 'UserRankingItem.where(ranking_item_id: ranking_item_id).count == 0'
  
  acts_as_list scope: [:user_id, :ranking_id]
  
  def self.position_for_user_by_stars(user_id, ranking_id, user_ranking_item_id, stars)
    ranking_items = where(user_id: user_id, ranking_id: ranking_id)
    ranking_items_count = ranking_items.count
    ranking_items = ranking_items.where('id <> ?', user_ranking_item_id) if user_ranking_item_id.present?
    
    if stars.to_i >= 3
      ranking_items.order('stars ASC, position DESC').where('stars >= ?', stars).first.try(:position).to_i + 1 || 1
    else
      item = ranking_items.order('stars DESC, position ASC').where('stars <= ?', stars).first
      
      if item.present?
        if user_ranking_item_id.present? && item.stars < stars
          item.position - 1
        else
          item.position
        end
      else
        position = ranking_items.order('stars ASC, position DESC').where('stars >= ?', stars).first.try(:position).to_i + 1
        
        position -= 1 if user_ranking_item_id.present? && position > ranking_items_count

        position
      end
    end
  end
  
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
  
  def update_stars(stars)
    self.stars = stars
    self.best = stars >= 3
    save!
    insert_at UserRankingItem.position_for_user_by_stars(user_id, ranking.id, id, stars)
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
  
  def destroy_ranking_item
    ranking_item.destroy
  end
  
  def add_stars_to_ranking_item
    ranking_item.stars_sum += stars
    
    if ranking_item.stars_sum == 0
      ranking_item.stars = 0
    else
      ranking_item.stars = (ranking_item.stars_sum / ranking_item.user_ranking_items_count).round
    end
    
    ranking_item.save
    ranking_item.update_position
  end
  
  def remove_or_add_stars_to_ranking_item
    if stars > stars_was
      #puts "remove_or_add_stars_to_ranking_item.1: #{ranking_item.stars_sum} += (#{stars} - #{stars_was})"
      ranking_item.stars_sum += (stars - stars_was)
    else
      #puts "remove_or_add_stars_to_ranking_item.2: #{ranking_item.stars_sum} -= (#{stars_was} - #{stars})"
      ranking_item.stars_sum -= (stars_was - stars)
    end
    
    if ranking_item.stars_sum == 0
      ranking_item.stars = 0
    else
      ranking_item.stars = (ranking_item.stars_sum / ranking_item.user_ranking_items_count).round
    end
    
    ranking_item.save
    ranking_item.update_position
  end
end