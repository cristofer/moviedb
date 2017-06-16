class MoviePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user
  end

  def destroy?
    user && record.user == user
  end

  def update?
    destroy?
  end

  def rate?
    user
  end

  def search?
    true
  end
end
