class NotificationController < ApiController

  def index
    if current_user
      @user_posts = Post.where(user_id: current_user.id)
      @post_offers = Offer.where(post_id: @user_posts.ids)
      @notifications = PublicActivity::Activity.order("created_at DESC").where(owner_type: "Contractor", trackable_type: "Offer", trackable_id: @post_offers.ids ).all
    elsif current_contractor
      @contractor_offers_ = Offer.select(:post_id).where(contractor_id: current_contractor.id)
      @offers_posts = Post.where(id: @contractor_offers)
      @notifications = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User", trackable_type: "Post", trackable_id: @offers_posts.ids).all
    end
    render json: @notifications.as_json(include: [:trackable,:owner])
  end

  def show
    @notofication = PublicActivity::Activity.find(params[:id])
    render json: @notification
  end
end