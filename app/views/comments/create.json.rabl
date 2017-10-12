object @comment

attributes :id, :user_id, :post_id, :content

child (:user) {attributes :username, :avatar,}