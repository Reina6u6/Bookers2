class UsersController < ApplicationController
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    @user.save
    redirect_to books_path
  end

  def index
    @user = User.all
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:image].present?
      @user.image.attach(params[:user][:image])
    end

    if @user.update(user_params)
      redirect_to books_path(@book), notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  private
  def user_params
    params.permit(:name, :image, :introduction)
  end
end