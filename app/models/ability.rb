# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    if user.present?
      if user.instance_of? Client
        can [:read, :update, :destroy], Calculation
        can :create, Calculation
        can [:read, :update, :destroy], System, user_id: user.id
        can :create, System
        can [:update, :destroy, :read], Post, user_id: user.id
        can :create, Post
        
        can :update, Offer
        can [:update, :destroy], OfferRate, user_id: user.id
        can [:update, :destroy], OfferReview, user_id: user.id
        can [:update, :destroy], Like, user_id: user.id
        can [:update, :destroy], Comment, user_id: user.id
        can [:update, :destroy], Favorite, user_id: user.id
        can :create, OfferRate
        can :create, OfferReview
        can :create, Like
        can :create, Comment
        can :create, Favorite

      elsif user.instance_of? Contractor

        can :read, Calculation
        can :read, System
        can :read, Post
        can [:update, :destroy], Offer, contractor_id: user.id
        can :create, Offer
        can [:update, :destroy], Tutorial, contractor_id: user.id
        can :create, Tutorial

      end
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

  def as_json
    abilities = []
    rules.each do |rule|
      abilities << { action: rule.actions.as_json, subject: rule.subjects.map{ |s| s.is_a?(Symbol) ? s : s.name }, conditions: rule.conditions.as_json, inverted: !rule.base_behavior }
    end
    abilities
  end
end
