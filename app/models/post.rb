class Post < ApplicationRecord
  include FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  belongs_to :user
  belongs_to :blog

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
