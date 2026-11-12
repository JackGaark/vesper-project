class SquadPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none unless user
      scope.left_joins(:squadmembers).where('squads.user_id = :id OR squadmembers.user_id = :id', id: user.id).distinct
    end
  end

  def create?; user.present?; end
  def show?; user.present? && (record.user_id == user.id || record.squadmembers.exists?(user_id: user.id)); end
  def update?; user.present? && record.user_id == user.id; end
  alias_method :add_sidekick?, :update?
  alias_method :update_package?, :update?
  alias_method :confirm_squad_order?, :update?
end
