class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.is_partecipant?(record.run)
  end
  def edit?
    record.user == user && user.is_partecipant?(record.run)
  end

    def destroy?
      record.user == user
    end

    def update?
      edit?
    end

end
