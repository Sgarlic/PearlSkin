require 'find'
class Item < ActiveRecord::Base
	belongs_to :brand
	belongs_to :subcategory
	has_many :comments, dependent: :destroy
	has_many :item_addrs, dependent: :destroy

	default_scope -> {order('item_english')}

	validates :item_english, presence: true, length: {maximum: 140}, uniqueness: true
	validates :item_chinese, presence: true, uniqueness: true
	validates :brand_id, presence: true
	validates :subcategory_id, presence: true
	validates :category_id, presence: true

	def item_name
		self.item_english+"-"+self.item_chinese
	end

	def addPicture(upload)
		if upload.nil?
			return
		end
		name =  self.id.to_s()+"_"+Time.new.to_i.to_s()+"_"+upload['datafile'].original_filename
    	directory = "app/assets/images/"+self.id.to_s()

    	if(!File.exist?(directory))
    		Dir.mkdir(directory)
    	end
    	# create the file path
    	path = File.join(directory, name)
    	# write the file
    	File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
	end

	def removePicture(pictureName)
		directory = "app/assets/images/"+self.id.to_s()+"/"+pictureName
		removeFile(directory)
	end

	def removeDir()
		directory = "app/assets/images/"+self.id.to_s()
		removeFile(directory)
	end

	def self.find_pictures(item)
		directory = "app/assets/images/"+item.id.to_s() 
		if(File.exist?(directory))
    		Find.find(directory)
    	end
	end


	private
		def removeFile(directory)
			if(File.exist?(directory))
				begin
					File.delete(directory)
				rescue
					puts "cannot delete directory"
				end
			end
		end
end
