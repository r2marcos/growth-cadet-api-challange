# frozen_string_literal: true

class DnsRecordRepository
  attr_reader :model

  def initialize(model = {})
    @model = model.fetch(:dns_record) { DnsRecord }
  end

  def create!(attributes:)
    model.create!(attributes)
  end
end
