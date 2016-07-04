class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.float :weight
      t.float :grade
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
