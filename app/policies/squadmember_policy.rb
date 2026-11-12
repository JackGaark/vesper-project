class SquadmemberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def confirm_squad_member?
    record.user == user
  end

  def member_choose_venue?
    record.user == user
  end

  def member_confirm_venue?
    record.user == user
  end

  def member_choose_contribution?
    record.user == user
  end

  def member_confirm_contribution?
    record.user == user
  end

  def choose_venue_status?
    record.user == user
  end

end
