class PostPolicy < ApplicationPolicy

  attr_accessor :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def new?
    user.blogger?
  end

  def create?
    user.blogger?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
