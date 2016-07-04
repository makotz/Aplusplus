class AddGradeAndDesiredGradeColumnToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :grade, :float
    add_column :courses, :desired_grade, :float
  end
end
