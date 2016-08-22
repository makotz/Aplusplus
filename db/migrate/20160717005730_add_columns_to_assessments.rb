class AddColumnsToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :igot, :float
    add_column :assessments, :outof, :float
  end
end
