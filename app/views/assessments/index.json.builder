json.array!(@assessments) do |assessment|
  json.extract! assessment, :id, :title, :description, :due_date, :course_id
  json.url assessment_url(assessment, format: :json)
end
