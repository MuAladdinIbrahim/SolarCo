class LikesController < ApiController
    before_action :set_like, only: [:show, :update, :destroy]

    # GET /likes
    def index
      @likes = Like.all.order(created_at: :desc)
  
      render json: @likes.as_json(methods: :user)
    end
  
    # GET /likes
    def indexTutorial
      @likes = Like.where(tutorial_id: params[:id]).order(created_at: :desc)
  
      render json: @likes.as_json(methods: :user)
    end

    # GET /likes/1
    def show
      render json: @like.as_json(methods: :user)
    end
  
    # POST /likes
    def create
      @like = Like.new(like_params)
      @like.user = current_user
  
      if @like.save
        render json: @like.as_json(methods: :user), status: :created, location: @like
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /likes/1
    def update
      if @like.update(like_params)
        render json: @like.as_json(methods: :user)
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /likes/1
    def destroy
      @like.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_like
        @like = Like.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def like_params
        params.require(:like).permit(:id, :islike, :tutorial_id)
      end
end
