class SectionPolicy < ApplicationPolicy

  def admin?
    user.present? && (user.admin? || user.moderator?)
  end

  def destroy?
    admin?
  end

  def update?
    admin?
  end

  def create?
    admin?
  end
end
