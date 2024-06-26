class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update]
  def new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to book_path
  end

  def index
    @user = current_user

    @users = User.all
    @book = Book.new
  end

  def show
   @user = User.find(params[:id])
   @books = @user.books
   @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end