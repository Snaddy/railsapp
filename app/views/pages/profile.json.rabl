object @user

attributes :id, :username, :name, :avatar, :bio

child @posts => :posts do
	attributes :id, :images
end

node(:get_posts) {|user| user.post_count}

node(:get_followings) {|user| user.following_count}

node(:get_followers) {|user| user.followers_count}

node(:is_following) {|user| current_user.following?(user)}

node(:is_blocking) {|user| user.blocking?(current_user)}