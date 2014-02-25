class Api::V1::RankingItemsController < ActionController::Base
  include Voluntary::V1::BaseController
  include Concerns::Controller::BaseRankingItemsController
  
  respond_to :json
  
  def index
    options = {}
    
    if ranking.present?
      options[:json] = ranking.items.order('position').includes(:thing).paginate(page: params[:page], per_page: 10)
      
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
end