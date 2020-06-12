class NotificationController < ApiController

  def index
    if current_user
      puts current_user.id
      @user_posts = Post.where(user_id: current_user.id)
      @post_offers = Offer.where(post_id: @user_posts.ids)

      @notifications = PublicActivity::Activity.order("created_at DESC").where("(recipient_type = ? AND trackable_type = ? AND recipient_id = ?) OR (owner_type = ? AND trackable_type =? AND trackable_id IN (?))", "User", "Message", current_user.id, "Contractor", "Offer", @post_offers.ids.each {|id| id.to_s + ','}).all

    elsif current_contractor
      @contractor_offers_ = Offer.where(contractor_id: current_contractor.id)

      @offers_posts = []
      @contractor_offers_.each do |e| 
        @offers_posts.push(Post.find(e.post_id).id)
      end

      @notifications = PublicActivity::Activity.order("created_at DESC").where("(recipient_type = ? AND trackable_type = ? AND recipient_id = ?) OR (owner_type = ? AND trackable_type = ? AND trackable_id IN (?))", "Contractor", "Message", current_contractor.id, "User", "Post", @offers_posts.each {|id| id.to_s + ','}).all

      # @chatNotifications = PublicActivity::Activity.order("created_at DESC").where(recipient_type: "Contractor", trackable_type: "Message", recipient_id: current_contractor.id ).all

      # @notifications = PublicActivity::Activity.order("created_at DESC").where(owner_type: "User", trackable_type: "Post", trackable_id: @offers_posts.each do |i| i end).all

      # @notifications += @chatNotifications
    end
    render json: {data: @notifications.as_json(include: [:trackable, :owner])}
  end

  def show
    @notification = PublicActivity::Activity.find(params[:id])
    render json: @notification
  end
end