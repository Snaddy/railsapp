object @user

attributes :id, :username, :name, :avatar, :bio

child @posts do
	attributes :id, :images
end

node(:get_posts) {|user| user.post_count}

node(:get_followings) {|user| user.following_count}

node(:get_followers) {|user| user.followers_count}

node(:is_following) {|user| current_user.is_following}