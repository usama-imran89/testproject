# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    true
    # false - no one can access
  end

  def edit?
    @user&.admin?
  end

  def new?
    create?
  end

  def create?
    @user&.admin?
  end

  def update?
    @user&.admin?
  end

  def show
    true
  end

  def destroy?
    @user&.admin?
  end
end
