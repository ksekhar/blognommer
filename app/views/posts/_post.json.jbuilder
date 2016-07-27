json.extract! post, :id, :title, :slug, :user_id, :content, :published, :views, :created_at, :updated_at
json.url post_url(post, format: :json)