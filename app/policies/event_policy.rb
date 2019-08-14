class EventPolicy < ApplicationPolicy
  def create?
    user.present? && (user.admin? || user.moderator?)
  end
end
