class PartecipantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    Partecipant.where(run: record.run ).where(user: user).empty?
  end

  def destroy?
    Partecipant.where(run: record.run ).where(user: user).any?
  end



end
