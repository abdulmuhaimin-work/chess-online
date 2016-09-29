Rails.application.routes.draw do
get '/chessboard', to: 'chessboard#chessboard'
  devise_for :users
  root to: "welcome#index"
  mount ActionCable.server => "/cable"
end
