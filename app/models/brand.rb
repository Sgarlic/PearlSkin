class Brand < ActiveRecord::Base
	belongs_to :country
	has_many :items, dependent: :destroy

	default_scope -> {order('brand_english')}

	validates :brand_english, presence: true, length: {maximum: 140}, uniqueness: true
	validates :country_id, presence: true

	def self.find_brands
		Brand.find(:all, :order => "brand_english").collect{|brand| [brand.brand_english, brand.id]}
	end
end
