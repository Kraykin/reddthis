# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    can :show, User
    can :show, Comment
    return unless user.present?
    can :create, Post
    can :index, User
    can :create, Comment
    can [:upvote, :downvote], [Post, Comment, User]
    return unless user.moderator? || user.admin?
    can :manage, Post
    can :manage, Comment
    # TODO Set up differentiation of ability in the activeadmin
    can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "moderator"
    return unless user.admin?
    can :manage, :all
    can :manage, ActiveAdmin::Page
  end
end
