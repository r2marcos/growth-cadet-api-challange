module Api
  module V1
    class DnsRecordsController < ApplicationController
      # GET /dns_records
      def index

        result = DnsRecordQuery.call(included: included, excluded: excluded)

        render json: result, status: :ok
      rescue ActionController::ParameterMissing => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      # POST /dns_records
      def create
        result = ::DnsRecords::CreatorService.call(attributes: dns_record_params)

        render json: { id: result.id }, status: :created
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors }, status: :unprocessable_entity
      end

      private

      def filter_params
        params.require(:page)
        params.permit(:page, :included, :excluded)
      end

      def included
        filter_params[:included].to_s.split(',')
      end

      def excluded
        filter_params[:excluded].to_s.split(',')
      end

      def dns_record_params
        params.require(:dns_record).permit(:ip, hostnames_attributes: [:hostname])
      end
    end
  end
end
