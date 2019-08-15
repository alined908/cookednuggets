class SectionPolicy < ApplicationPolicy

  def admin?
    user.present? && (user.admin? || user.moderator?)
  end
end
