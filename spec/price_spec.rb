require 'spec_helper'
require 'mystery_shopper/price'

RSpec.describe MysteryShopper::Price do
  subject { described_class.new(data) }

  let(:data) do
    {
      'title_id' => 70010000003782,
      'sales_status' => 'onsale',
      'regular_price' => {
        'amount' => '$9.99',
        'currency' => 'USD',
        'raw_value' => '9.99'
      },
      'discount_price' => {
        'amount' => '$5.99',
        'currency' => 'USD',
        'raw_value' => '5.99',
        'start_datetime' => '2018-11-10T17:00:00Z',
        'end_datetime' => '2018-11-30T16:59:59Z'
      }
    }
  end

  describe '#title_id' do
    it 'returns the title ID' do
      expect(subject.title_id).to eq 70010000003782
    end
  end

  describe '#sales_status' do
    it 'returns the sale status' do
      expect(subject.sales_status).to eq 'onsale'
    end
  end

  describe '#regular_price' do
    it 'returns the retail price' do
      expect(subject.regular_price).to eq 9.99
    end
  end

  describe '#discount_price' do
    it 'returns the sale price' do
      expect(subject.discount_price).to eq 5.99
    end
  end

  describe '#sale_start' do
    it 'returns the correct DateTime object' do
      expect(subject.sale_start).to eq DateTime.new(2018, 11, 10, 17)
    end
  end

  describe '#sale_end' do
    it 'returns the correct DateTime object' do
      expect(subject.sale_end).to eq DateTime.new(2018, 11, 30, 16, 59, 59)
    end
  end
end
