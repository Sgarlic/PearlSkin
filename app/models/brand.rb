class Brand < ActiveRecord::Base
	belongs_to :country
	default_scope -> {order('brand_english')}

	validates :brand_english, presence: true, length: {maximum: 140}
	validates :country_id, presence: true
end
