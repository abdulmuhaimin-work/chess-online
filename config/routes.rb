Rails.application.routes.draw do
get '/chessboard', to: 'chessboard#chessboard'
  devise_for :users
  root to: "landing#index"
  resources :welcome
  mount ActionCable.server => "/cable"
end
