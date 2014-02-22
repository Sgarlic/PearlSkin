class FavouritesController < ApplicationController
  before_action :signed_in_user

  def create
  	@item_id = params[:favourite][:item_id]
    current_user.favourite!(@item_id)
    respond_to do |format|
      format.html { redirect_to item_path(@item_id) }
      format.js
    end
  end

  def destroy
  	@item_id = params[:favourite][:item_id]
    current_user.unfavourite!(@item_id)
    respond_to do |format|
      format.html { redirect_to item_path(@item_id)}
      format.js
    end
  end
end