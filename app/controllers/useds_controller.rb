class UsedsController < ApplicationController
  before_action :signed_in_user

  def create
  	@item_id = params[:used][:item_id]
    current_user.used!(@item_id)
    respond_to do |format|
      format.html { redirect_to item_path(@item_id) }
      format.js
    end
  end

  def destroy
  	@item_id = params[:used][:item_id]
    current_user.unused!(@item_id)
    respond_to do |format|
      format.html { redirect_to item_path(@item_id) }
      format.js
    end
  end
end