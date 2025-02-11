class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @borrowings = @book.borrowings.order(borrowed_at: :desc)
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "The books was successfully added :)"
    else
      render :new
    end
  end

  def update
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: "The book was successfully deleted :("
  end

  def borrow
    if @book.update(status: "borrowed")
      @book.borrowings.create(
        borrower_name: params[:borrower_name],
        borrowed_at: Time.current
      )
        redirect_to @book, notice: "The book was successfully borrowed :)"
    else
        redirect_to @book, alert: "Someone Seems to have the book :("
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
