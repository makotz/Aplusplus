class AddImportantColumnToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :important, :boolean, default: false
  end
end
