class SystemsController < ApplicationController
  before_action :set_system, only: [:show, :update, :destroy]

  # GET /systems
  def index
    @systems = System.all

    render json: @systems
  end

  # GET /systems/1
  def show
    render json: @system
  end

  # POST /systems
  def create
    @system = System.new(system_params)

    if @system.save
      render json: @system, status: :created, location: @system
    else
      render json: @system.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /systems/1
  def update
    if @system.update(system_params)
      render json: @system
    else
      render json: @system.errors, status: :unprocessable_entity
    end
  end

  # DELETE /systems/1
  def destroy
    @system.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def system_params
      params.fetch(:system, {})
    end
end
