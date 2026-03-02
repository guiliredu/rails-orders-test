class Order < ApplicationRecord
  enum :state, {
    pending: 0,
    in_progress: 1,
    completed: 2
  }

  validates :control_number, presence: true, uniqueness: true
  validates :state, presence: true
  validates :title, presence: true

  before_validation :set_default_state, on: :create
  validate :valid_state_transition, if: :will_save_change_to_state?

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

  def valid_state_transition
    return if new_record?

    transitions = {
      "pending" => ["in_progress"],
      "in_progress" => ["completed"],
      "completed" => []
    }

    previous_state = state_was

    unless transitions[previous_state]&.include?(state)
      errors.add(:state, "invalid transition from #{previous_state} to #{state}")
    end
  end
end