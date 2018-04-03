Rails.application.routes.draw do

  put '/news/:id(.:format)', to: 'news#update_complete'
  patch '/news/:id', to: 'news#update'
  put '/news/:news_id/comments/:id(.:format)', to: 'comments#update_complete'
  patch '/news/:news_id/comments/:id(.:format)', to: 'comments#update'
  resources :news do
    resources :comments
  end
  #resources :users
end
