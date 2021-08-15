class BooksController < ApplicationController
  
  
# before_action :authenticate_user!
# before_action :correct_book,only: [:edit]
 
  
  
  def new
    @book = Book.new
    @user = User.new
  end

  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  
  

  def index
     @book = Book.all.order(created_at: :desc)
     @users = User.all
     @books = Book.all
     @book = Book.new
    # @user = User.new
     @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @users = User.all
    @book = Book.new
    @user = User.new
    
    @user = current_user
    
  end
  
   def edit
    @book = Book.new
    @book = Book.find(params[:id])
    @user = current_user
    @user = User.new
   end
   
   def update
       @user = User.new
       @books = Book.all
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
  
  def users
    public_method(:show, :edit, :update).super_method.call
  end
  
  
  
  
  # def correct_
  #       @book = Book.find(params[:id])
  #   unless @book.user.id == current_user.id
  #     redirect_to book_path(@book.id)
  #   end
  # end
  
  private

  def book_params
    params.require(:book).permit(:title, :body, :image, :user)
  end
  
end
