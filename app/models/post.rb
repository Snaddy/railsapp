class Post < ActiveRecord::Base
	validates_presence_of :images, :speed
	has_many :users, through: :likes
	has_many :likes, dependent: :destroy
	belongs_to :user
	validates_length_of :caption, :maximum => 1000, :allow_blank => true
	mount_uploaders :images, ImageUploader

	validate :image_count

	def get_likes_count
		self.likes.count
	end

	def image_count
		if images.size > 60
			errors.add(:images, "can't contain more than 60 images")
		end
	end

	def like?
		User.likes.where(:post_id => post_id).exists?
	end	
end
