Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :game, only: [:index]
  resources :high_scores, only: [:index]

  root to: 'game#index'

end
