class Subcategory < ActiveRecord::Base
	belongs_to :category
	has_many :items, dependent: :destroy

	default_scope -> {order('step')}

	validates :name, presence: true, length: {maximum: 140}
	validates :category_id, presence: true
	validates :step, presence: true
	
	def self.find_subcategories
		Subcategory.find(:all, :order => "name").collect{|subcategory| [subcategory.name, subcategory.id]}
	end

	def subcategory_name
		Category.find(self.category_id).name+"-"+self.name
	end
end
