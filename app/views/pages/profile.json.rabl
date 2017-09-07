object @user

attributes :id, :username, :name, :avatar, :bio

node :posts do
  @posts.map do |post| 
    { :id => post.id, :image => post.images }
  end
end

node(:get_posts) {|user| user.post_count}

node(:get_followings) {|user| user.following_count}

node(:get_followers) {|user| user.followers_count}

node(:is_following) {|user| current_user.following?(user)}