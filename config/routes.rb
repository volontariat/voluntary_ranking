Rails.application.routes.draw do
  get '/products/ranking' => 'product/ranking#index'
  
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, path: 'v1' do
      # TODO: remove manual routing when get rid of this resource using root UsersController
      resources :argument_topics, only: [] do
        collection do
          get :autocomplete
        end  
      end
      
      resources :arguments
      resources :rankings
      resources :ranking_items
      
      resources :things, only: [:show] do
        collection do
          get :autocomplete
        end  
      end
      
      get '/things/:left_thing_name/vs/:right_thing_name/arguments', to: 'things/arguments#comparison'
      get '/things/:thing_name/is_one_of_the/:adjective/:topic/:scope', to: 'ranking_items#show'
      
      resources :user_ranking_items do
        member do
          put :move_to_page
          put :move
        end
      end
      
      resources :users
    end
  end
end
