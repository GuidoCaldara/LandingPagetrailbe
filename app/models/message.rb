class Message < ApplicationRecord
  belongs_to :user
  belongs_to :run

  def modified?
    self.created_at != self.updated_at
  end
end
