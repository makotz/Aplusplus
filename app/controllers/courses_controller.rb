class CoursesController < ApplicationController
before_action :authenticate_user!, except: [:home]
before_action :current_user, only: [:create, :index]
helper_method :sort_column, :sort_direction, :current_grade

  def home
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    @course.user = @current_user
    if @course.save
      redirect_to(new_course_assessment_path(@course))
    else
      render :new, alert: "Course cannot be created!"
    end
  end

  def index
    @courses = @current_user.courses.order(sort_column + " " + sort_direction)
  end

  def show
    @course = Course.find params[:id]
    @assessments = @course.assessments.order(sort_column + " " + sort_direction)
    current_grade(@course)
  end

  private

  def order_by(category)
  end

  def current_grade(course)
    @current_grade = 0
    course.assessments.each do |assessment|
      @current_grade += (assessment.grade * (assessment.weight/100))
    end
    course.grade = @current_grade
  end

  def course_params
      params.require(:course).permit(:title, :instructor, :credit, :desired_grade)
  end

  def sort_column
    Assessment.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
