class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, presence: true
  after_commit { CommentRelayJob.perform_later(self) }
end
