class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = '错误的邮箱/密码组合'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end


end