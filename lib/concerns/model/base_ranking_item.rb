module Concerns
  module Model
    module BaseRankingItem
      extend ActiveSupport::Concern
      
      included do
        belongs_to :ranking
        belongs_to :thing
        
        validates :ranking_id, presence: true
        validates :thing_id, presence: true
        
        #pusherable "#{Rails.env}_channel"
        
        def thing=(thing)
          thing.save if thing.new_record?
          
          self.thing_id = thing.id
          
          if self.respond_to?(:ranking_item_id) && self.ranking.present?
            self.ranking_item ||= self.ranking.items.find_or_create_by_thing_id(thing_id)
          end
          
          thing
        end
      end
    end 
  end
end
