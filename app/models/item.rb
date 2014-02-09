class Item < ActiveRecord::Base
	belongs_to :brand
	belongs_to :subcategory

	default_scope -> {order('item_english')}

	validates :item_english, presence: true, length: {maximum: 140}, uniqueness: true
	validates :item_chinese, presence: true, uniqueness: true
	validates :brand_id, presence: true
	validates :subcategory_id, presence: true
	validates :category_id, presence: true
	validates :price, length: {maximum: 300}
end
