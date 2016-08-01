class CommentPolicy < ApplicationPolicy

  attr_accessor :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    @user.present?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
