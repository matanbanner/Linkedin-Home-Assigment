Rails.application.routes.draw do

  root to: 'profiles#search'

  resources :profiles do
    collection do
      get 'import'
      get 'search'


      get 'import_profile'
      get 'search_by_skills'
      get 'search_by_attrs'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
