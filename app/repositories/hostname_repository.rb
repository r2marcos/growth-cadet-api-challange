# frozen_string_literal: true

class HostnameRepository
  attr_reader :model

  def initialize(model = {})
    @model = model.fetch(:hostname) { Hostname }
  end

  def find_or_create_by(attributes:)
    model.find_or_create_by(attributes)
  end
end
