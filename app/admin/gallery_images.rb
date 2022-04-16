ActiveAdmin.register GalleryImage do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params  :section, :image, :is_active
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :image, :is_active]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  #index
  index do
    selectable_column
    id_column
    column :section
    column "Image" do |file|
      link_to file.image.url, file.image.url, target: "_blank"
    end
    column :is_active
    column :created_at
    column :updated_at
    actions
  end

  #form
  form do |f|
    f.inputs do
      f.input :section, :label => 'Select Section', :as => :select, :collection => GalleryImage::SECTION
      f.input :image
      f.input :is_active
      hr
      unless f.object.new_record? && !f.object.image.url.present?
        ol do
          li do
            tabs do
              tab "Image", html_options: { class: 'specific_css_class' } do
                link_to(f.object.image.url, target: "_blank") do
                  image_tag(f.object.image.url, height: "200", width: "250")
                end
              end
            end
          end
        end
      end
    end
    f.actions
  end
end
