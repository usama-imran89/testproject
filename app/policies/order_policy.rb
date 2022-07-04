# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @user&.role == 'admin'
        scope.all
      else
        scope.where(user_id: @user.id)
      end
    end
  end

  def edit?
    @user&.admin?
  end

  def update?
    @user&.admin?
  end

  def change_status?
    @user&.admin?
  end
end
