class OfficialPolicy < ApplicationPolicy
  def create?
    user.present? && (user.moderator? || user.admin?)
  end

  def update?
    user.present? && (user.moderator? || user.admin?)
  end

  def destroy?
    user.present? && (user.moderator? || user.admin?)
  end
end
