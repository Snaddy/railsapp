object @user

attributes :id, :username, :name, :avatar, :bio, :email

child @posts do
	attributes :id, :images
end

if(current_user != @user)
	node(:is_following) {|user| current_user.following?(user)}
end

node(:get_posts) {|user| user.post_count}

node(:get_followings) {|user| user.following_count}

node(:get_followers) {|user| user.followers_count}git 