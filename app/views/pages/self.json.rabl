object @user

attributes :id, :username, :name, :avatar, :bio, :email, :gender

child @posts do
	attributes :id, :images
end

node(:get_posts) {|user| user.post_count}

node(:get_followings) {|user| user.following_count}

node(:get_followers) {|user| user.followers_count}