# frozen_string_literal: true

class DnsRecord < ApplicationRecord
  # Associations
  has_and_belongs_to_many :hostnames

  # Validations
  validates :ip_address, presence: true, uniqueness: true
end