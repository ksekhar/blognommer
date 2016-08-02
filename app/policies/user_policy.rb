class UserPolicy < ApplicationPolicy

  attr_accessor :user, :user_object

  def initialize(user, user_objecct)
    @user = user
    @user_object = user_object
  end

  def edit?
    user.admin?
  end

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

end