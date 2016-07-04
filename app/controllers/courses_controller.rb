class CoursesController < ApplicationController
before_action :authenticate_user!, except: [:home]
before_action :current_user, only: [:create, :index]

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
    @courses = @current_user.courses
  end

  def show
    @course = Course.find params[:id]
    @assessments = @course.assessments
  end


  private

  def course_params
      params.require(:course).permit(:title, :instructor, :credit, :desired_grade)
  end

end
