class UsersController < ApplicationController
  def new
    @user = User.new
    @book = Book.new
  end
  
  
  def index
    @users = User.all
    @user = User.new
    @books = Book.all
    @book = Book.new
    
     @user = current_user
  end
  
  

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @user = User.new
    @books = Book.all
    @users = User.all
    @user = current_user
    # @books = @user.books.page(params[:page]).reverse_order
  end
  
  def edit
    @book = Book.new
    @user = User.new
    @user = User.find(params[:id])
    @user = current_user
  end
  
  def update
       @user = User.new
       @books = Book.all
       @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
       render :edit
    end
  end
  

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end