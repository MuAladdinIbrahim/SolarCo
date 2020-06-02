class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index

      puts "out of if" 
      if(current_user)
        @posts = Post.where(user_id: current_user.id)
        puts "inside user"
        if(@posts != nil)
          # render json: @posts.as_json(include: [:system,:user])
          render json: @posts.as_json(include: [{system: {
            include: { calculation: {
              except: :calculation_id
            } }
          }} , :user])
        else 
          render json: {
            data:{
              message:"no posts"
            }
          }
        end
      end
      if(current_contractor)
        @posts = Post.all
        puts "inside contractor"
        if(@posts != nil)
          puts "inside if in contractor"
          # render json: @posts.as_json(include: [:system,:user])
          render json: @posts.as_json(include: [{system: {
            include: { calculation: {
              except: :calculation_id
            } }
          }} , :user])
          else 
            render json: {
              data:{
                message:"no posts"
              }
            }
          end
      end

  end

  # GET /posts/1
  def show
    # render json: @post.as_json(include: [:system,:user])
    if current_contractor || can?(:read, @post)
      render json: @post.as_json(include: [{system: {
        include: { calculation: {
          except: :calculation_id
        } }
      }} , :user])
    else
      render json: {:error => "You are not authorized to view this post"}, status: :unauthorized
    end
  end

  # POST /posts
  def create
    if can?(:create, Post)
      @post = Post.new(post_params)
      @post.user = User.find(current_user.id)
      @post.system = System.find(post_params['system_id'])

      if @post.save
        render json: @post, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: {:error => "You are not authorized to create post"}, status: :unauthorized
    end
  end

  # PATCH/PUT /posts/1
  def update
    if can?(:update, @post)
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: {:error => "You are not authorized to update this post"}, status: :unauthorized
    end
  end

  # DELETE /posts/1
  def destroy
    if can?(:destroy, @post)
      @post.destroy
    else
      render json: {:error => "You are not authorized to delete this post"}, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title,:description,:system_id)
    end
end
