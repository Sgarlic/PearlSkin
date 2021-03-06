class SubcategoriesController <ApplicationController
	before_action :signed_in_user, only: [:show]
  	before_action :admin_user,     only: [:index, :carete, :destroy, :update]
	def index
		#@category = Category.find(params[:id])
		@subcategories = @category.subcategories.paginate(page: params[:page]).per_page(10)
	end

	def show
		@subcategory =  Subcategory.find(params[:id])
	end

	def create
		@category = Category.find(params[:category_id])
		@subcategory = @category.subcategories.build(subcategory_params)
		begin
			if @subcategory.save
				flash[:success] = "已添加“#{@subcategory.name}”"
			else
				flash[:failed] = "添加“#{@subcategory.name}”失败"
			end
		rescue ActiveRecord::RecordNotUnique
			flash[:failed] = "该类别已存在！"
		end
		redirect_to category_path(@category.id)
	end

	def destroy
		destroy_subcategory = Subcategory.find(params[:id])
		destroy_subcategory.destroy
		flash[:success] = "已删除“#{destroy_subcategory.name}”"
		redirect_to category_path(destroy_subcategory.category_id)
	end

	def update
		@subcategory = Subcategory.find(params[:id])
		begin
			if @subcategory.update_attributes(subcategory_params)
				flash[:success] = "更新成功"
			else
				flash[:failed] = "更新失败！"
			end
		rescue ActiveRecord::RecordNotUnique
			flash[:failed] = "该类别已存在！"
		end	
		redirect_to category_path(@subcategory.category_id)
	end

  def show_subcategory_brand_items
    brand_id = params[:brand_id]
    subcategory_id = params[:subcategory_id]
    @items = Item.where("subcategory_id=#{subcategory_id}").where("brand_id=#{brand_id}").order('item_english')
    
    respond_to do |format|
      # format.html { redirect_to item_path(@item_id) }
      format.js
    end
  end

	private
		def subcategory_params
			params.require(:subcategory).permit(:name, :step)
		end
end