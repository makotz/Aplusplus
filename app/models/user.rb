class User < ActiveRecord::Base
  has_secure_password

  has_many :courses, dependent: :destroy
  has_many :assessments, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A[\w+\-.?]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name.titleize} #{last_name.titleize}"
  end

  def self.find_or_create_from_facebook(facebook_data)
    user = User.where(uid: facebook_data["uid"], provider: facebook_data["provider"] ).first
    user = create_from_facebook(facebook_data) unless user
    user
  end

  def self.create_from_facebook(facebook_data)
    user = User.new
    full_name = facebook_data["info"]["name"].split(" ")
    user.first_name = full_name.first
    user.last_name = full_name.last
    user.email = facebook_data["info"]["email"]
    user.profile_image = facebook_data["info"]["image"]
    user.uid = facebook_data["uid"]
    user.provider = facebook_data["provider"]
    user.facebook_token = facebook_data["credentials"]["token"]
    user.facebook_expires_at = facebook_data["credentials"]["expires_at"]
    user.facebook_raw_data = facebook_data
    user.password = SecureRandom.urlsafe_base64
    user.save!
    user
  end

end
