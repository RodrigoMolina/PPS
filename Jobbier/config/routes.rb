Rails.application.routes.draw do

  #get 'backend', to: 'backend/main#index', as: :backend_root
  #root to: 'frontend/main#index', as: :root
  devise_for :users, :controllers => {:registrations => :registrations, :sessions => :sessions, :omniauth_callbacks => :omniauth_callbacks, :confirmations => :confirmations}


  root to: 'public/main#index', as: :root

  scope module: :public do


    get 'api/countries', to: 'api#countries'
    get 'api/provinces(/:country_id)', to: 'api#provinces'
    get 'api/cities(/:province_id)', to: 'api#cities'


    get 'categoria/:id', to: 'main#workshop_category', as: :public_main_workshop_category
    get 'taller/:id', to: 'main#workshop', as: :public_main_workshop
    get 'perfil/:id', to: 'main#profile', as: :public_main_profile
    get 'como-ser-instructor', to: 'main#how_to_instruct', as: :public_main_how_to_instruct
    get 'comentarios-taller/:id', to: 'main#workshop_comments', as: :public_main_workshop_comments
    get 'porque-taller-y-no-curso', to: 'main#why_workshop', as: :public_main_why_workshop
    get 'buscar-taller', to: 'main#search_workshop', as: :public_main_search_workshop


    get 'quien-puede-ser-instructor', to: 'main#who_can_be_a_instructor', as: :public_main_who_can_be_a_instructor
    get 'quien-garantiza-la-calidad-de-las-clases', to: 'main#who_guarantee_workshops', as: :public_main_who_guarantee_workshops
    get 'consultas', to: 'main#contact', as: :public_main_contact
    put 'enviar_consulta', to: 'main#contact_send', as: :public_main_contact_send
    get 'sobre-nosotros', to: 'main#about_us', as: :public_main_about_us
    get 'trabaja-con-nosotros', to: 'main#work_with_us', as: :public_work_with_us
    get 'catalogo', to: 'main#catalogue', as: :public_catalogue


    #get 'como-ser-instructor', to: 'main#', as: :public_main_

  end



  scope module: :authenticated do

    resources :users do
        member do
            get :confirm_email
        end
    end

    post 'comentario-taller', to: 'main#workshop_comment', as: :authenticated_main_workshop_comment
    get 'borrar-comentario-taller/:id', to: 'main#destroy_workshop_comment', as: :authenticated_main_destroy_workshop_comment
    get 'mis-talleres-como-instructor(/:state)', to: 'main#to_teach_workshops', as: :authenticated_main_to_teach_workshops
    get 'mis-talleres-como-aprendiz(/:state)', to: 'main#to_learn_workshops', as: :authenticated_main_to_learn_workshops

    get 'taller-como-instructor/:id', to: 'main#to_teach_workshop', as: :authenticated_main_to_teach_workshop
    get 'taller-como-instructor-turno/:id', to: 'main#to_teach_workshop_schedule', as: :authenticated_main_to_teach_workshop_schedule
    get 'taller-como-aprendiz/:id', to: 'main#to_learn_workshop', as: :authenticated_main_to_learn_workshop

    post 'mensaje-taller-turno', to: 'main#workshop_schedule_message', as: :authenticated_main_workshop_schedule_message

    get 'set_viewed_notifications', to: 'main#set_viewed_notifications', as: :authenticated_main_set_viewed_notifications

    get 'lista-de-deseos', to: 'main#wishlist', as: :authenticated_main_wishlist
    get 'chat', to: 'chat#index', as: :authenticated_chat_index
    get 'taller/:id/step/:step', to: 'workshops#step', as: :authenticated_workshops_step
    get 'taller/:id/main_wizard', to: 'workshops#main_wizard', as: :authenticated_workshops_main_wizard
    get 'taller-nuevo', to: 'workshops#create', as: :authenticated_workshops_create
    put 'taller-guardar/:id', to: 'workshops#update', as: :authenticated_workshops_update
    get 'taller-borrar/:id', to: 'workshops#destroy', as: :authenticated_workshops_destroy
    get 'favorito/:id', to: 'workshops#toggle_workshop_favorite', as: :authenticated_workshops_toggle_workshop_favorite
    get 'inscribirme/:id', to: 'workshops#toggle_workshop_schedule_subscribed', as: :authenticated_workshops_toggle_workshop_schedule_subscribed
  end



end
