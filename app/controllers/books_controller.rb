# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_admin!

  def home
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  #----------------------------------------------------------------------------#
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params.except(:author_name))
    
    # Handle author creation/finding
    if params[:book][:author_name].present?
      author = Author.find_or_create_by(author_name: params[:book][:author_name])
      @book.author = author
    end
    
    if @book.save
      flash[:notice] = 'Book Added!'
      redirect_to home_path
    else
      flash[:notice] = 'One or more fields not filled. Try again!'
      redirect_to new_book_url
    end
  end
  #----------------------------------------------------------------------------#

  #----------------------------------------------------------------------------#
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    
    # Handle author creation/finding
    if params[:book][:author_name].present?
      author = Author.find_or_create_by(author_name: params[:book][:author_name])
      @book.author = author
    end
    
    if @book.update(book_params.except(:author_name))
      flash[:notice] = 'Book updated.'
      redirect_to home_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  #----------------------------------------------------------------------------#

  #----------------------------------------------------------------------------#
  def delete
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = 'Book deleted successfully!'
    redirect_to home_path
  end
  #----------------------------------------------------------------------------#

  #----------------------------------------------------------------------------#
  private

  def book_params
    params.require(:book).permit(:title, :author_id, :author_name, :price, :publish_date)
  end
  #----------------------------------------------------------------------------#
end
