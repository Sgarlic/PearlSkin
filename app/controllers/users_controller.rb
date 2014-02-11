class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:new, :create, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def index
  	 @users = User.paginate(page: params[:page]).per_page(10)
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #sign_in @user
      flash[:success] = "创建用户成功!"
      redirect_to current_user
    else
      flash[:failed] = "创建用户失败!"
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "删除用户成功"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end