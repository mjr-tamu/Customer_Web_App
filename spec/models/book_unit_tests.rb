# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  # baseline valid attributes for convenience
  def valid_attrs(overrides = {})
    {
      title: 'Refactoring',
      author: 'Martin Fowler',
      price: 42.00,
      publish_date: Date.new(2019, 5, 10)
    }.merge(overrides)
  end

  # ---- Title tests ----
  describe 'title validation' do
    it 'is valid with a title (sunny day)' do
      book = Book.new(valid_attrs(title: 'Clean Code'))
      expect(book).to be_valid
    end

    it 'is invalid without a title (rainy day)' do
      book = Book.new(valid_attrs(title: nil))
      book.validate
      expect(book.errors[:title]).to be_present
    end
  end
end

RSpec.describe Book, type: :model do
  # baseline valid attributes for convenience
  def valid_attrs(overrides = {})
    {
      title: 'Refactoring',
      author: 'Martin Fowler',
      price: 42.00,
      publish_date: Date.new(2019, 5, 10)
    }.merge(overrides)
  end

  # ---- Author tests ----
  describe 'author validation' do
    it 'is valid with an author (sunny)' do
      book = Book.new(valid_attrs(author: 'Martin Fowler'))
      expect(book).to be_valid
    end

    it 'is invalid without an author (rainy)' do
      book = Book.new(valid_attrs(author: nil))
      book.validate
      expect(book.errors[:author]).to be_present
    end
  end
end

RSpec.describe Book, type: :model do
  # baseline valid attributes for convenience
  def valid_attrs(overrides = {})
    {
      title: 'Refactoring',
      author: 'Martin Fowler',
      price: 42.00,
      publish_date: Date.new(2019, 5, 10)
    }.merge(overrides)
  end

  # ---- Price tests ----
  describe 'price validation' do
    it 'is valid with a numeric price (sunny)' do
      book = Book.new(valid_attrs(price: 42.00))
      expect(book).to be_valid
    end

    it 'is invalid when price is not a number (rainy)' do
      book = Book.new(valid_attrs(price: 'Not a Number'))
      book.validate
      expect(book.errors[:price]).to be_present
    end
  end
end

RSpec.describe Book, type: :model do
  # baseline valid attributes for convenience
  def valid_attrs(overrides = {})
    {
      title: 'Refactoring',
      author: 'Martin Fowler',
      price: 42.00,
      publish_date: Date.new(2019, 5, 10)
    }.merge(overrides)
  end

  # ---- Publish date tests ----
  describe 'publish_date validation' do
    it 'is valid with a publish_date (sunny)' do
      book = Book.new(valid_attrs(publish_date: Date.new(2019, 5, 10)))
      expect(book).to be_valid
    end

    it 'is invalid without a publish_date (rainy)' do
      book = Book.new(valid_attrs(publish_date: nil))
      book.validate
      expect(book.errors[:publish_date]).to be_present
    end
  end
end
