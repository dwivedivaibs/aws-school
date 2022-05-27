Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'welcome#index'
  get 'welcome/gallery'
  get 'welcome/about_us'
  get 'welcome/mission'
  get 'welcome/chairman_message'
  get 'welcome/principal_message'
  get 'welcome/mandatory_public_disclosure'
  get 'welcome/academic_calender'
  get 'welcome/three_year_results'
  get 'welcome/book_list'
  get 'welcome/committee'
  get 'welcome/committees'
  get 'welcome/pta'
  get 'welcome/faculty'
  get 'welcome/oasis_updated'
  get 'welcome/result_date_sheet'
  get 'welcome/admission_procedure'
  get 'welcome/public_disclosure'
  get 'welcome/deo_certificate'
  get 'welcome/prospectus'
  get 'welcome/noc'
  get 'welcome/recognition'
  get 'welcome/land_certificate'
  get 'welcome/society_certificate'
  get 'welcome/water_certificate'
  get 'welcome/affiliation_letter'
  get 'welcome/fire_safety'
  get 'welcome/building_safety_certificate'

  get 'welcome/fee_stracture'
  get 'welcome/norms_of_fixing_fee'
  get 'welcome/student_strength'
  get 'welcome/tc_entries'
  get 'welcome/activities_compatitions'
  get 'welcome/school_building'
  get 'welcome/transport_facilities'
  get 'welcome/class_room'
  get 'welcome/infirmary'
  get 'welcome/library'
  get 'welcome/laboratories'
  get 'welcome/photos'
  get 'welcome/videos'
  get 'welcome/contact_us'
  get 'welcome/feedback'

  resources :tc_entries do 
    collection do 
      get :tc
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
