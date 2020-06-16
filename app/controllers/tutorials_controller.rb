class TutorialsController < ApiController
    before_action :set_tutorial, only: [:show, :update, :destroy]
    before_action :authenticate_contractor!, only: [:create , :update, :destroy]

    # GET /tutorials
    def index
      @tutorials = Tutorial.all.order(created_at: :desc)
  
      render json: @tutorials.as_json(methods: [:contractor, :category])
    end

    # GET /tutorialsByCategory
    def indexCategory
      @tutorials = Tutorial.where(category_id: params[:id]).order(created_at: :desc)
  
      render json: @tutorials.as_json(methods: [:contractor, :category])
    end

    # GET /tutorialsByContractor
    def indexContractor
      @tutorials = Tutorial.where(contractor_id: params[:id]).order(created_at: :desc)
  
      render json: @tutorials.as_json(methods: [:contractor, :category])
    end
  
    # GET /tutorials/1
    def show
      render json: @tutorial.as_json(methods: [:contractor, :category])
    end
  
    # POST /tutorials
    def create
      @tutorial = Tutorial.new(tutorial_params)
      @tutorial.contractor = current_contractor
      @tutorial.category = Category.find_by(category: params[:category])
  
      if @tutorial.save
        render json: @tutorial, status: :created, location: @tutorial
      else
        render json: @tutorial.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /tutorials/1
    def update
      if @tutorial.update(tutorial_params)
        render json: @tutorial
      else
        render json: @tutorial.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /tutorials/1
    def destroy
      @tutorial.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tutorial
        @tutorial = Tutorial.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def tutorial_params
        params.require(:tutorial).permit(:id, :title, :body, :category)
      end
end