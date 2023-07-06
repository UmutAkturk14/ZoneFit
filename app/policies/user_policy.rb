class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    !user.nil?
  end

  def show?
    true
  end

  def edit?
    record == user
  end

  def update?
    edit?
  end

  def message?
    !user.nil?
  end

  def friend?
    !user.nil?
  end

  def unfriend?
    !user.nil?
  end
end
