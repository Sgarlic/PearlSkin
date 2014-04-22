require 'will_paginate/array'
require 'will_paginate'
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :show, :show_favourite,
    :show_plan, :show_used]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:new, :create, :destroy]

  def show
    @user = User.find(params[:id])
    linktype = params[:linktype]
    if linktype.nil?
      linktype="favourite"
    end

    @currentLinkType = linktype

    if linktype == "favourite"
      @relationships = @user.favourites.order(created_at: :desc)
    elsif linktype == "plan"
      @relationships = @user.plans.order(created_at: :desc)
    else
      @relationships = @user.useds.order(created_at: :desc)
    end
    
    @relation_items = Array.new(0)
    @relationships.each do |relationship|
      @relation_items << Item.find(relationship.item_id)
    end

    @relation_items = @relation_items.paginate(page: params[:page], :per_page => 15)
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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end