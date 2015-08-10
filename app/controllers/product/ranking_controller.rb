class Product::RankingController < VoluntaryCoreModuleEmberjs::ApplicationController
  layout Proc.new { |controller| controller.request.xhr? || request.format.try('json?') ? false : 'core_module/emberjs' }
  
  def index
  end
  
  protected
  
  def voluntary_core_module_emberjs_stylesheets
    ['voluntary_ranking/application']
  end
  
  def voluntary_core_module_emberjs_javascripts
    ['voluntary_ranking/application']
  end
end