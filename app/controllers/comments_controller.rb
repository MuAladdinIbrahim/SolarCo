class CommentsController < ApiController
    before_action :set_comment, only: [:show, :update, :destroy]
    before_action :authenticate_user!, only: [:create, :update, :destroy]

    # GET /comments
    def index
      @comments = Comment.all.order(created_at: :desc)
  
      render json: @comments.as_json(methods: :user)
    end

    def indexTutorial
      @comments = Comment.where(tutorial_id: params[:id]).order(created_at: :desc)
  
      render json: @comments.as_json(methods: :user)
    end
  
    # GET /comments/1
    def show
      render json: @comment.as_json(methods: :user)
    end
  
    # POST /comments
    def create
      @comment = Comment.new(comment_params)
      @comment.user = current_user

      if @comment.save
        render json: @comment.as_json(methods: :user), status: :created, location: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /comments/1
    def update
      if @comment.update(comment_params)
        render json: @comment.as_json(methods: :user)
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /comments/1
    def destroy
      @comment.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def comment_params
        params.require(:comment).permit(:review, :user_id, :tutorial_id)
      end
end
