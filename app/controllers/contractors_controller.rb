class ContractorsController < ApplicationController
    before_action :set_user, only: [:update]

    # PATCH/PUT /contractors/1
    def update
        if @contractor.update(contractor_params)
            render json: @contractor
        else
            render json: @contractor.errors, status: :unprocessable_entity
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @contractor = Contractor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contractor_params
        params.fetch(:contractor, {})
    end
end
