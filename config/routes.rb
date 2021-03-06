CMW::Application.routes.draw do
  get  'subscriptions' => 'subscriptions#index'
  get  'coming_soon'   => 'coming_soon#index'
  post 'coming_soon'   => 'coming_soon#create'


  # root to: 'coming_soon#index', as: "invite"

  resources :comments, only: [:create]

  get '/search' => 'search#search'

  # переключить локаль
  get '/lang/:locale' => 'api/v1/common_api#switch_locale'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # проверить
      scope '/check' do
        post  'email'       => 'common_api#check_email'
        post  'username'    => 'common_api#check_username'
        get 'signed' => 'common_api#user_signed'
      end

      # пользователи
      resources :users, except: [:new, :create] do
        # создаст маршруты без параметра :id
        collection do
          get 'settings'  => 'users#settings'
        end
      end

    end   # v1
  end   # api

  # путь / (корень)
  root to: 'root#index'

  # все вьюхи
  scope '/views' do
    # сцена
    get 'index'           => 'root#index'
  end

      # пользователь
  get '/:username' => 'profile#show', as: "profile_show"
  scope '/:username' do
      # профиль
    get 'profile'       => 'profile#index'
    # новости
    get 'feed'          => 'feed#index'
    # подписки
    get 'subscriptions' => 'subscriptions#index'
    # работы
    get '/works', to: redirect('/%{username}')
    scope '/works' do
      # список
      get '/list'       => 'works#list'
      # добавить новую
      get '/new' => 'works#new', as: "add_work"
      patch ':id/edit' => 'works#update', as: "update_work"
      get ':id/edit' => 'works#edit', as: "edit_work"
      post '/new' => 'works#create', as: "create_work"
      delete '/:id' => 'works#destroy', as: "destroy_work"
      # просмотр работы
      get '/:id' => 'works#show', as: "show_work"

      scope '/:id' do
        resources :comments, except: %w( index update edit )
      end
    end
      resources :favorite_works, only: [:index, :create, :destroy]
  end
      get '/works/list', to: redirect('/')
  devise_scope :user do

    get '/auth' => redirect('/auth/login')
    scope '/auth' do

      get  'register'    => 'users/registrations#new'
      post 'register'    => 'users/registrations#create'

      get  'forgot'      => 'users/passwords#new'
      post 'forgot'      => 'users/passwords#create'

      authenticate :user do
        # get  'delete'    => 'users/registrations#cancel'
        get  'settings'  => 'users/registrations#edit'
        put  'settings'  => 'users/registrations#update'
      end
    end
  end

  # devise
  devise_for  :users, path: 'auth',
    # прячем стандартные роуты для регистрации
    skip: ['registrations'],
    # переопределение контроллеров
    controllers: {
      registrations:  'users/registrations',
      sessions:       'users/sessions',
      confirmations:  'users/confirmations',
      passwords:      'users/passwords'
    },
    # переопределение путей по умолчанию
    path_names: {
      sign_in:        'login',
      sign_out:       'logout',
      confirmation:   'confirm',
      registration:   'register',
      cancel:         'delete'
    }

  resources :users

end   # CMW::Application.routes.draw
