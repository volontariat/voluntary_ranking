class Api::V1::UserRankingItemsController < ActionController::Base
  include Voluntary::V1::BaseController
  include Concerns::Controller::BaseRankingItemsController
  
  respond_to :json
  
  def index
    respond_with ranking.present? ? user.ranking_items.where(ranking_id: ranking.id).includes(:thing) : []
  end
  
  def create
    raise CanCan::AccessDenied if current_user.blank?
    
    respond_to do |format|
      format.json { render json: current_user.add_ranking_item(params[:user_ranking_item]) }
    end
  end
  
  private
  
  def user
    @user ||= User.find(params[:user_id])
  end
end