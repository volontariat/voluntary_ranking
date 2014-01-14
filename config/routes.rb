Rails.application.routes.draw do
  match '/products/ranking' => 'product/ranking#index'
  
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, path: 'v1' do
      resources :rankings
      resources :ranking_items
      resources :user_ranking_items
    end
  end
end
