require 'spec_helper'
require 'mystery_shopper/game'
require 'mystery_shopper/price'

RSpec.describe MysteryShopper::Game do
  subject { described_class.new(data) }

  let(:data) do
    {
      'type' => 'game',
      'locale' => 'en_US',
      'url' => '/games/detail/overcooked-2-switch',
      'title' => 'Overcooked! 2',
      'description' => 'Sample description.',
      'lastModified' => 1555628882577,
      'id' => 'bMo0R6zC5D5ewf5wTc424zc7RQnDFSIp',
      'nsuid' => '70010000003402',
      'slug' => 'overcooked-2-switch',
      'boxArt' => '/content/dam/noa/en_US/games/switch/o/overcooked-2-switch/Switch_Overcooked2_box.png',
      'gallery' => '1nNjVtaDE6yijrWKfJL5ebXMPSh-mlaS',
      'platform' => 'Nintendo Switch',
      'releaseDateMask' => '2018-08-06T00:00:00.000-07:00',
      'characters' => ['Mario'],
      'categories' => %w[Strategy Party Simulation],
      'msrp' => 24.99,
      'salePrice' => 18.74,
      'esrb' => 'Everyone',
      'esrbDescriptors' => ['Users Interact'],
      'virtualConsole' => 'na',
      'generalFilters' => ['DLC available', 'Online Play via Nintendo Switch Online', 'Deals'],
      'filterShops' => ['At retail', 'On Nintendo.com'],
      'filterPlayers' => ['3+', '2+', '1+'],
      'players' => 'up to 4 players',
      'featured' => true,
      'freeToStart' => false,
      'priceRange' => '$10 - $19.99',
      'availability' => ['Available now'],
      'objectID' => '85d4db29-0a15-3924-a43b-7302d15d9f5f'
    }
  end

  before do
    allow(subject).to receive(:price_details).and_return(
      MysteryShopper::Price.new(
        'title_id' => 70_010_000_003_782,
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
      )
    )
  end

  describe '#url' do
    it 'returns the correct URL' do
      expect(subject.url).to eq 'https://www.nintendo.com/games/detail/overcooked-2-switch'
    end
  end

  describe '#title' do
    it 'returns the game title' do
      expect(subject.title).to eq 'Overcooked! 2'
    end
  end

  describe '#description' do
    it 'returns the game description' do
      expect(subject.description).to eq 'Sample description.'
    end
  end

  describe '#id' do
    it 'returns the game ID' do
      expect(subject.id).to eq 'bMo0R6zC5D5ewf5wTc424zc7RQnDFSIp'
    end
  end

  describe '#nsuid' do
    it 'returns the game NSUID' do
      expect(subject.nsuid).to eq '70010000003402'
    end
  end

  describe '#slug' do
    it 'returns the game slug' do
      expect(subject.slug).to eq 'overcooked-2-switch'
    end
  end

  describe '#front_box_art' do
    it 'returns the URL of the game box art' do
      expect(subject.front_box_art).to eq 'https://www.nintendo.com/content/dam/noa/en_US/games/switch/o/overcooked-2-switch/Switch_Overcooked2_box.png'
    end
  end

  describe '#gallery' do
    it 'returns the gallery' do
      expect(subject.gallery).to eq '1nNjVtaDE6yijrWKfJL5ebXMPSh-mlaS'
    end
  end

  describe '#platform' do
    it 'returns the game platform' do
      expect(subject.platform).to eq 'Nintendo Switch'
    end
  end

  describe '#release_date' do
    it 'returns the correct Date object' do
      expect(subject.release_date).to eq Date.new(2018, 8, 6)
    end
  end

  describe '#characters' do
    it 'returns an array of characters' do
      expect(subject.characters).to eq %w[Mario]
    end
  end

  describe '#categories' do
    it 'returns an array of categories' do
      expect(subject.categories).to eq %w[Strategy Party Simulation]
    end
  end

  describe '#esrb' do
    it 'returns the ESRB rating' do
      expect(subject.esrb).to eq 'Everyone'
    end
  end

  describe '#esrb_descriptors' do
    it 'returns an array of ESRB descriptors' do
      expect(subject.esrb_descriptors).to eq ['Users Interact']
    end
  end

  # This appears to be "na" for every result right now.
  describe '#virtual_console' do
    it 'returns "na"' do
      expect(subject.virtual_console).to eq 'na'
    end
  end

  describe '#general_filters' do
    it 'returns an array of general filters that match the game' do
      expect(subject.general_filters).to eq ['DLC available', 'Online Play via Nintendo Switch Online', 'Deals']
    end
  end

  describe '#filter_shops' do
    it 'returns an array of shop filters that match the game' do
      expect(subject.filter_shops).to eq ['At retail', 'On Nintendo.com']
    end
  end

  describe '#filter_players' do
    it 'returns an array of player filters that match the game' do
      expect(subject.filter_players).to eq ['3+', '2+', '1+']
    end
  end

  describe '#number_of_players' do
    it 'returns the number of players for the game' do
      expect(subject.number_of_players).to eq 'up to 4 players'
    end
  end

  describe '#featured?' do
    context 'when it is true' do
      it 'returns true' do
        expect(subject.featured?).to be true
      end
    end

    context 'when it is false' do
      before do
        data['featured'] = false
      end

      it 'returns false' do
        expect(subject.featured?).to be false
      end
    end
  end

  describe '#free_to_start?' do
    context 'when it is true' do
      before do
        data['freeToStart'] = true
      end

      it 'returns true' do
        expect(subject.free_to_start?).to be true
      end
    end

    context 'when it is false' do
      it 'returns false' do
        expect(subject.free_to_start?).to be false
      end
    end
  end

  describe '#price_range' do
    it 'returns the price range of the game' do
      expect(subject.price_range).to eq '$10 - $19.99'
    end
  end

  describe '#availability' do
    it 'returns an array of availability statuses' do
      expect(subject.availability).to eq ['Available now']
    end
  end

  describe '#sales_status' do
    it 'returns the sale status' do
      expect(subject.sales_status).to eq 'onsale'
    end
  end

  describe '#regular_price' do
    it "returns the game's retail price" do
      expect(subject.regular_price).to eq 9.99
    end
  end

  describe '#discount_price' do
    it "returns the game's sale price" do
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
