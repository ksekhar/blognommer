class BlogPolicy < ApplicationPolicy

  attr_accessor :user, :blog

  def initialize(user, blog)
    @user = user
    @blog = blog
  end

  def create?
    user.blogger?
  end

  def update?
    user.blogger? && user.id == blog.user.id
  end

  def new?
    user.blogger?
  end

  def edit?
    user.blogger? && user.id == blog.user.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
