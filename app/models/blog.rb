class Blog < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :user
  has_many :posts, dependent: :destroy
end
