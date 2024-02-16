# frozen_string_literal: true

class BaseService
  def self.call(...)
    new(...).execute
  end

  def execute
    raise NotImplementedError
  end
end
