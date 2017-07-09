collection @posts
attributes :id, :speed, :caption, :images

child (:user) {attributes :username, :id}

node(:liked) {|post| current_user.like?(post)}

node(:posted) {|post| post.post_time}

node(:get_likes_count) {|post| post.get_likes_count}