# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Test Environment Display', type: :system do
  before(:all) do
    # Ensure test database is clean and seeded
    Rails.env = 'test'
    Book.destroy_all
    Author.destroy_all
    load Rails.root.join('db/seeds.rb')
  end

  it 'seeds test environment and opens Chrome browser to display it' do
    puts "\n#{'=' * 80}"
    puts '🚀 SEEDING TEST ENVIRONMENT AND OPENING CHROME BROWSER'
    puts '=' * 80
    puts 'The test environment has been seeded with classic literature books:'
    puts '- To Kill a Mockingbird by Harper Lee'
    puts '- The Great Gatsby by F. Scott Fitzgerald'
    puts '- The Old Man and the Sea by Ernest Hemingway'
    puts '- Pride and Prejudice by Jane Austen'
    puts '- The Adventures of Huckleberry Finn by Mark Twain'
    puts '=' * 80

    # Visit the home page
    visit root_path

    # Wait for the page to load
    expect(page).to have_content('Book Collection')

    # Verify we can see the seeded test data (classic literature books)
    expect(page).to have_content('To Kill a Mockingbird')
    expect(page).to have_content('Harper Lee')
    expect(page).to have_content('The Great Gatsby')
    expect(page).to have_content('F. Scott Fitzgerald')
    expect(page).to have_content('The Old Man and the Sea')
    expect(page).to have_content('Ernest Hemingway')
    expect(page).to have_content('Pride and Prejudice')
    expect(page).to have_content('Jane Austen')
    expect(page).to have_content('The Adventures of Huckleberry Finn')
    expect(page).to have_content('Mark Twain')

    # Verify we have 5 books displayed (excluding the "Add Book" row)
    within('table.styled-table tbody') do
      book_rows = page.all('tr').select { |row| row.text.include?('Show Details') }
      expect(book_rows.count).to eq(5)
    end

    # Verify the table structure
    expect(page).to have_css('table.styled-table')
    expect(page).to have_css('thead tr th', text: 'Book ID')
    expect(page).to have_css('thead tr th', text: 'Book Title')
    expect(page).to have_css('thead tr th', text: 'Book Author')
    expect(page).to have_css('thead tr th', text: 'Book Price')
    expect(page).to have_css('thead tr th', text: 'Published Date')

    # Verify we can see the "Add Book" button
    expect(page).to have_link('Add Book', href: new_book_path)

    puts "\n✅ TEST ENVIRONMENT SUCCESSFULLY SEEDED AND VERIFIED!"
    puts '🌐 Now opening Chrome browser to display the seeded test environment...'

    # Start Rails server in test environment in the background
    server_pid = Process.spawn('RAILS_ENV=test bundle exec rails server -p 3000')

    # Wait for server to start
    sleep(3)

    # Open Chrome browser
    system("open -a 'Google Chrome' http://localhost:3000")

    puts '📱 Chrome browser should now be open showing the seeded test environment!'
    puts '⏱️  Server will run for 15 seconds, then automatically stop...'

    # Keep server running for 15 seconds so you can see the results
    sleep(15)

    # Stop the server
    Process.kill('TERM', server_pid)
    Process.wait(server_pid)

    puts "\n✅ Test completed! Chrome browser should still be open showing the seeded test environment."
    puts '🛑 Rails server has been stopped.'
  end
end
