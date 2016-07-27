json.extract! blog, :id, :name, :slug, :active, :visitors, :user_id, :created_at, :updated_at
json.url blog_url(blog, format: :json)