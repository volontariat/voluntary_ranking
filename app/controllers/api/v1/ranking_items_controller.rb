class Api::V1::RankingItemsController < ActionController::Base
  include Voluntary::V1::BaseController
  include Concerns::Controller::BaseRankingItemsController
  
  respond_to :json
  
  def index
    #respond_with list.present? ? list.items.includes(:thing) : []
    respond_with ranking.present? ? ranking.items.includes(:thing) : []
  end
end