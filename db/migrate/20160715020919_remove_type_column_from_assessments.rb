class RemoveTypeColumnFromAssessments < ActiveRecord::Migration
  def change
    remove_column :assessments, :type, :string
    add_column :assessments, :assessment_type, :string
  end
end
