class AchievementsController < ApplicationController
  PER_PAGE = 10

  # /achievements             -> all categories
  # /achievements/sports      -> one category (same page, like DPS "Sports Achievements")
  def index
    @category = params[:category].presence_in(Achievement::CATEGORIES.map(&:last))
    @title    = @category ? Achievement.label_for(Achievement::CATEGORIES, @category) : "Achievements"

    scope = Achievement.active.left_outer_joins(:student)
                       .where("achievements.student_id IS NULL OR students.is_active = ?", true)
    scope = scope.where(category: @category) if @category

    @sessions = scope.distinct.order(academic_session: :desc).pluck(:academic_session).compact
    @session  = params[:session].presence_in(@sessions)
    scope = scope.where(academic_session: @session) if @session

    @achievements = scope.includes(:student, :images).recent.page(params[:page]).per(PER_PAGE)
  end

  def student
    @student = Student.active.find(params[:id])
    @achievements = @student.achievements.active.includes(:images).recent
  end
end
