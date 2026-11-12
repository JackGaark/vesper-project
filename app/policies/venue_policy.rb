class VenuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def welcome?
    true
  end

  def index?
    true
  end

  def show?
    true
  end

  def privacy?
    true
  end
end
