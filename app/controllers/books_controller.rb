class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_book, { only: [:edit] }

  def new
  end


  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book_new.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end




  def index
     @books = Book.all
     @book_new = Book.new
     @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @books = Book.page(params[:page]).reverse_order
    @user = @book.user

  end

   def edit
    @book = Book.find(params[:id])
    @user = current_user
   end

   def update
       @book = Book.find(params[:id])
       @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
       @user = current_user
       render :edit
    end
   end



  def destroy
    @user = current_user
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  def ensure_correct_book
        @book = Book.find_by(id: params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
