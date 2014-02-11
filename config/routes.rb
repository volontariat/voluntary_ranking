Rails.application.routes.draw do
  get '/products/ranking' => 'product/ranking#index'
  
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, path: 'v1' do
      # TODO: remove manual routing when get rid of this resource using root UsersController
      resources :users
      resources :rankings
      resources :ranking_items
      resources :user_ranking_items do
        member do
          put :move_to_page
        end
      end
    end
  end
end
