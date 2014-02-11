class ItemAddrsController <ApplicationController
	before_action :signed_in_user, only: [:index]
  	before_action :admin_user,     only: [:create, :destroy]
	def index
		#@category = Category.find(params[:id])
		@item_addrs = @item.item_addrs.paginate(page: params[:page]).per_page(10)
	end

	def create
		@item = Item.find(params[:item_id])
		@item_addr = @item.item_addrs.build(item_addr_params)
		begin
			if @item_addr.save
				flash[:success] = "已添加链接"
			else
				flash[:failed] = "添加链接失败"
			end
		rescue ActiveRecord::RecordNotUnique
			flash[:failed] = "该链接已存在！"
		end
		redirect_to item_path(@item.id)
	end

	def destroy
		destroy_addr = ItemAddr.find(params[:id])
		destroy_addr.destroy
		flash[:success] = "已删除链接"
		redirect_to item_path(destroy_addr.item_id)
	end


	private
		def item_addr_params
			params.require(:item_addr).permit(:description, :link_addr)
		end
end