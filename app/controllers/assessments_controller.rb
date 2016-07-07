class AssessmentsController < ApplicationController
  before_action :authenticate_user!

    def new
      @course = Course.find params[:course_id]
      @assessments = @course.assessments
      @assessment = Assessment.new
    end

    def create
      @assessment = Assessment.new assessment_params
      @assessment.course_id = params[:course_id]
      if @assessment.save
        redirect_to course_path(params[:course_id]), notice: "Assessment added!"
      end
    end

    def index
      @courses = current_user.courses.all
      @assessments = []
      @courses.each do |course|
        course.assessments.each do |assessment|
          j_assessment = {"title" => assessment.course.title + " - " + assessment.title, "start" => assessment.due_date}
          @assessments << j_assessment
        end
      end
      @assessments.flatten!
      render json: @assessments
    end

    def edit
      @assessment = Assessment.find params[:id]
    end

    def update
      @assessment = Assessment.find params[:id]
      if @assessment.update assessment_params
        redirect_to course_path(params[:course_id]), notice: "Grade updated!"
      end
    end

    private

    def assessment_params
      params.require(:assessment).permit(:title, :description, :due_date, :weight, :grade)
    end

end
