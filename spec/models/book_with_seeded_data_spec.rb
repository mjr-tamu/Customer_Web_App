# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'with seeded data' do
    before(:all) do
      # Ensure we have the seeded data
      Rails.application.load_seed
    end

    it 'has seeded books with authors' do
      expect(Book.count).to be >= 3
      expect(Author.count).to be >= 3
    end

    it 'has the correct seeded book titles' do
      book_titles = Book.pluck(:title)
      expect(book_titles).to include('To Kill a Mockingbird')
      expect(book_titles).to include('The Great Gatsby')
      expect(book_titles).to include('The Old Man and the Sea')
      expect(book_titles).to include('Pride and Prejudice')
      expect(book_titles).to include('The Adventures of Huckleberry Finn')
    end

    it 'has books with associated authors' do
      books_with_authors = Book.joins(:author)
      expect(books_with_authors.count).to be >= 3
    end

    it 'has the correct author names' do
      author_names = Author.pluck(:author_name)
      expect(author_names).to include('Harper Lee')
      expect(author_names).to include('F. Scott Fitzgerald')
      expect(author_names).to include('Ernest Hemingway')
      expect(author_names).to include('Jane Austen')
      expect(author_names).to include('Mark Twain')
    end

    it 'has books with valid prices' do
      Book.all.each do |book|
        expect(book.price).to be > 0
        expect(book.price).to be_a(Numeric)
      end
    end

    it 'has books with valid publish dates' do
      Book.all.each do |book|
        expect(book.publish_date).to be_a(Time)
        expect(book.publish_date.to_date).to be < Date.current
      end
    end

    it 'can find books by author name through association' do
      harper_lee = Author.find_by(author_name: 'Harper Lee')
      mockingbird_books = Book.where(author: harper_lee)
      expect(mockingbird_books.count).to be >= 1
      expect(mockingbird_books.first.title).to include('To Kill a Mockingbird')
    end
  end
end
