ActiveAdmin.register TcEntry do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :tc_number, :student_name, :father_name, :mother_name, :nationality, :sc_st_obc, :dob, :result, :subjects, :last_class, :last_class_result, :qualified_for_promotion, :dues_paid, :ncc_cadets, :last_day_school, :leaving_reason, :total_meeting_attendance, :total_attendance, :general_conduct, :category, :certificate_issue_date, :file

  #

  collection_action :upload, method: :post do
    file = params[:file][:file]
    if file
      # Parse the Excel file
      excel = Roo::Spreadsheet.open(file.tempfile)
      excel.default_sheet = excel.sheets.first

      # Assuming the first row contains headers
      headers = excel.row(1).map { |e| e.parameterize(separator: '_')  }

      # Iterate over each row (excluding header)
      (2..excel.last_row).each do |i|
        row = Hash[[headers, excel.row(i)].transpose]
        tc_entry = TcEntry.find_or_initialize_by(tc_number: row['tc_number'])
        tc_entry.attributes = row
        tc_entry.save
      end

      flash[:success] = 'File uploaded successfully.'
    else
      flash[:error] = 'Please select a file to upload.'
    end

    redirect_to admin_tc_entries_path
  end


  action_item :upload_file, only: :index do
    link_to 'Upload File', action: :new_upload
  end

  collection_action :new_upload, method: :get do
    render '/admin/tc_entries/new_upload'
  end



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
  form do |f|
    f.inputs "Student Details" do
      f.input :tc_number
      f.input :student_name
      f.input :father_name
      f.input :mother_name
      f.input :nationality
      f.input :sc_st_obc
      f.input :dob, as: :date_select, start_year: 1900, end_year: Date.today.year
      f.input :result
      f.input :subjects
      f.input :last_class
      f.input :last_class_result
      f.input :qualified_for_promotion
      f.input :dues_paid
      f.input :ncc_cadets
      f.input :last_day_school
      f.input :leaving_reason
      f.input :total_meeting_attendance
      f.input :total_attendance
      f.input :general_conduct
      f.input :category
      f.input :certificate_issue_date, as: :date_select, start_year: 1900, end_year: Date.today.year
      f.input :file, as: :file
    end
    f.actions
  end
end
