collection @posts
attributes :id, :speed, :caption, :images

child (:user) {attributes :username}

node(:liked) {|post| post.liked_by?(current_user)}

node(:get_likes_count) {|post| post.get_likes_count}