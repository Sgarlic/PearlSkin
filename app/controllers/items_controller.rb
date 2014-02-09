class ItemsController <ApplicationController
	def new
		@item = Item.new
		@brands = Brand.find_brands
		@subcategories = Subcategory.find(:all)

		respond_to do |format|
      		format.html {}
      		format.js
    	end
	end

	def create
		#@subcategories = Subcategory.find(:all)
	end

	def show
	end
end