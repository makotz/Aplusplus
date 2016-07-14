class AssessmentsController < ApplicationController
  before_action :authenticate_user!
  COLOUR = ["pink","lightblue","lightgreen","grey","orange"]

  def new
    @course = Course.find params[:course_id]
    @assessments = @course.assessments
    @assessment = Assessment.new
  end

  def create
    @assessment = Assessment.new assessment_params
    @assessment.course_id = params[:course_id]
    if @assessment.save
      NotiMailer.notify_user(@assessment).deliver_now
      redirect_to course_path(params[:course_id]), notice: "Assessment added!"
    else
      @course = @assessment.course
      render :new
    end
  end

  def index
    @courses = current_user.courses.all
    @assessments = []
    col = 0
    @courses.each do |course|
      course.assessments.each do |assessment|
        j_assessment = {"title" => assessment.course.title + " - " + assessment.title,
          "start" => assessment.due_date,
          "url" => course_path(course),
          "color" => COLOUR[col]}
        @assessments << j_assessment
      end
      col += 1
    end
    @assessments.flatten!
    render json: @assessments
  end

  def calendar
  end

  def edit
    @assessment = Assessment.find params[:id]
    @course = @assessment.course
  end

  def update
    @assessment = Assessment.find params[:id]
    respond_to do |format|

    if @assessment.update assessment_params
      format.html { redirect_to course_path(params[:course_id]), notice: "Grade updated!" }
      format.js   { render :update_success }
    else
      format.html { redirect_to course_path(params[:course_id]), alert: "Unsuccessful" }
      format.js   { render :update_failure }
    end
    end
  end

  def destroy
    course = Course.find params[:course_id]
    assessment = Assessment.find params[:id]
    assessment.destroy
    redirect_to course_path(course), notice: "Assessment deleted"
  end

  private

    def assessment_params
      params.require(:assessment).permit(:title, :description, :due_date, :weight, :grade)
    end

end
