Rails.application.routes.draw do
  mount Mercury::Engine => '/'

  get '/(*path)' => 'pages#show', as: :page
  put '/(*path)' => 'pages#update', as: :page
end
