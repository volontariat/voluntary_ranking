module Concerns
  module Model
    module User
      module Ranking
        module AddThingToUserList
          def << *args
            thing = args.first
            proxy_association.owner.user_list_items.create!(list: thing.class.list, thing: thing)
            self
          end
          
          alias_method :create, :<<
        end
      
        extend ActiveSupport::Concern
        
        included do
          has_many :rankings, through: :ranking_items, dependent: :destroy
          has_many :ranking_items, class_name: 'UserRankingItem', dependent: :destroy
          has_many :things, extend: AddThingToUserList
          
          def add_ranking_item(attributes)
            ranking = ::Ranking.find_or_create_by_params(attributes)
            thing = Thing.find_or_create_by_name(attributes[:thing_name])
            ranking_item_attributes = { 
              thing_type: 'Thing', thing_id: thing.id, best: attributes[:best], stars: attributes[:stars]
            }
            ranking_item = ranking.items.where(
              thing_type: ranking_item_attributes[:thing_type], thing_id: ranking_item_attributes[:thing_id]
            ).first_or_create
            
            user_ranking_item = ranking_items.new(
              ranking_item_attributes.merge(ranking_id: ranking.id)
            )
            user_ranking_item.ranking_item_id = ranking_item.id
            user_ranking_item.save
            
            user_ranking_item
          end
        end
      end
    end
  end
end