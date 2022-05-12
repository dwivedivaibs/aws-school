class TcEntriesController < ApplicationController
  layout :resolve_layout

  def index
    @tc_entries = TcEntry.all
    if params[:query].present?
      @tc_entries = TcEntry.where("concat_ws(' ' , LOWER(tc_number), LOWER(student_name), LOWER(father_name), LOWER(mother_name)) LIKE ?", "%#{params[:query].downcase}%")
    end

  end

  def tc
    @tc_entry = TcEntry.first
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