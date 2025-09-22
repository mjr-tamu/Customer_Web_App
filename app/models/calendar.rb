# frozen_string_literal: true

class Calendar < ApplicationRecord
  validates :title, presence: true
  validates :event_date, presence: true
  validates :description, presence: true
end
