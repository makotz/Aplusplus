class Assessment < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :title, presence: true, uniqueness: true
end
