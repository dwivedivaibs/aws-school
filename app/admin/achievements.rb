ActiveAdmin.register Achievement do
  menu priority: 6

  permit_params :student_id, :team_name, :title, :category, :level, :position, :score,
                :event_date, :academic_session, :description, :certificate, :event_photo,
                :is_featured, :is_active,
                images_attributes: [:id, :image, :position, :_destroy]

  includes :student

  config.sort_order = 'event_date_desc'

  filter :student, collection: -> { Student.order(:name).map { |s| [s.display_name, s.id] } }
  filter :title
  filter :team_name
  filter :category, as: :select, collection: Achievement::CATEGORIES
  filter :level, as: :select, collection: Achievement::LEVELS
  filter :position, as: :select, collection: Achievement::POSITIONS
  filter :academic_session
  filter :event_date
  filter :is_featured
  filter :is_active

  batch_action :mark_featured do |ids|
    batch_action_collection.find(ids).each { |a| a.update(is_featured: true) }
    redirect_to collection_path, notice: "Marked as featured."
  end

  batch_action :unmark_featured do |ids|
    batch_action_collection.find(ids).each { |a| a.update(is_featured: false) }
    redirect_to collection_path, notice: "Removed from featured."
  end

  batch_action :deactivate do |ids|
    batch_action_collection.find(ids).each { |a| a.update(is_active: false) }
    redirect_to collection_path, notice: "Deactivated."
  end

  index do
    selectable_column
    id_column
    column("Achiever") do |a|
      a.student ? link_to(a.student.name, admin_student_path(a.student)) : "#{a.team_name} (Team)"
    end
    column :title
    column("Category") { |a| a.category_label }
    column("Level") { |a| a.level_label }
    column("Position") { |a| a.position_label }
    column :score
    column :event_date
    column :academic_session
    column :is_featured
    column :is_active
    actions
  end

  show do
    attributes_table do
      row("Achiever") { |a| a.student ? link_to(a.student.display_name, admin_student_path(a.student)) : "#{a.team_name} (Team)" }
      row :title
      row("Category") { |a| a.category_label }
      row("Level") { |a| a.level_label }
      row("Position") { |a| a.position_label }
      row :score
      row :event_date
      row :academic_session
      row(:description) { |a| a.description.present? ? sanitize(a.description) : "-" }
      row :certificate do |a|
        if a.certificate.url.present?
          a.certificate.image? ? image_tag(a.certificate.url, height: 200) : link_to("Open certificate", a.certificate.url, target: "_blank")
        end
      end
      row :event_photo do |a|
        image_tag(a.event_photo.url, height: 200) if a.event_photo.url.present?
      end
      row("Gallery") do |a|
        a.images.map { |i| image_tag(i.image.url, height: 120, style: "margin-right:8px") }.join.html_safe
      end
      row :is_featured
      row :is_active
      row("Public page") { |a| link_to "Open", category_achievements_path(a.category, anchor: "achievement-#{a.id}"), target: "_blank" }
    end
  end

  form html: { multipart: true } do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs "Achiever" do
      f.input :student, collection: Student.active.order(:name).map { |s| [s.display_name, s.id] },
                        include_blank: "-- Team / group achievement --",
                        hint: "Student not in the list? #{link_to 'Add a new student', new_admin_student_path, target: '_blank'} first.".html_safe
      f.input :team_name, hint: "For team / group achievements, e.g. \"U-14 Football Team\". Leave both blank for school-level news like board results."
    end
    f.inputs "Achievement" do
      f.input :title, hint: "Heading shown in bold, e.g. Khelo MP Swimming Competition"
      f.input :category, as: :select, collection: Achievement::CATEGORIES
      f.input :level, as: :select, collection: Achievement::LEVELS
      f.input :position, as: :select, collection: Achievement::POSITIONS
      f.input :score, hint: "e.g. 98.6% (for board results)"
      f.input :event_date, as: :datepicker
      f.input :academic_session, hint: "Leave blank to auto-fill from event date, e.g. 2026-27"
      f.input :description, as: :quill_editor, hint: "The write-up shown on the website. If left empty, a one-line congratulation message is generated."
      f.input :certificate, as: :file, hint: (f.object.certificate.url.present? ? link_to("Current certificate", f.object.certificate.url, target: "_blank") : "Image or PDF")
      f.input :event_photo, as: :file, label: "Main photo", hint: (f.object.event_photo.url.present? ? image_tag(f.object.event_photo.url, height: 100) : "Shown next to the write-up")
    end
    f.inputs "More photos (shown as a slider with the main photo)" do
      f.has_many :images, heading: false, allow_destroy: true, sortable: :position, new_record: "Add Photo" do |i|
        i.input :image, as: :file, hint: (i.object.image.url.present? ? image_tag(i.object.image.url, height: 80) : "")
      end
    end
    f.inputs "Visibility" do
      f.input :is_featured, hint: "Featured achievements appear in the highlight strip at the top of the page"
      f.input :is_active
    end
    f.actions
  end
end
