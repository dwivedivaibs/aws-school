ActiveAdmin.register SummerHomework do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :class_name, :homework_doc
  #
  # or
  #
  # permit_params do
  #   permitted = [:class_name, :homework_doc]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column "Class Name", :class_name
    column "Homework Document" do |file|
      link_to file.homework_doc.url, file.homework_doc.url, target: "_blank"
    end
    column :created_at
    column :updated_at
    actions
  end


  form do |f|
    f.inputs do
      f.input :class_name, :label => 'Select Class Name', :as => :select, :collection => SummerHomework::CLASS_NAME
      f.input :homework_doc, as: :file
      unless f.object.new_record? && !f.object&.homework_doc&.url.present?
        ol do
          li do
            tabs do
              tab "Document", html_options: { class: 'specific_css_class' } do
                link_to(f.object.homework_doc.url, f.object.homework_doc.url, target: "_blank")
              end
            end
          end
        end
      end
    end
    f.actions
  end
  
end
