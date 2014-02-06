module VoluntaryRanking
  class Ability
    def self.after_initialize(user, options = {})
      if user.present?
        can :restful_actions, UserRankingItem, user_id: user.id
      end
    end
  end
end
