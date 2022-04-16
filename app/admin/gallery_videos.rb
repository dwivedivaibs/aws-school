ActiveAdmin.register GalleryVideo do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :video, :is_active
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :video, :is_active]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  #index
  index do
    selectable_column
    id_column
    column :title
    column :description do |video|
      if video.description && video.description.length > 50
        "#{video.description.first(50)}..."
      else
        video.description
      end
    end
    column "Video" do |file|
      link_to file.video.url, file.video.url, target: "_blank"
    end
    column :is_active
    column :created_at
    column :updated_at
    actions
  end

  #form
  form do |f|
    f.inputs do
      f.input :title
      f.input :description, as: :text
      f.input :video
      f.input :is_active
      hr
      unless f.object.new_record? && !f.object.video.url.present?
        ol do
          li do
            tabs do
              tab "Video", html_options: { class: 'specific_css_class' } do
                link_to(f.object.video.url, target: "_blank") do
                  video_tag(f.object.video.url, height: "200", width: "250", controls: true)
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
