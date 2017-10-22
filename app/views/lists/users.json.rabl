collection @users

attributes :id, :username, :name, :avatar

node(:current_page) {|user| user.current_page}