ActiveAdmin.register TcEntry do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :content_type, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :file, :is_active]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  #index
  # index do
  #   selectable_column
  #   id_column
  #   column "Contect Type", :content_type
  #   column :description
  #   column :created_at
  #   column :updated_at
  #   actions
  # end

  #form
  # form do |f|
  #   f.inputs do
  #     f.input :content_type, :label => 'Select Content Type', :as => :select, :collection => Content::CONTENT_TYPES
  #     f.input :description, as: :ckeditor, :input_html => { :class => "ckeditor" }
  #   end
  #   f.actions
  # end
end
