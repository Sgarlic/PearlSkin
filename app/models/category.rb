class Category < ActiveRecord::Base
	has_many :subcategories, dependent: :destroy
	default_scope -> {order('step')}

	validates :name, presence: true, length: {maximum: 140}, uniqueness: true
	validates :step, presence: true, uniqueness: true

	def self.find_categries
		Category.find(:all, :order => "name").collect{|category| [category.name, category.id]}
	end
end
