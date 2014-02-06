module VoluntaryRanking
  class Ability
    def self.after_initialize
      Proc.new do |ability, user, options|
        if user.present?
          ability.can :restful_actions, UserRankingItem, user_id: user.id
        end
      end
    end
  end
end
