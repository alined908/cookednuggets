class UserPolicy < ApplicationPolicy
  def index?
    user.present? && (user.moderator? || user.admin?)
  end

  def destroy?
    index? 
  end
end
