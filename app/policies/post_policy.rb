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
    user.blogger? && user.id == post.user.id
  end

  def author?
    user.id == post.user.id
  end

  def update?
    user.blogger? && user.id == post.user.id
  end

  def destroy?
    user.blogger? && user.id == post.user.id
  end

  class Scope
    attr_accessor :user, :scope, :blog

    def initialize(user, scope, blog)
      @user = user
      @scope = scope
      @blog = blog
    end

    def resolve
      if user.present? && user.blogger? && user.id == blog.user.id
        scope
      else
        scope.where(published: true)
      end
    end
  end

end
