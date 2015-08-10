class Api::V1::ThingsController < ActionController::Base
  include Voluntary::V1::BaseController

  respond_to :json

  def show
    @thing = Thing.find(params[:id])
    
    respond_with do |format|
      format.json { render json: @thing, root: true }
    end
  end
end