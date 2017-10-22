object @post

attributes :speed, :caption, :images

child (:user) {attributes :username, :id, :avatar}

child (:comments) => :comments do
	attributes :id, :content
	child (:user) {attributes :username, :id, :avatar}
	node(:posted_at) {|comment| comment.created_at.to_i}
end

node(:liked) {|post| current_user.like?(post)}

node(:get_likes_count) {|post| post.get_likes_count}

node(:get_comment_count) {|post| post.get_comment_count}

node(:posted) {|post| post.created_at.to_i}