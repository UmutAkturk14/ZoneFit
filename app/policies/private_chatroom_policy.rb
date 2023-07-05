class PrivateChatroomPolicy < ApplicationPolicy
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
    record.creator_id == user.id || record.joiner_id == user.id
  end
end
