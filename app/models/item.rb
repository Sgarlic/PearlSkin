class Item < ActiveRecord::Base
	belongs_to :brand
	belongs_to :subcategory
	has_many :comments, dependent: :destroy
	has_many :item_addrs, dependent: :destroy

	#default_scope -> {order('item_english')}

	validates :item_english, presence: true
	validates :item_chinese, presence: true
	validates :brand_id, presence: true
	validates :subcategory_id, presence: true
	validates :category_id, presence: true


	def item_name
		self.item_english+"-"+self.item_chinese
	end

	def upload_image=(upload)
		if upload.nil?
			return
		end
		incoming_file = upload['datafile']
		self.filename =  incoming_file.original_filename
		self.content_type = incoming_file.content_type
		self.image = incoming_file.read
	end 
end
