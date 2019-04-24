require 'spec_helper'
require 'mystery_shopper/response'

RSpec.describe MysteryShopper::Response do
  subject { described_class.new(data) }

  let(:data) do
    {
      'results' => [
        { 'hits' => [
          {
            'type' => 'game',
            'locale' => 'en_US',
            'url' => '/games/detail/overcooked-2-switch',
            'title' => 'Overcooked! 2',
            'description' => 'Sample description.',
            'lastModified' => 1555628882_577,
            'id' => 'bMo0R6zC5D5ewf5wTc424zc7RQnDFSIp',
            'nsuid' => '70010000003402',
            'slug' => 'overcooked-2-switch',
            'boxArt' => '/content/dam/noa/en_US/games/switch/o/overcooked-2-switch/Switch_Overcooked2_box.png',
            'gallery' => '1nNjVtaDE6yijrWKfJL5ebXMPSh-mlaS',
            'platform' => 'Nintendo Switch',
            'releaseDateMask' => '2018-08-06T00:00:00.000-07:00',
            'characters' => [],
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
        ] }
      ]
    }
  end

  describe '#games' do
    it 'returns an array of Game objects' do
      expect(subject.games.size).to eq 1
    end
  end
end
