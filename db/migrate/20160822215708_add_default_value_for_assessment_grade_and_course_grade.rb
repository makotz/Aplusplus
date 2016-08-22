class AddDefaultValueForAssessmentGradeAndCourseGrade < ActiveRecord::Migration
  def change
    change_column :courses, :grade, :float, :default => 50
    change_column :assessments, :grade, :float, :default => 0
  end
end
