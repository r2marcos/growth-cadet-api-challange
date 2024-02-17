# spec/models/dns_record_spec.rb

require 'rails_helper'

RSpec.describe Hostname, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:dns_records) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:hostname) }

    it { should validate_presence_of(:hostname) }
    it { should validate_uniqueness_of(:hostname) }
  end
end
