ActiveAdmin.register Document do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :file, :is_active
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :file, :is_active]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  #index
  index do
    selectable_column
    id_column
    column "Document Type", :name
    column "File" do |file|
      link_to file.file.url, file.file.url, target: "_blank"
    end
    column :is_active
    column :created_at
    column :updated_at
    actions
  end

  #form
  form do |f|
    f.inputs do
      f.input :name, :label => 'Select Document Type', :as => :select, :collection => Document::DOCUMENT_TYPES
      f.input :file
      f.input :is_active
      unless f.object.new_record? && !f.object.file.url.present?
        ol do
          li do
            tabs do
              tab "Document", html_options: { class: 'specific_css_class' } do
                link_to(f.object.file.url, f.object.file.url, target: "_blank")
              end
            end
          end
        end
      end
    end
    f.actions
  end
end
