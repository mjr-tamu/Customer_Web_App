# frozen_string_literal: true

class Calendar < ApplicationRecord
  has_many :signups, dependent: :destroy
  has_many :signed_up_users, through: :signups, source: :admin

  validates :title, presence: true
  validates :event_date, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: %w[Service Bush\ School Social] }
  validate :event_date_must_be_in_future

  private

  def event_date_must_be_in_future
    return unless event_date.present?

    # Allow same day events - only reject events in the past
    if event_date < Time.current
      errors.add(:event_date, "must be in the future")
    end
  end
end
