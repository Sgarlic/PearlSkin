class BrandAddrsController <ApplicationController
	before_action :signed_in_user, only: [:index]
    before_action :admin_user,     only: [:create, :destroy]
	def index
		#@category = Category.find(params[:id])
		@brand_addrs = @brand.brand_addrs.paginate(page: params[:page]).per_page(10)
	end

	def create
		@brand = Brand.find(params[:brand_id])
		@brand_addr = @brand.brand_addrs.build(brand_addr_params)
		begin
			if @brand_addr.save
				flash[:success] = "已添加链接"
			else
				flash[:failed] = "添加链接失败"
			end
		rescue ActiveRecord::RecordNotUnique
			flash[:failed] = "该链接已存在！"
		end
		redirect_to brand_path(@brand.id)
	end

	def destroy
		destroy_addr = BrandAddr.find(params[:id])
		destroy_addr.destroy
		flash[:success] = "已删除链接"
		redirect_to brand_path(destroy_addr.brand_id)
	end


	private
		def brand_addr_params
			params.require(:brand_addr).permit(:description, :link_addr)
		end
end