class AssessmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :assessment_type, only: [:new, :edit]
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
    if assessment_params.key?("grade")
      @assessment.update assessment_params
      redirect_to course_path(params[:course_id]), notice: "Grade updated!"
    else
      @assessment.update assessment_params
      lazygrade(@assessment)
      redirect_to course_path(params[:course_id]), notice: "Grade updated manually!"
    end
  end


  def destroy
    course = Course.find params[:course_id]
    assessment = Assessment.find params[:id]
    assessment.destroy
    redirect_to course_path(course), notice: "Assessment deleted"
  end

  def important
    @assessment = Assessment.find params[:id]
    course = Course.find params[:course_id]
    if @assessment.important?
      @assessment.update(important: false)
    else
      @assessment.update(important: true)
    end
    redirect_to course_path(course)
  end

  private

    def assessment_params
      params.require(:assessment).permit(:title, :description, :due_date, :weight, :grade, :assessment_type, :igot, :outof)
    end

    def assessment_type
      @assessment_type = ['test', 'quiz', 'exam', 'homework', 'essay']
    end

    def lazygrade(assessment)
        assessment.grade = (assessment.igot / assessment.outof)*100
        assessment.update assessment_params
    end

end
