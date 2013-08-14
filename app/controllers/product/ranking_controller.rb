class Product::RankingController < VoluntaryCoreModuleEmberjs::ApplicationController
  layout Proc.new { |controller| controller.request.xhr? || request.format.try('json?') ? false : 'core_module/emberjs' }
  
  def index
  end
end