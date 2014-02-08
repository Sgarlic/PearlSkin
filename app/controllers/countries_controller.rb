class CountriesController <ApplicationController
	def index
		@countries = Country.paginate(page: params[:page]).per_page(10)
	end

	def create
		@country = Country.new(country_params)
		if @country.save
			flash[:success] = "已添加“#{@country.country_name}”"
		end
		redirect_to countries_path
	end

	def destroy
		destroy_country = Country.find(params[:id])
		destroy_country.destroy
		flash[:success] = "已删除“#{destroy_country.country_name}”"
		redirect_to countries_path
	end

	def update
		@country = Country.find(params[:id])
		if @country.update_attributes(country_params)
			flash[:success] = "更新成功"
		else
			flash[:failed] = "更新失败！"
		end
		redirect_to countries_path
	end

	private
		def country_params
			params.require(:country).permit(:country_name)
		end
end