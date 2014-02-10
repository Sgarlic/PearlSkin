class BrandsController <ApplicationController
	def index
		@countries = Country.find_countries
		@brands = Brand.paginate(page: params[:page]).per_page(10)
	end


	def all_brands
		@all_of_brands = Brand.paginate(page: params[:page]).per_page(10)
	end

	def create
		@brand = Brand.new(brand_params)
		begin
			if @brand.save
				flash[:success] = "已添加“#{@brand.brand_english}”"
			else
				flash[:failed] = "添加“#{@brand.brand_english}”失败"
			end
		rescue ActiveRecord::RecordNotUnique
			flash[:failed] = "该品牌已存在！"
		end

		redirect_to brands_path
	end

	def destroy
		destroy_brand = Brand.find(params[:id])
		destroy_brand.destroy
		flash[:success] = "已删除“#{destroy_brand.brand_english}”"
		redirect_to brands_path
	end

	def update
		@brand = Brand.find(params[:id])
		begin
			if @brand.update_attributes(brand_params)
				flash[:success] = "更新成功"
			else
				flash[:failed] = "更新失败！"
			end
		rescue ActiveRecord::RecordNotUnique
			flash[:failed] = "该品牌已存在！"
		end	
		redirect_to brands_path
	end

	def show
		@brand = Brand.find(params[:id])
	end

	private
		def brand_params
			params.require(:brand).permit(:brand_english, :brand_chinese, :country_id)
		end
end