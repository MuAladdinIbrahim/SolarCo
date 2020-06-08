class NotificationController < ApplicationController

  def index
    @notifications = PublicActivity::Activity.order("created_at DESC").all#where(owner_type: "user", owner_id: current_user.id).all
    render json: @notifications
  end

  def yours
    @notifications = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User", owner_id: current_user).all
    render json: @notifications
  end

  def show
    @notofication = PublicActivity::Activity.find(params[:id])
    render json: @notification
  end
end