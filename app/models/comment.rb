class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :item

	default_scope -> {order('created_at DESC')}

	validates :item_id, presence: true
	validates :content, presence: true
end
