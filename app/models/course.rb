class Course < ActiveRecord::Base
  belongs_to :user

  has_many :assessments, dependent: :destroy

  validates :title, presence: true
  validates :credit, presence: true, numericality: { only_integer: true }
  validates :term, presence: true

end
