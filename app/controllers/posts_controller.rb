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
    render json: @post.as_json(include: [{system: {
      include: { calculation: {
        except: :calculation_id
      } }
    }} , :user])
  end

  # POST /posts
  def create

    @post = Post.new(post_params)
    @post.user = User.find(current_user.id)
    @post.system = System.find(post_params['system_id'])

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
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
