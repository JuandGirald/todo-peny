class Task < ApplicationRecord
  enum status: {
    open: 0,
    completed: 1,
    archived: 2
  }

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
