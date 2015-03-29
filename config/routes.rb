Rails.application.routes.draw do

  root 'meets#index'

  post 'zaloguj' => 'sessions#create', as: :sessions
  delete 'wyloguj' => 'sessions#destroy', as: :session

  resources :sessions, only: [ :create, :destroy ]

  resources :meets, path: 'transmisje', path_names: { new: 'nowa', edit: 'edycja' } do

    member do
      get :p
      delete :kick_all
    end

    resources :phones, path: 'telefony', path_names: { new: 'nowy', edit: 'edycja' }

  end

  resources :phones, path: 'telefony' do

    member do
      patch :mute
      patch :unmute
      delete :kick
    end

  end

  namespace :asterisk do

    resources :meets, path: 'transmisje' do
      collection do
        get :pin
        get :phone_number
        get :exists
        get :internal_user_profile
      end
    end

    resources :phones, path: 'telefony' do
      collection do
        get :menu_callback
      end
    end

  end

  namespace :admin do
    resources :meets, path: 'transmisje' do

    end
  end

end
