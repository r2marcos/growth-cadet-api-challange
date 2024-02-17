# spec/models/dns_record_spec.rb

require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:hostnames) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:dns_record) }

    it { should validate_presence_of(:ip_address) }
    it { should validate_uniqueness_of(:ip_address) }
  end
end
