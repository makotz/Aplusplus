class CoursesController < ApplicationController
before_action :authenticate_user!, except: [:home]
before_action :current_user, only: [:create, :index]
helper_method :sort_column, :sort_direction, :current_grade

  def home
    @assessments = Assessment.where(:due_date => Time.now-1.days..Time.now+7.days).order(:due_date).order(weight: :desc)
    assessment_type
    @assessment = Assessment.new
  end

  def new
    @course = Course.new
    terms
  end

  def create
    @course = Course.new course_params
    @course.color = "red"
    @course.user = @current_user
    current_grade(@course) if @course.assessments.exists?
    if @course.save
      redirect_to course_path(@course), notice: "Course: #{@course.title} has been created!"
    else
      render :new, alert: "Course cannot be created!"
    end
  end

  def index
    @courses = @current_user.courses.order(sort_column + " " + sort_direction)
  end

  def show
    @course = Course.find params[:id]
    @imp_assessments = @course.assessments.where(important: true).order(sort_column + " " + sort_direction)
    @assessments = @course.assessments.where(important: false).order(sort_column + " " + sort_direction)
    current_grade(@course) if @course.assessments.exists?
    @course.save
  end

  def update
    @course = Course.find params[:id]
    if @course.update course_params
      redirect_to courses_path, notice: "Update successful!"
    end
  end

  def destroy
    @course = Course.find params[:id]
    @course.destroy
    redirect_to courses_path, notice: "Course deleted"
  end

  private

  def current_grade(course)
    current_grade = total_weight = total_score = 0
    course.assessments.each do |assessment|
      if assessment.grade != nil && assessment.weight != nil
        total_score += (assessment.grade/100)*(assessment.weight)
        total_weight += (assessment.weight)
      end
    end
    current_grade = (total_score/total_weight)*100 if total_weight != 0
    course.grade = current_grade.round(1)
  end

  def course_params
      params.require(:course).permit(:title, :instructor, :credit, :desired_grade, :term)
  end

  def sort_column
    Assessment.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def terms
    @terms = ['Fall 2016', 'Spring 2017', 'Winter 2016/2017']
  end

end
