class ForumPostPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.present? && ((user == record.user) || user.admin? || user.moderator?)
  end

  def destroy?
    user.present? && (user.admin? || user.moderator?)
  end
end
