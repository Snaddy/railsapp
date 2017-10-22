collection @likes

attributes :id

child (:user) {attributes :username, :name, :id, :avatar}

node(:current_page) {|like| like.current_page}