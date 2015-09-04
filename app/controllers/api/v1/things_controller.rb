class Api::V1::ThingsController < ActionController::Base
  include Voluntary::V1::BaseController

  respond_to :json

  def show
    @thing = Thing.where('LOWER(name) = ?', params[:id].downcase).first
    
    raise ActiveRecord::RecordNotFound if @thing.blank?
    
    respond_with do |format|
      format.json { render json: @thing, root: true }
    end
  end
  
  def autocomplete
    render json: (
      Thing.order(:name).where("LOWER(name) LIKE ?", "%#{params[:term].downcase}%").
      map{|t| { id: t.id, value: t.name }}
    ), root: false
  end
  
  def suggest
    render json: Thing.suggest(params[:term]), root: false
  end
end