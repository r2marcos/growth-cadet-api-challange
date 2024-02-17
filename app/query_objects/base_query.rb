# frozen_string_literal: true

class BaseQuery
  def self.call(**args)
    new(**args).execute
  end
end
