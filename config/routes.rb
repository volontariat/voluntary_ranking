Rails.application.routes.draw do
  get '/products/ranking' => 'product/ranking#index'
  
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, path: 'v1' do
      resources :rankings
      
      get '/rankings/attributes/:attribute/autocomplete', to: 'rankings#autocomplete_attribute'
      
      resources :ranking_items
      
      resources :things, only: [:show] do
        collection do
          get :autocomplete
          get :suggest
        end  
      end
      
      get '/things/:thing_name/is_one_of_the/:adjective/:topic/:scope', to: 'ranking_items#show'
      
      resources :user_ranking_items do
        member do
          put :move_to_page
          put :move
        end
      end
    end
  end
end