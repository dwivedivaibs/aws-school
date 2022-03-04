Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/gallery'
  get 'welcome/about_us'
  get 'welcome/mission'
  get 'welcome/chairman_message'
  get 'welcome/principal_message'
  get 'welcome/mandatory_public_disclosure'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
