class TcEntriesController < ApplicationController
  layout :resolve_layout

  def index
    @tc_entries = TcEntry.all
    if params[:query].present?
      @tc_entries = TcEntry.where("concat_ws(' ' , LOWER(tc_number), LOWER(student_name), LOWER(father_name), LOWER(mother_name)) LIKE ?", "%#{params[:query].downcase}%")
    end

  end

  def tc
    @tc_entry = TcEntry.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def show
    @tc_entry = TcEntry.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def upload
    file = params[:file]
    if file
      # Parse the Excel file
      excel = Roo::Spreadsheet.open(file)
      excel.default_sheet = excel.sheets.first

      # Assuming the first row contains headers
      headers = excel.row(1)

      # Iterate over each row (excluding header)
      (2..excel.last_row).each do |i|
        row = Hash[[headers, excel.row(i)].transpose]

        # Create or update tc_entry record
        tc_entry = TcEntry.find_or_initialize_by(tc_number: row['tc_number'])
        tc_entry.attributes = row
        tc_entry.save
      end

      flash[:success] = 'File uploaded successfully.'
    else
      flash[:error] = 'Please select a file to upload.'
    end

    redirect_to root_path
  end

  private

  def resolve_layout
    case action_name
    when "show"
      "pdf"
    else
      "application"
    end
  end
end