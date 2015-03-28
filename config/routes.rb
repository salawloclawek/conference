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

    collection do
      get :set_participate
      get :bridge
    end

  end

end
