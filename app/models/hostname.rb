# frozen_string_literal: true

class Hostname < ApplicationRecord
  # Associations
  has_and_belongs_to_many :dns_records

  # Validations
  validates :hostname, presence: true, uniqueness: true
end