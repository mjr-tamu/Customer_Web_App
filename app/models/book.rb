# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author, optional: true
  validates :title, presence: true
  validates :price, numericality: true, presence: true
  validates :publish_date, presence: true
end
