ActiveAdmin.register Student do
  menu label: "Students (Achievements)", priority: 5

  permit_params :name, :admission_no, :student_class, :section, :house, :photo,
                :is_alumni, :passing_year, :bio, :is_active,
                achievements_attributes: [:id, :title, :category, :level, :position, :score,
                                          :event_date, :academic_session, :description,
                                          :certificate, :event_photo, :is_featured, :is_active, :_destroy]

  filter :name
  filter :admission_no
  filter :student_class, as: :select, collection: Student::CLASSES
  filter :section
  filter :house, as: :select, collection: Student::HOUSES
  filter :is_alumni
  filter :is_active

  index do
    selectable_column
    id_column
    column "Photo" do |s|
      s.photo.url.present? ? image_tag(s.photo.url, height: 50, width: 50, style: "object-fit:cover;border-radius:50%") : "-"
    end
    column :name
    column :admission_no
    column "Class", &:class_label
    column :house
    column "Achievements" do |s|
      link_to s.achievements.count, admin_achievements_path(q: { student_id_eq: s.id })
    end
    column :is_active
    actions
  end

  show do
    attributes_table do
      row :photo do |s|
        image_tag(s.photo.url, height: 150) if s.photo.url.present?
      end
      row :name
      row :admission_no
      row("Class") { |s| s.class_label }
      row :house
      row :passing_year
      row :bio
      row :is_active
      row("Public page") { |s| link_to "Open", achievement_student_path(s), target: "_blank" }
    end

    panel "Achievements" do
      table_for student.achievements.recent do
        column :title
        column("Category") { |a| a.category_label }
        column("Level") { |a| a.level_label }
        column("Position") { |a| a.position_label }
        column :score
        column :event_date
        column :academic_session
        column :is_featured
        column :is_active
        column("") { |a| link_to "Edit", edit_admin_achievement_path(a) }
      end
      div { link_to "+ Add achievement for this student", new_admin_achievement_path(achievement: { student_id: student.id }) }
    end
  end

  form html: { multipart: true } do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs "Student Details" do
      f.input :name
      f.input :admission_no
      f.input :student_class, as: :select, collection: Student::CLASSES, label: "Class"
      f.input :section
      f.input :house, as: :select, collection: Student::HOUSES
      f.input :photo, as: :file, hint: (f.object.photo.url.present? ? image_tag(f.object.photo.url, height: 100) : "JPG / PNG, square photo works best")
      f.input :is_alumni, label: "Alumni (passed out)"
      f.input :passing_year, hint: "Only for alumni, e.g. 2024"
      f.input :bio, input_html: { rows: 3 }, hint: "Optional short line shown on the student's page"
      f.input :is_active
    end

    f.inputs "Achievements" do
      f.has_many :achievements, heading: false, allow_destroy: true, new_record: "Add Achievement" do |a|
        a.input :title
        a.input :category, as: :select, collection: Achievement::CATEGORIES
        a.input :level, as: :select, collection: Achievement::LEVELS
        a.input :position, as: :select, collection: Achievement::POSITIONS
        a.input :score, hint: "e.g. 98.6% (for board results)"
        a.input :event_date, as: :datepicker
        a.input :academic_session, hint: "Leave blank to auto-fill from event date, e.g. 2026-27"
        a.input :description, as: :quill_editor
        a.input :certificate, as: :file, hint: "Image or PDF"
        a.input :event_photo, as: :file, label: "Main photo", hint: "Add more photos later from the Achievements menu"
        a.input :is_featured
        a.input :is_active
      end
    end
    f.actions
  end
end
