Rails.application.routes.draw do
  mount Mercury::Engine => '/'

  get '/'      => 'pages#show'
  get '/*path' => 'pages#show'
  put '/*path' => 'pages#update'
end
