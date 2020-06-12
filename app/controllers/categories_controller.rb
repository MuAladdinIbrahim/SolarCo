class CategoriesController < ApiController
    before_action :set_category, only: [:show, :update, :destroy]

    # GET /categorys
    def index
      @categorys = Category.all.order(created_at: :desc)
  
      render json: @categorys
    end
  
    # GET /categorys/1
    def show
      render json: @category
    end
  
    # POST /categorys
    def create
      @category = Category.new(category_params)
  
      if @category.save
        render json: @category, status: :created, location: @category
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /categorys/1
    def update
      if @category.update(category_params)
        render json: @category
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /categorys/1
    def destroy
      @category.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = Category.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def category_params
        params.fetch(:category, {})
      end    
end
