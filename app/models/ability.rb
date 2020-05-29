# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    if user.present?
      if user.type == 'Client'

        can :create, Calculation
        can :all, System
        can :all, Post, user_id: user.id

      elsif user.type == 'Contractor'

        can :all, Offer, contractor_id: user.id
        can :read, Post

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
    # rules.map do |rule|
    #   object = { actions: rule.actions, subject: rule.subjects.map{ |s| s.is_a?(Symbol) ? s : s.name } }
    #   object[:conditions] = rule.conditions unless rule.conditions.blank?
    #   object[:inverted] = true unless rule.base_behavior
    #   object
    # end
    rules.each do |rule|
      abilities << { action: rule.actions.as_json, subjects: rule.subjects.map{ |s| s.is_a?(Symbol) ? s : s.name }, conditions: rule.conditions.as_json, inverted: !rule.base_behavior }
    end
    abilities
  end
end
