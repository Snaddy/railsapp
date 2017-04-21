json.extract! post, :id, :caption, :images, :created_at, :updated_at
json.url post_url(post, format: :json)