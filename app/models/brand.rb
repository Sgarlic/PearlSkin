class Brand < ActiveRecord::Base
	belongs_to :country
	has_many :items, dependent: :destroy
	has_many :brand_addrs, dependent: :destroy

	default_scope -> {order('brand_english')}

	validates :brand_english, presence: true, length: {maximum: 140}, uniqueness: true, :case_sensitive => false
	validates :country_id, presence: true


	def brand_name
		self.brand_english+"-"+self.brand_chinese
	end

	def self.find_brands
		Brand.find(:all, :order => "brand_english").collect{|brand| [brand.brand_name, brand.id]}
	end
end
