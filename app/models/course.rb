class Course < ActiveRecord::Base
  belongs_to :user

  has_many :assessments, dependent: :destroy

  validates :title, presence: true
  validates :credit, presence: true, numericality: { only_integer: true }
  validates :term, presence: true


  def terms
    @terms = ['Fall 2016', 'Spring 2017']
  end

  def upcoming_assessments
    @priorities = {}
  end


end
