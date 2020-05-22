class CalculationsController < ApplicationController
  before_action :set_calculation, only: [:show, :update, :destroy]

  # GET /calculations
  def index
    @calculations = Calculation.all

    render json: @calculations
  end

  # GET /calculations/1
  def show
    render json: @calculation
  end

  # POST /calculations
  def create
    @calculation = Calculation.new(calculation_params)

    if @calculation.save
      render json: @calculation, status: :created, location: @calculation
    else
      render json: @calculation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /calculations/1
  def update
    if @calculation.update(calculation_params)
      render json: @calculation
    else
      render json: @calculation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /calculations/1
  def destroy
    @calculation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculation
      @calculation = Calculation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def calculation_params
      params.fetch(:calculation, {})
    end
end
