class Blog < ApplicationRecord
  include FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :user
  has_many :posts, dependent: :destroy
  default_scope -> { where(active: true) }

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  def deactivate!
    update(active: false)
  end
end
