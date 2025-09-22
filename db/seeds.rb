# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development?
  # DEVELOPMENT ENVIRONMENT - Sample Calendar Events
  puts 'Seeding development environment with sample calendar events...'

  # Create calendar events for development
  Calendar.find_or_create_by!(title: 'Team Meeting') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 23, 14, 0, 0)
    calendar.description = 'Weekly team standup meeting to discuss project progress and upcoming deadlines'
    calendar.location = 'Conference Room A'
  end

  Calendar.find_or_create_by!(title: 'Project Deadline') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 25, 17, 0, 0)
    calendar.description = 'Final submission deadline for the customer web app project'
    calendar.location = 'Online'
  end

  Calendar.find_or_create_by!(title: 'Code Review') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 26, 10, 30, 0)
    calendar.description = 'Review calendar functionality implementation and provide feedback'
    calendar.location = 'Office - Room 301'
  end

  Calendar.find_or_create_by!(title: 'Client Presentation') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 27, 15, 0, 0)
    calendar.description = 'Present the new calendar application to stakeholders'
    calendar.location = 'Main Conference Room'
  end

  Calendar.find_or_create_by!(title: 'Holiday Break') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 30, 9, 0, 0)
    calendar.description = 'Company holiday break - office closed'
    calendar.location = 'Office'
  end

  puts 'Development data created successfully! (5 sample calendar events)'

elsif Rails.env.test?
  # TEST ENVIRONMENT - Test Calendar Events
  puts 'Seeding test environment with test calendar events...'

  # Create calendar events for test
  Calendar.find_or_create_by!(title: 'Test Meeting') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 20, 9, 0, 0)
    calendar.description = 'Test event for automated testing'
    calendar.location = 'Test Room'
  end

  Calendar.find_or_create_by!(title: 'Unit Tests') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 21, 14, 0, 0)
    calendar.description = 'Run unit tests for calendar model'
    calendar.location = 'Development Environment'
  end

  puts 'Test data created successfully! (2 test calendar events)'

else
  # PRODUCTION ENVIRONMENT - Production Calendar Events
  puts 'Seeding production environment with production calendar events...'

  # Create calendar events for production
  Calendar.find_or_create_by!(title: 'Production Deployment') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 28, 20, 0, 0)
    calendar.description = 'Deploy calendar application to production environment'
    calendar.location = 'Production Server'
  end

  Calendar.find_or_create_by!(title: 'Monitoring Setup') do |calendar|
    calendar.event_date = DateTime.new(2024, 12, 29, 11, 0, 0)
    calendar.description = 'Configure monitoring and logging for production calendar app'
    calendar.location = 'Server Room'
  end

  puts 'Production data created successfully! (2 production calendar events)'
end
