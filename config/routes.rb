Rails.application.routes.draw do
  match '/products/ranking' => 'product/ranking#index'
end
