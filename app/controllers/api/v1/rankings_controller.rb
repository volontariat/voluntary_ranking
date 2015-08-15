class Api::V1::RankingsController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    options = {}
  
    rankings = Ranking
    rankings = Ranking.for_thing(params[:thing_id]) if params[:thing_id].present?
    options[:json] = rankings.paginate(page: params[:page], per_page: 10)
    
    options[:meta] = { 
      pagination: {
        total_pages: options[:json].total_pages, current_page: options[:json].current_page,
        previous_page: options[:json].previous_page, next_page: options[:json].next_page
      }
    }
    
    respond_with do |format|
      format.json { render options }
    end
  end
  
  def autocomplete_attribute
    render json: Ranking.autocomplete_attribute(params[:attribute], params[:term]), root: false
  end
end