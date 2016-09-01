class DeleteDesiredGradeColumnFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :desired_grade
  end
end
