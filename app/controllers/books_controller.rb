class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy, :borrow, :return ]

  def index
    @books = Book.all
  end

  def show
    @borrowings = @book.borrowings.order(borrowed_at: :desc)
  end

  def new
    @book = Book.new
    @books = Book.all
  end

  def edit
    @book = Book.new
    if @book.save
      redirect_to @book, notice: "The book was successfully updated :)"
    else
      render :edit
    end
  end

  def create
    @book = Book.new(books_params)
    if @book.save
      redirect_to @book, notice: "The books was successfully added :)"
    else
      render :new
    end
  end

  def update
  end

  def destroy
    if @book.destroy
      redirect_to books_url, notice: "The book was successfully deleted :("
    else
      redirect_to books_url, alert: "The book was not deleted :("
    end
  end

  def borrow
    if @book.status == "available" && @book.update(status: "borrowed")
      @book.borrowings.create(
        borrower_name: params[:borrower_name],
        borrowed_at: Time.current
      )
        redirect_to @book, notice: "The book was successfully borrowed :)"
    else
        redirect_to @book, alert: "Someone seems to have the book :("
    end
  end

  def return
    if @book.update(status: "available")
      borrowing = @book.borrowings.where(returned_at: nil).last
      borrowing.update(returned_at: Time.current) if borrowing
      redirect_to @book, notice: "Book was successfully returned :)"
    else
      redirect_to @book, alert: "The book is not returned :("
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def books_params
    params.require(:book).permit(:title, :author, :published_year, :status)
  end
end
