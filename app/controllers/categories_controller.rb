class CategoriesController <ApplicationController
	def index
		@categories = Category.paginate(page: params[:page]).per_page(10)
	end

	def show
		@category = Category.find(params[:id])
		@subcatetories = @category.subcategories.paginate(page: params[:page]).per_page(10)
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "已添加“#{@category.name}”"
		end
		redirect_to categories_path
	end

	def destroy
		destroy_category = Category.find(params[:id])
		destroy_category.destroy
		flash[:success] = "已删除“#{destroy_category.name}”"
		redirect_to categories_path
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_params)
			flash[:success] = "更新成功"
		else
			flash[:failed] = "更新失败！"
		end
		redirect_to categories_path
	end

	private
		def category_params
			params.require(:category).permit(:name, :step)
		end
end