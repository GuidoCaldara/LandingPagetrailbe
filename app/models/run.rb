class Run < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :partecipants, dependent: :destroy
  geocoded_by :starting_point
  after_validation :geocode, if: :will_save_change_to_starting_point?
  after_create :set_organizer_as_partecipant
  has_many :messages

  validates :name, presence: true,  length: { minimum: 4, maximum: 100 }
  validates :name, presence: true,  length: { minimum: 4, maximum: 100 }
  validates :date, presence: true
  validate :run_in_the_future
  validates :starting_point, presence: true
  validates :starting_point_info, length: { maximum: 200 }
  validates :run_distance,  numericality: { only_integer: true, min: 1, max: 100}
  validates :elevation,  numericality: { only_integer: true, min: 0, max: 10000}
  validates :duration, presence: true
  validates :description,  length: { minimum: 10, maximum: 600 }
  validate :check_duration

  before_save :check_the_coordinates


  scope :organized_runs, -> (user) { user.organized_runs.where("date >= ?", Date.today).order(date: :asc) }
  scope :next_runs, -> (user) { user.runs.where("date >= ?", Date.today).order(date: :asc) }
  scope :runs, -> (user) { user.runs.order(date: :desc) }
  scope :filter_by_first_date, -> (date) { where("date > ?",  Date.parse((date).split[0])) }
  scope :filter_by_last_date, -> (date) { where("date < ?",  Date.parse((date).split[2])) }

  def set_organizer_as_partecipant
    Partecipant.create(user: self.user, run:self)
  end

  def run_in_the_future
    if date.present? && date < Date.today
      errors.add(:date, "Inserisci una data futura")
    end
  end

  def check_the_coordinates
    if starting_point.present? && (self.latitude.nil? || self.longitude.nil? )
      errors.add(:starting_point, "Inserisci un idirizzo esistente")
    end
  end

  def check_duration
    if duration.present? && (self.duration.hour == 0 && self.duration.min == 0 )
      errors.add(:duration, "Inserisci una durata per l'allenamento")
    end

  end


  def run_pic
    self.photo.url(:small) || "https://res.cloudinary.com/run-db/image/upload/v1554278460/nngfmvfdnhuwlncfg4gx.jpg"
  end

end
