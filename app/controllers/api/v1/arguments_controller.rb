class Api::V1::ArgumentsController < ActionController::Base
  include Voluntary::V1::BaseController
 
  respond_to :json
  
  def index
    options = {}
  
    arguments = Argument
    arguments = Argument.where(thing_id: params[:thing_id]) if params[:thing_id].present?
    options[:json] = arguments.paginate(page: params[:page], per_page: 10)
    
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
  
  def create
    raise CanCan::AccessDenied if current_user.blank?
    
    respond_to do |format|
      format.json { render json: Argument.create_with_topic(params[:argument]) }
    end
  end
end