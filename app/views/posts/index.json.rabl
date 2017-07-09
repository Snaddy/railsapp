collection @posts
attributes :id, :speed, :caption, :images, :created_at

child (:user) {attributes :username, :id}

node(:liked) {|post| current_user.like?(post)}

node(:get_likes_count) {|post| post.get_likes_count}