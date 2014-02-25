class Api::V1::UserRankingItemsController < ActionController::Base
  include Voluntary::V1::BaseController
  include Concerns::Controller::BaseRankingItemsController
  
  respond_to :json
  
  def index
    options = {}
    
    if ranking.present?
      options[:json] = user.ranking_items.order('position').where(ranking_id: ranking.id).includes(:thing).paginate(page: params[:page], per_page: 3)
      
      options[:meta] = { 
        pagination: {
          total_pages: options[:json].total_pages, current_page: options[:json].current_page,
          previous_page: options[:json].previous_page, next_page: options[:json].next_page
        }
      }
    else
      options[:json] = []
      options[:meta] = { pagination: { total_pages: 0, current_page: 0, previous_page: 0, next_page: 0 } }
    end
    
    respond_with do |format|
      format.json { render options }
    end
  end
  
  def create
    raise CanCan::AccessDenied if current_user.blank?
    
    respond_to do |format|
      format.json { render json: current_user.add_ranking_item(params[:user_ranking_item]) }
    end
  end
  
  def update
    user_ranking_item = UserRankingItem.find(params[:id])
    
    raise CanCan::AccessDenied unless can? :update, user_ranking_item
    
    user_ranking_item.update_attributes(params[:user_ranking_item])
    respond_with user_ranking_item
  end
  
  def move
    user_ranking_item = UserRankingItem.find(params[:id])
    
    raise CanCan::AccessDenied unless can? :update, user_ranking_item
    
    user_ranking_item.set_position(params[:position].to_i)
    respond_with user_ranking_item
  end
  
  def move_to_page
    user_ranking_item = UserRankingItem.find(params[:id])
    
    raise CanCan::AccessDenied unless can? :update, user_ranking_item
    
    user_ranking_item.move_to_top_of_page(params[:page])
    
    respond_to do |format|
      format.json { render json: user_ranking_item }
    end
  end
  
  private
  
  def user
    @user ||= User.find(params[:user_id])
  end
end