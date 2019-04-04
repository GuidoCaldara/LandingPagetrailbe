class RunPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def edit?
    user == record.user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

end
