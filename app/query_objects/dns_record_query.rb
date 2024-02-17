# frozen_string_literal: true

class DnsRecordQuery < BaseQuery
  attr_reader :included, :excluded

  def initialize(included:, excluded:, klasses: {})
    @included = included
    @excluded = excluded
    @relation = klasses.fetch(:relation) { DnsRecord }
  end

  def execute
    {
      records: records,
      related_hostnames: related_hostnames,
      total_records: records.count
    }
  end

  private

  def records
    dns_records.pluck(:id, :ip_address)
  end

  def related_hostnames
    related_hostnames_query.map do |hostname|
      {
        count: hostname.dns_records.count,
        hostname: hostname.hostname
      }
    end
  end

  def dns_records
    included_dns_records.reject { |dns_record| dns_record.hostnames.any? { |hostname| excluded.include?(hostname.hostname) } }
  end

  def included_dns_records
    return @relation.joins(:hostnames).group('dns_records.id') if included.blank?

    @relation.joins(:hostnames)
      .where(hostnames: { hostname: included })
      .group('dns_records.id')
      .having('COUNT(DISTINCT hostnames.hostname) = ?', included.size)
  end

  def related_hostnames_query
    related_hostnames = dns_records.map { |dns_record| dns_record.hostnames }.flatten.uniq
    related_hostnames.reject { |hostname| included.include?(hostname.hostname) }
  end
end