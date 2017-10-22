object @user

attributes :id, :username, :name, :avatar, :bio

child @posts => :posts do
	attributes :id, :images
	node(:current_page) {|post| post.current_page}
end

node(:get_posts) {|user| user.post_count}

node(:get_followings) {|user| user.following_count}

node(:get_followers) {|user| user.followers_count}

node(:is_following) {|user| current_user.following?(user)}

node(:is_blocking) {|user| current_user.blocking?(user)}

node(:is_blocked) {|user| user.blocking?(current_user)}