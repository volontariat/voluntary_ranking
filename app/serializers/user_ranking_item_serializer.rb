class UserRankingItemSerializer < BaseRankingItemSerializer
  attributes :user_name
  
  def user_name
    object.user.name
  end
end