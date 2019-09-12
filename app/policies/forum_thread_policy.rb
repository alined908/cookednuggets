class ForumThreadPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def destroy?
    user.present? && (user.admin? || user.moderator?)
  end

  def update?
    user.present? && (user.admin? || user.moderator?)
  end
end
