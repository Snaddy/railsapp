collection @posts
attributes :id, :caption, :speed, :images

child :user do
 	attributes :id, :username
end

node(:liked) {|post| post.liked_by?(@user)}

node(:get_likes_count) {|post| post.get_likes_count}