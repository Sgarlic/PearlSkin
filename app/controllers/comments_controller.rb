class CommentsController <ApplicationController
	before_action :signed_in_user, only: [:index, :create]
  	before_action :admin_user,     only: [:destroy]
	def index
		#@category = Category.find(params[:id])
		@comments = @item.comments.paginate(page: params[:page]).per_page(10)
	end

	def create
		@item = Item.find(params[:item_id])
		@comment = @item.comments.build(comment_params)
		begin
			if @comment.save
				flash[:success] = "已添加评论"
			else
				flash[:failed] = "添加评论失败"
			end
		rescue ActiveRecord::RecordNotUnique
			flash[:failed] = "该评论已存在！"
		end
		redirect_to item_path(@item.id)
	end

	def destroy
		destroy_comment = Comment.find(params[:id])
		destroy_comment.destroy
		flash[:success] = "已删除评论"
		redirect_to item_path(destroy_comment.item_id)
	end


	private
		def comment_params
			params.require(:comment).permit(:content, :author)
		end
end