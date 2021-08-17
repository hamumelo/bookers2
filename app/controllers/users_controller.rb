class UsersController < ApplicationController
  before_action :authenticate_user!
    before_action :ensure_correct_user, { only: [:edit] }

  def new
  end


  def index
    @users = User.all
    @book_new = Book.new
    @user = current_user
  end



  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book_new = Book.new
    @user = @user

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


  def ensure_correct_user
        @user = User.find_by(id: params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end