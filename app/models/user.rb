class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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

  
end
