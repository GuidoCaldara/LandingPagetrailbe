class Run < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :partecipants, dependent: :destroy
  geocoded_by :starting_point
  after_validation :geocode, if: :will_save_change_to_starting_point?
  after_create :set_organizer_as_partecipant
  has_many :messages
  scope :organized_runs, -> (user) { user.organized_runs.where("date >= ?", Date.today).order(date: :asc) }
  scope :next_runs, -> (user) { user.runs.where("date >= ?", Date.today).order(date: :asc) }
  scope :runs, -> (user) { user.runs.order(date: :desc) }
  scope :filter_by_first_date, -> (date) { where("date > ?",  Date.parse((date).split[0])) }
  scope :filter_by_last_date, -> (date) { where("date < ?",  Date.parse((date).split[2])) }

  def set_organizer_as_partecipant
    Partecipant.create(user: self.user, run:self)
  end

end
