class Blog < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
