# frozen_string_literal: true

# spec/system/book_integration_tests.rb
require 'rails_helper'

# ---- Title tests (keep your structure/expectations) ----
RSpec.describe 'Book management', type: :system do
  it 'creates a book and shows the success flash (sunny day)' do
    visit new_book_path

    # fill ALL required fields (title, author, price, publish_date)
    fill_in 'book_title',         with: 'Sunny Day'
    fill_in 'book_author',        with: 'Some Author'
    fill_in 'book_price',         with: 42
    fill_in 'book_publish_date',  with: '10-05-2025' # ISO for <input type="date">

    expect do
      click_button 'Add Book'
      sleep 2
    end.to change(Book, :count).by(1)

    expect(page).to have_content('Book Added!')
    expect(page).to have_content('Sunny Day')
  end
end

RSpec.describe 'Book management', type: :system do
  it 'rejects a blank title and shows validation/flash (rainy day)' do
    visit new_book_path

    # only title blank; others valid
    fill_in 'book_title',         with: ''
    fill_in 'book_author',        with: 'Some Author'
    fill_in 'book_price',         with: 42
    fill_in 'book_publish_date',  with: '10-05-2025'

    expect do
      click_button 'Add Book'
      sleep 2
    end.not_to change(Book, :count)

    expect(page).to have_content('One or more fields not filled. Try again!')
      .or have_content('error')
    expect(page).to have_current_path(new_book_path, ignore_query: true)
      .or have_current_path(books_path, ignore_query: true)
  end
end

# ---- Author tests ----
RSpec.describe 'Books / author', type: :system do
  it 'creates a book with author (sunny)' do
    visit new_book_path

    fill_in 'book_title',         with: 'Refactoring'
    fill_in 'book_author',        with: 'Martin Fowler'
    fill_in 'book_price',         with: 42
    fill_in 'book_publish_date',  with: '10-05-2025'

    expect do
      click_on 'Add Book'
      sleep 2
    end.to change(Book, :count).by(1)

    expect(page).to have_content('Book Added!')
    expect(page).to have_content('Refactoring')
  end
end

RSpec.describe 'Books / author', type: :system do
  it 'rejects missing author (rainy)' do
    visit new_book_path

    fill_in 'book_title',         with: 'Refactoring'
    fill_in 'book_author',        with: '' # only author blank
    fill_in 'book_price',         with: 42
    fill_in 'book_publish_date',  with: '10-05-2025'

    expect do
      click_on 'Add Book'
      sleep 2
    end.not_to change(Book, :count)

    expect(page).to have_content('One or more fields not filled. Try again!')
      .or have_content('error')
    expect(page).to have_current_path(new_book_path, ignore_query: true)
      .or have_current_path(books_path, ignore_query: true)
  end
end

# ---- Price tests ----
RSpec.describe 'Books / price', type: :system do
  it 'creates a book with numeric price (sunny)' do
    visit new_book_path

    fill_in 'book_title',         with: 'Refactoring'
    fill_in 'book_author',        with: 'Refactoring Author'
    fill_in 'book_price',         with: 42
    fill_in 'book_publish_date',  with: '10-05-2025'

    expect do
      click_on 'Add Book'
      sleep 2
    end.to change(Book, :count).by(1)

    expect(page).to have_content('Book Added!')
    expect(page).to have_content('Refactoring Author')
    expect(page).to have_content(42.00)
  end
end

RSpec.describe 'Books / price', type: :system do
  it 'rejects non-numeric price (rainy)' do
    visit new_book_path

    fill_in 'book_title',         with: 'Refactoring'
    fill_in 'book_author',        with: 'Refactoring Author'
    fill_in 'book_price',         with: 'oops' # only price invalid
    fill_in 'book_publish_date',  with: '10-05-2025'

    expect do
      click_on 'Add Book'
      sleep 2
    end.not_to change(Book, :count)

    expect(page).to have_content('One or more fields not filled. Try again!')
      .or have_content('error')
      .or have_content('is not a number')
    expect(page).to have_current_path(new_book_path, ignore_query: true)
      .or have_current_path(books_path, ignore_query: true)
  end
end

# ---- Publish Date tests ----
RSpec.describe 'Books / publish_date', type: :system do
  it 'creates a book with a publish date (sunny)' do
    visit new_book_path

    fill_in 'book_title',         with: 'Refactoring'
    fill_in 'book_author',        with: 'Refactoring Author'
    fill_in 'book_price',         with: 42
    fill_in 'book_publish_date',  with: '10-05-2025'       # ISO

    expect do
      click_on 'Add Book'
      sleep 2
    end.to change(Book, :count).by(1)

    expect(page).to have_content('Book Added!')
    expect(page).to have_content('Refactoring')
    expect(page).to have_content('Refactoring Author')
    expect(page).to have_content(42).or have_content('42.00')
    expect(page).to have_content('2025').or have_content('10-05-2025')
  end
end

RSpec.describe 'Books / publish_date', type: :system do
  it 'rejects missing published date (rainy)' do
    visit new_book_path

    fill_in 'book_title',         with: 'Refactoring'
    fill_in 'book_author',        with: 'Refactoring Author'
    fill_in 'book_price',         with: 42
    find('#book_publish_date').set('')                     # ensure blank

    expect do
      click_on 'Add Book'
      sleep 2
    end.not_to change(Book, :count)

    expect(page).to have_content('One or more fields not filled. Try again!')
      .or have_content('error')
      .or have_content("can't be blank")
    expect(page).to have_current_path(new_book_path, ignore_query: true)
      .or have_current_path(books_path, ignore_query: true)
  end
end
