Rails.application.routes.draw do

  root 'meets#index'

  resources :meets, path: 'konferencje', path_names: { new: 'nowa', edit: 'edycja' } do
    member do

    end
  end

  resources :phones, path: 'telefony', path_names: { new: 'nowy', edit: 'edycja' } do

    member do
      patch :mute
      patch :unmute
    end

    collection do
      get :set_participate
      get :bridge
    end

  end

end
