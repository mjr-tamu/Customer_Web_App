# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development?
  # DEVELOPMENT ENVIRONMENT - 5 Fantasy/Sci-Fi Books
  puts 'Seeding development environment with fantasy/sci-fi books...'

  # Create authors for development
  author1 = Author.find_or_create_by!(author_name: 'J.K. Rowling')
  author2 = Author.find_or_create_by!(author_name: 'George Orwell')
  author3 = Author.find_or_create_by!(author_name: 'Isaac Asimov')
  author4 = Author.find_or_create_by!(author_name: 'J.R.R. Tolkien')
  author5 = Author.find_or_create_by!(author_name: 'Frank Herbert')

  # Create books for development
  Book.find_or_create_by!(title: "Harry Potter and the Philosopher's Stone") do |book|
    book.author_id = author1.id
    book.price = 12.99
    book.publish_date = Date.new(1997, 6, 26)
  end

  Book.find_or_create_by!(title: '1984') do |book|
    book.author_id = author2.id
    book.price = 10.99
    book.publish_date = Date.new(1949, 6, 8)
  end

  Book.find_or_create_by!(title: 'Foundation') do |book|
    book.author_id = author3.id
    book.price = 13.99
    book.publish_date = Date.new(1951, 5, 1)
  end

  Book.find_or_create_by!(title: 'The Lord of the Rings') do |book|
    book.author_id = author4.id
    book.price = 15.99
    book.publish_date = Date.new(1954, 7, 29)
  end

  Book.find_or_create_by!(title: 'Dune') do |book|
    book.author_id = author5.id
    book.price = 14.99
    book.publish_date = Date.new(1965, 8, 1)
  end

  puts 'Development data created successfully! (5 fantasy/sci-fi books)'

elsif Rails.env.test?
  # TEST ENVIRONMENT - 5 Classic Literature Books
  puts 'Seeding test environment with classic literature books...'

  # Create authors for test
  author1 = Author.find_or_create_by!(author_name: 'Harper Lee')
  author2 = Author.find_or_create_by!(author_name: 'F. Scott Fitzgerald')
  author3 = Author.find_or_create_by!(author_name: 'Ernest Hemingway')
  author4 = Author.find_or_create_by!(author_name: 'Jane Austen')
  author5 = Author.find_or_create_by!(author_name: 'Mark Twain')

  # Create books for test
  Book.find_or_create_by!(title: 'To Kill a Mockingbird') do |book|
    book.author_id = author1.id
    book.price = 11.99
    book.publish_date = Date.new(1960, 7, 11)
  end

  Book.find_or_create_by!(title: 'The Great Gatsby') do |book|
    book.author_id = author2.id
    book.price = 9.99
    book.publish_date = Date.new(1925, 4, 10)
  end

  Book.find_or_create_by!(title: 'The Old Man and the Sea') do |book|
    book.author_id = author3.id
    book.price = 8.99
    book.publish_date = Date.new(1952, 9, 1)
  end

  Book.find_or_create_by!(title: 'Pride and Prejudice') do |book|
    book.author_id = author4.id
    book.price = 7.99
    book.publish_date = Date.new(1813, 1, 28)
  end

  Book.find_or_create_by!(title: 'The Adventures of Huckleberry Finn') do |book|
    book.author_id = author5.id
    book.price = 10.99
    book.publish_date = Date.new(1884, 12, 10)
  end

  puts 'Test data created successfully! (5 classic literature books)'

else
  # PRODUCTION ENVIRONMENT - 5 Modern Bestsellers
  puts 'Seeding production environment with modern bestsellers...'

  # Create authors for production
  author1 = Author.find_or_create_by!(author_name: 'Dan Brown')
  author2 = Author.find_or_create_by!(author_name: 'Gillian Flynn')
  author3 = Author.find_or_create_by!(author_name: 'Paulo Coelho')
  author4 = Author.find_or_create_by!(author_name: 'Khaled Hosseini')
  author5 = Author.find_or_create_by!(author_name: 'Celeste Ng')

  # Create books for production
  Book.find_or_create_by!(title: 'The Da Vinci Code') do |book|
    book.author_id = author1.id
    book.price = 16.99
    book.publish_date = Date.new(2003, 3, 18)
  end

  Book.find_or_create_by!(title: 'Gone Girl') do |book|
    book.author_id = author2.id
    book.price = 15.99
    book.publish_date = Date.new(2012, 6, 5)
  end

  Book.find_or_create_by!(title: 'The Alchemist') do |book|
    book.author_id = author3.id
    book.price = 12.99
    book.publish_date = Date.new(1988, 1, 1)
  end

  Book.find_or_create_by!(title: 'The Kite Runner') do |book|
    book.author_id = author4.id
    book.price = 14.99
    book.publish_date = Date.new(2003, 5, 29)
  end

  Book.find_or_create_by!(title: 'Little Fires Everywhere') do |book|
    book.author_id = author5.id
    book.price = 13.99
    book.publish_date = Date.new(2017, 9, 12)
  end

  puts 'Production data created successfully! (5 modern bestsellers)'
end
