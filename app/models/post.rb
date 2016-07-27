class Post < ApplicationRecord
  include FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  belongs_to :user
  belongs_to :blog
end
