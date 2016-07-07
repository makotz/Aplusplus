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
    @course = @assessment.course
    @assessment.destroy
    redirect_to course_path(@course), notice: "Assessment deleted"
  end

  private

  def assessment_params
    params.require(:assessment).permit(:title, :description, :due_date, :weight, :grade)
  end

end
