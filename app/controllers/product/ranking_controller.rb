class Product::RankingController < Voluntary::EmberJs::ApplicationController
  layout Proc.new { |controller| controller.request.xhr? || request.format.try('json?') ? false : 'voluntary/ember_js' }
  
  def index
  end
  
  protected
  
  def voluntary_ember_js_stylesheets
    ['voluntary_ranking/application']
  end
  
  def voluntary_ember_js_javascripts
    ['voluntary_ranking/application']
  end
end