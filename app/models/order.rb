class Order < ApplicationRecord
  enum :state, {
    pending: 0,
    in_progress: 1,
    completed: 2
  }

  validates :control_number, presence: true, uniqueness: true

  before_validation :set_default_state, on: :create

  def start_progress!
    raise "Invalid transition" unless pending?
    update!(state: :in_progress)
  end

  def complete!
    raise "Invalid transition" unless in_progress?
    update!(state: :completed)
  end

  private

  def set_default_state
    self.state ||= :pending
  end
end