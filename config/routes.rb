Rails.application.routes.draw do
  get '/'      => 'pages#show'
  get '/*path' => 'pages#show'
  put '/*path' => 'pages#update'
end
