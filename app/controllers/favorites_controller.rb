class FavoritesController < ApiController
  before_action :set_favorite, only: [:update, :update, :destroy]
  before_action :authenticate_user!

  # GET /favorites
  def index
    @favorites = Favorite.all.order(created_at: :desc)

    render json: @favorites
  end

  # GET /favorites
  def indexUser
    @favorites = Favorite.where(user_id: current_user.id).order(created_at: :desc)

    render json: @favorites.as_json(include: [ {tutorial: {methods: [:category, :contractor]}}, :user])
  end
  # .as_json(methods: [:contractor, :category])
  # GET /favorites/1
  def show
    render json: @favorite
  end

  # POST /favorites
  def create
    if Favorite.find_by(user_id: current_user.id, tutorial_id: favorite_params[:tutorial_id]).nil?
      @favorite = Favorite.new(favorite_params)
      @favorite.tutorial = Tutorial.find(favorite_params[:tutorial_id])
      @favorite.user = current_user

      if @favorite.save
        render json: @favorite, status: :created, location: @favorite
      else
        render json: @favorite.errors, status: :unprocessable_entity
      end
    else
        render json: {"exist" => "This Tutorial already in favorite!"}
    end
  end

  # PATCH/PUT /favorites/1
  def update
    if @favorite.update(favorite_params)
      render json: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorites/1
  def destroy
    @favorite.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find_by(user_id: current_user.id, tutorial_id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def favorite_params
      params.require(:favorite).permit(:user_id, :tutorial_id)
    end
end
