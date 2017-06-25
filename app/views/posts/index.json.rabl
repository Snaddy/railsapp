collection @posts
attributes :id, :speed, :caption, :images

child (:user) {attributes :username}

node(:liked) {|post| current_user.liked_by?(post)}

node(:get_likes_count) {|post| post.get_likes_count}