class PostsController < ApiController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :destroy]
  # before_action :authenticate_contractor!, only: [:update]
  self.page_cache_directory = :domain_cache_directory
  caches_page :index 

  # GET /posts
  def index
    if current_contractor || current_user
      if(current_user)
        @posts = Post.where(user_id: current_user.id, closed: false).order(created_at: :desc)
        if(approved_params['closed'] == 'closed')
           @posts = Post.where(user_id: current_user.id, closed: true).order(created_at: :desc)
        end
      elsif(current_contractor)
        @posts = Post.where(closed: false).order(created_at: :desc)
      end
      if(@posts != nil)
        render json: @posts.as_json(include: [{system: {
          include: { calculation: {except: :calculation_id} }}}, :user])
      else 
        render json: {
          data:{
            message:"no posts"
          }
        }
      end
    else
      render json: {:error => "You need to sign in or sign up before continuing."}, status: :unauthorized
    end
  end

  # GET /posts/1
  def show
    # render json: @post.as_json(include: [:system,:user])
    if current_contractor || can?(:read, @post)
      render json: @post.as_json(include: [{ system: {
        include: { calculation: {except: :calculation_id} }} }, :user, :offers])
    else
      render json: {:error => "You are not authorized to view this post"}, status: :unauthorized
    end
  end

  # POST /posts
  def create
    # if can?(:create, Post)
      @post = Post.new(post_params)
      @post.user = User.find(current_user.id)
      @post.system = System.find(post_params['system_id'])

      if @post.save
        render json: @post, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    # else
      # render json: {:error => "You are not authorized to create post"}, status: :unauthorized
    # end
  end

  # PATCH/PUT /posts/1
  def update
    if can?(:update, @post) || current_contractor
      if @post.closed
        render json: {:error => "Archieved Post can not be updated"}
      end
      unless @post.closed
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end
    else
      render json: {:error => "You are not authorized to update this post"}, status: :unauthorized
    end
  end

  # DELETE /posts/1
  def destroy
    if @post.closed
      render json: {:error => "Archieved Post can not be Deleted"}
    end
    unless @post.closed
      if can?(:destroy, @post)
        @post.destroy
      else
        render json: {:error => "You are not authorized to delete this post"}, status: :unauthorized
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title,:description,:system_id, :closed)
    end

    def approved_params
      params.permit(:closed)
    end

    def domain_cache_directory
      Rails.root.join("public", request.domain)
    end
end
