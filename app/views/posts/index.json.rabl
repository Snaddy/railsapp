collections @posts
attributes :id, :caption, :speed, :images

child(:user) { attributes :id, :username}

node(:liked) {|post| post.liked_by?(@user)}

node(:get_likes_count) {|post| post.get_likes_count}