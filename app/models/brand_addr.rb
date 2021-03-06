class BrandAddr < ActiveRecord::Base
	belongs_to :brand
	before_save {self.link_addr = /^http/.match(self.link_addr) ? self.link_addr : "http://#{self.link_addr}"}

	default_scope -> {order('created_at DESC')}

	validates :brand_id, presence: true
	validates :description, presence: true
	validates :link_addr, presence: true, uniqueness: true

	def url_with_protocol
		elf.link_addr = /^http/.match(self.link_addr) ? self.link_addr : "http://#{self.link_addr}"
	end
end
