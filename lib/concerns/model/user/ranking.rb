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
            thing = Thing.find_or_create_by(name: attributes[:thing_name])
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
           
            position = if attributes[:best]
              ranking_items.order('stars ASC, position DESC').where('stars >= ?', attributes[:stars]).first.try(:position).to_i + 1 || 1
            else
              item = ranking_items.order('stars DESC, position ASC').where('stars <= ?', attributes[:stars]).first
              
              if item.present?
                item.position
              else
                ranking_items.order('stars ASC, position DESC').where('stars >= ?', attributes[:stars]).first.try(:position).to_i + 1
              end
            end
            
            begin
              user_ranking_item.insert_at(position)
            rescue ActiveRecord::RecordInvalid
            end
              
            user_ranking_item
          end
        end
      end
    end
  end
end