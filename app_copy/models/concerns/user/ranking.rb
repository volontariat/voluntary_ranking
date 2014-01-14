class User
  module AddThingToUserList
    def << *args
      thing = args.first
      proxy_association.owner.user_list_items.create!(list: thing.class.list, thing: thing)
      self
    end
    
    alias_method :create, :<<
  end

  module Ranking
    extend ActiveSupport::Concern
    
    included do
      has_many :global_rankings, class_name: 'List'
      has_many :user_list_items, class_name: 'UserListItem'
      has_many :rankings, class_name: 'List', through: :user_list_items, dependent: :destroy
      has_many :things, extend: AddThingToUserList
      
      def add_list_item(attributes)
        attributes = attributes ||= {}
        list = attributes['list_id'].present? ? List.find(attributes['list_id']) : nil
       
        thing = if attributes['thing'].present? then attributes['thing']
        elsif attributes['thing_id'].present? then Thing.find(attributes['thing_id'])
        else Thing.find_or_initialize_by_name(attributes['thing_name'])
        end
        
        user_list_item = user_list_items.build(
          list_id: list.try(:id), thing: thing, best: attributes['best'], stars: attributes['stars']
        )
        user_list_item.save
        
        user_list_item
      end
    end 
  end
end