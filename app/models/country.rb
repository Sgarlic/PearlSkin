class Country < ActiveRecord::Base
	has_many :brands, dependent: :destroy
	
	default_scope -> {order('country_name')}

	validates :country_name,	presence: true, 
								length: {maximum: 20},
								uniqueness: true

	def self.find_countries
		Country.all.order("country_name").collect{|country| [country.country_name, country.id]}
	end
end
