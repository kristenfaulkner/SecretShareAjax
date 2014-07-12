SecretShareAjax::Application.routes.draw do
  resources :users, :only => [:create, :new, :index, :show] do
    resources :secrets, :only => [:create]
    resources :friendships, :only => [:create, :destroy]
  end
  resource :session, :only => [:create, :destroy, :new]

  root :to => "users#show"
end
