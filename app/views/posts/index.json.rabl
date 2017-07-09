collection @posts
attributes :id, :speed, :caption, :images

child (:user) {attributes :username, :id}

node(:liked) {|post| current_user.like?(post)}

node(:get_likes_count) {|post| post.get_likes_count}

node(:posted) {|post| post.created_at.to_i}