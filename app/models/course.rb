class Course < ActiveRecord::Base
  belongs_to :user

  has_many :assessments, dependent: :destroy

  validates :title, presence: true
  validates :credit, presence: true, numericality: { only_integer: true }
  validates :term, presence: true

  # before_create :course_color

  def terms
    @terms = ['Fall 2016', 'Spring 2017']
  end

  def upcoming_assessments
    @priorities = {}
  end

  private

  # def course_color
  #   loop do
  #     self.color = Faker::Color.color_name
  #     break unless Course.exists?(color: color)
  #   end
  # end

end
