class AddTypeColumnToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :type, :string
  end
end
