class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  mount_uploader :avatar, AvatarUploader
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  extend FriendlyId
  friendly_id :username, use: :slugged
  has_many :organized_runs, class_name:"Run", foreign_key: 'user_id'
  has_many :partecipants
  has_many :runs, through: :partecipants
  validates :username, presence: true, on: :update
  validates :location, presence: true, on: :update
  validates :description, presence: true, on: :update

  def is_partecipant?(run)
    run.partecipants.where(user: self).any?
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:first_name] = auth.info.first_name
    user_params[:last_name] = auth.info.last_name
    user_params[:email] = auth.info.email
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end
    return user
  end

  def avatar_pic
    self.avatar.url(:avatar) ||self.facebook_picture_url ||  "https://picsum.photos/200/300
"
  end

end
