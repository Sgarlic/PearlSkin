class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :show, :show_favourite,
    :show_plan, :show_used]
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
      flash[:success] = "用户信息已更新！"
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

  def show_user_items
    linktype = params[:linktype]
    @user = User.find(params[:user_id])
    if linktype == "favourite"
      @relationships = @user.favourites.paginate(page: params[:page]).per_page(10)
    elsif linktype == "plan"
      @relationships = @user.plans.paginate(page: params[:page]).per_page(10)
    else
      @relationships = @user.useds.paginate(page: params[:page]).per_page(10)
    end

    respond_to do |format|
      # format.html { redirect_to item_path(@item_id) }
      format.js
    end
  end

  def show_plan
  end

  def show_used
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end