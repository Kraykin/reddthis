# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :show, User
    return unless user.present?
    can :create, Post
    can :index, User
    return unless user.moderator? || user.admin?
    can :manage, Post
    return unless user.admin?
    can :manage, :all
  end
end
