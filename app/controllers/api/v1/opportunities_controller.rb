module Api
  module V1
    class OpportunitiesController < ApplicationController
      include Pagy::Backend

      def index
        result = Opportunities::SearchService.call(
          search: params[:search],
          page: params[:page],
          salary: params[:salary]
        )

        if result.success?
          pagy, records = result.data

          render json: {
            data: records.as_json(include: { client: { only: [ :name ] } }),
            meta: pagy_metadata(pagy)
          }
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def create
        result = Opportunities::CreateService.new(
          client_id: params[:client_id],
          params: opportunity_params
        ).call

        if result.success?
          render json: result.data, status: :created
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def apply
        Opportunities::ApplyService.new(
          opportunity_id: params[:id],
          job_seeker_id: params[:job_seeker_id]
        ).call

        render json: { message: "Application submitted" }, status: :ok
      end

      private

      def opportunity_params
        params.require(:opportunity).permit(:title, :description, :salary)
      end
    end
  end
end
