# frozen_string_literal: true

module DnsRecords
  # DnsRecords::CreatorService
  class CreatorService < BaseService
    attr_reader :attributes

    def initialize(attributes:, klasses: {})
      @attributes = attributes
      @dns_record_repository = klasses.fetch(:dns_record_repository) { DnsRecordRepository.new }
      @hostname_repository = klasses.fetch(:hostname_repository) { HostnameRepository.new }
    end

    def execute
      create
    end

    private

    def create
      ActiveRecord::Base.transaction do
        @dns_record_repository.create!(attributes: {
          ip_address: ip_address,
          hostnames: hostnames
        })
      end
    end

    def ip_address
      attributes[:ip]
    end

    def hostnames
      attributes[:hostnames_attributes].map do |hostname_attributes|
        @hostname_repository.find_or_create_by(attributes: { hostname: hostname_attributes[:hostname] })
      end
    end
  end
end