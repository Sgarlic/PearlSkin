require 'find'
class ItemsController <ApplicationController
	before_action :signed_in_user, only: [:show]
  	before_action :admin_user,     only: [:new, :edit, :update, :create, :destroy, :delete_picture]
	def new
		@item = Item.new
		@brands = Brand.find_brands
		@subcategories = Subcategory.find(:all)

		#respond_to do |format|
      	#	format.html {}
      	#	format.js
    	#end
	end

	def edit
		@item = Item.find(params[:id])
		@brands = Brand.find_brands
		@subcategories = Subcategory.find(:all)
		@pictures = Item.find_pictures(@item)
	end

	def update
		@item = Item.find(params[:id])
		if (Subcategory.find(@item.subcategory_id).category_id) != (@item.category_id)
			flash[:failed] = "该子类别不属于该类别！请重新添加"
			redirect_to edit_item_path
		end

		if isPicture?(params[:upload])
			if @item.update_attributes(item_params)
				flash[:success] = "更新成功！"
				@item.addPicture(params[:upload])
				redirect_to item_path
			else
				flash[:failed] = "更新失败！"
				redirect_to edit_item_path
			end
		else
			flash[:failed] = "非法图片！"
			redirect_to edit_item_path
		end

	end

	def create
		buttonname = params[:Goon]
		@item = Item.new(item_params)
		if (Subcategory.find(@item.subcategory_id).category_id) != (@item.category_id)
			flash[:failed] = "该子类别不属于该类别！请重新添加"
			redirect_to new_item_path
		end


		if isPicture?(params[:upload])
			begin
				if @item.save
					flash[:success] = "已添加“#{@item.item_english}”"
					@item.addPicture(params[:upload])
					redirect_to_here(buttonname, @item)
				else
					flash[:failed] = "添加“#{@item.item_english}”失败"
					redirect_to new_item_path
				end
			rescue ActiveRecord::RecordNotUnique
				flash[:failed] = "该物品已存在！"
				redirect_to new_item_path
			end
		else
			flash[:failed] = "非法图片！"
			redirect_to new_item_path
		end
	end

	def destroy
		destroy_item = Item.find(params[:id])
		destroy_item.removeDir
		destroy_item.destroy
		flash[:success] = "已删除“#{destroy_item.item_name}”"
		redirect_to root_path
	end

	def show
		@item = Item.find(params[:id])
		@comments = @item.comments.paginate(page: params[:page]).per_page(10)
		@pictures = Item.find_pictures(@item)
		@item_addrs = @item.item_addrs.paginate(page: params[:page]).per_page(10)
	end

	def delete_picture
		@item = Item.find(params[:itemID])
		@item.removePicture(params[:pictureName])
		redirect_to item_path(@item.id)
	end

	private
		def item_params
			params.require(:item).permit(:item_english, :item_chinese, :price, :character, :brand_id, :category_id, :subcategory_id)
		end

		def redirect_to_here(buttonname, item)
			if buttonname.nil?
				redirect_to item
			else
				redirect_to new_item_path
			end
		end

		def isPicture?(upload)
			if upload.nil?
				return true
			end
			if upload['datafile'].content_type.chomp =~ /^image/
				true
			else
				false
			end
		end

end