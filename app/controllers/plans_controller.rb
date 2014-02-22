class PlansController < ApplicationController
  before_action :signed_in_user

  def create
  	@item_id = params[:plan][:item_id]
    current_user.plan!(@item_id)
    respond_to do |format|
      format.html { redirect_to item_path(@item_id) }
      format.js
    end
  end

  def destroy
  	@item_id = params[:plan][:item_id]
    current_user.unplan!(@item_id)
    respond_to do |format|
      format.html { redirect_to item_path(@item_id) }
      format.js
    end
  end
end