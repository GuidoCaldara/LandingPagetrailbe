class Run < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :partecipants
  geocoded_by :starting_point
  after_validation :geocode, if: :will_save_change_to_starting_point?
  has_many :messages
  scope :organized_runs, -> (user) { user.organized_runs.where("date >= ?", Date.today).order(date: :asc) }
  scope :next_runs, -> (user) { user.runs.where("date >= ?", Date.today).order(date: :asc) }
  scope :runs, -> (user) { user.runs.order(date: :desc) }
end
