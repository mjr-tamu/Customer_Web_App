# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calendar, type: :model do
  # baseline valid attributes for convenience
  def valid_attrs(overrides = {})
    {
      title: 'Team Meeting',
      event_date: DateTime.new(2024, 12, 25, 14, 0, 0),
      description: 'Weekly team standup meeting',
      location: 'Conference Room A'
    }.merge(overrides)
  end

  # ---- Title tests ----
  describe 'title validation' do
    it 'is valid with a title (sunny day)' do
      calendar = Calendar.new(valid_attrs(title: 'Project Review'))
      expect(calendar).to be_valid
    end

    it 'is invalid without a title (rainy day)' do
      calendar = Calendar.new(valid_attrs(title: nil))
      calendar.validate
      expect(calendar.errors[:title]).to be_present
    end
  end
end

RSpec.describe Calendar, type: :model do
  # baseline valid attributes for convenience
  def valid_attrs(overrides = {})
    {
      title: 'Team Meeting',
      event_date: DateTime.new(2024, 12, 25, 14, 0, 0),
      description: 'Weekly team standup meeting',
      location: 'Conference Room A'
    }.merge(overrides)
  end

  # ---- Event date tests ----
  describe 'event_date validation' do
    it 'is valid with an event_date (sunny)' do
      calendar = Calendar.new(valid_attrs(event_date: DateTime.new(2024, 12, 25, 14, 0, 0)))
      expect(calendar).to be_valid
    end

    it 'is invalid without an event_date (rainy)' do
      calendar = Calendar.new(valid_attrs(event_date: nil))
      calendar.validate
      expect(calendar.errors[:event_date]).to be_present
    end
  end
end

RSpec.describe Calendar, type: :model do
  # baseline valid attributes for convenience
  def valid_attrs(overrides = {})
    {
      title: 'Team Meeting',
      event_date: DateTime.new(2024, 12, 25, 14, 0, 0),
      description: 'Weekly team standup meeting',
      location: 'Conference Room A'
    }.merge(overrides)
  end

  # ---- Description tests ----
  describe 'description validation' do
    it 'is valid with a description (sunny)' do
      calendar = Calendar.new(valid_attrs(description: 'Weekly team standup meeting'))
      expect(calendar).to be_valid
    end

    it 'is invalid without a description (rainy)' do
      calendar = Calendar.new(valid_attrs(description: nil))
      calendar.validate
      expect(calendar.errors[:description]).to be_present
    end
  end
end
