class Block < ActiveRecord::Base

belongs_to :user, class_name: "User"
belongs_to :blocking, class_name: "User"
validates :user_id, presence: true
validates :blocking_id, presence: true

end
