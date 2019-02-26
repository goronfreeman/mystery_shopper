require 'spec_helper'
require 'mystery_shopper/game'
require 'mystery_shopper/price'

RSpec.describe MysteryShopper::Game do
  subject { described_class.new(data) }

  let(:data) do
    {
      'categories' => { 'category' => %w[Arcade Multiplayer Party Puzzle] },
      'slug' => 'breakforcist-battle-switch',
      'buyitnow' => 'false',
      'release_date' => 'Apr 12, 2018',
      'digitaldownload' => 'false',
      'nso' => 'false',
      'free_to_start' => 'false',
      'title' => '#Breakforcist Battle',
      'system' => 'Nintendo Switch',
      'id' => 'oNfMa9bCbSistTheDdqCtqZ3Lwk_WBw8',
      'ca_price' => '12.99',
      'number_of_players' => 'up to 4 players',
      'nsuid' => '70010000003782',
      'eshop_price' => '9.99',
      'front_box_art' => 'https://media.nintendo.com/nintendo/bin/S9233-zQTduo1uWckvUcVqikBSFMUzxZ/7hWl7WrFj-twgIgF1fB6a8Y74qMEGm59.png',
      'game_code' => 'HACNAK98A',
      'buyonline' => 'true'
    }
  end

  before do
    allow(subject).to receive(:price_details).and_return(
      MysteryShopper::Price.new(
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
      )
    )
  end

  describe '#categories' do
    context 'when there is only one category' do
      before do
        data['categories']['category'] = 'Arcade'
      end

      it 'returns an array of categories' do
        expect(subject.categories).to eq ['Arcade']
      end
    end

    context 'when there are multiple categories' do
      it 'returns an array of categories' do
        expect(subject.categories).to eq %w[Arcade Multiplayer Party Puzzle]
      end
    end
  end

  describe '#url' do
    it 'returns the correct URL' do
      expect(subject.url).to eq 'https://www.nintendo.com/games/detail/breakforcist-battle-switch'
    end
  end

  describe '#buy_it_now?' do
    context 'when it is "true"' do
      before do
        data['buyitnow'] = 'true'
      end

      it 'returns true' do
        expect(subject.buy_it_now?).to be true
      end
    end

    context 'when it is "false"' do
      it 'returns false' do
        expect(subject.buy_it_now?).to be false
      end
    end
  end

  describe '#release_date' do
    it 'returns the correct Date object' do
      expect(subject.release_date).to eq Date.new(2018, 4, 12)
    end
  end

  describe '#digital_download?' do
    context 'when it is "true"' do
      before do
        data['digitaldownload'] = 'true'
      end

      it 'returns true' do
        expect(subject.digital_download?).to be true
      end
    end

    context 'when it is "false"' do
      it 'returns false' do
        expect(subject.digital_download?).to be false
      end
    end
  end

  describe '#free_to_start?' do
    context 'when it is "true"' do
      before do
        data['free_to_start'] = 'true'
      end

      it 'returns true' do
        expect(subject.free_to_start?).to be true
      end
    end

    context 'when it is "false"' do
      it 'returns false' do
        expect(subject.free_to_start?).to be false
      end
    end
  end

  describe '#title' do
    it 'returns the game title' do
      expect(subject.title).to eq '#Breakforcist Battle'
    end
  end

  describe '#slug' do
    it 'returns the game slug' do
      expect(subject.slug).to eq 'breakforcist-battle-switch'
    end
  end

  describe '#system' do
    it 'returns the game system' do
      expect(subject.system).to eq 'Nintendo Switch'
    end
  end

  describe '#id' do
    it 'returns the game ID' do
      expect(subject.id).to eq 'oNfMa9bCbSistTheDdqCtqZ3Lwk_WBw8'
    end
  end

  describe '#number_of_players' do
    it 'returns the number of players for the game' do
      expect(subject.number_of_players).to eq 'up to 4 players'
    end
  end

  describe '#nsuid' do
    it 'returns the game NSUID' do
      expect(subject.nsuid).to eq '70010000003782'
    end
  end

  describe '#video_link' do
    context 'when the video link is present' do
      before do
        data['video_link'] = '82azBzZzE6_Yl-SGf4PVOtshsLwPpD1H'
      end

      it 'returns the game video link' do
        expect(subject.video_link).to eq '82azBzZzE6_Yl-SGf4PVOtshsLwPpD1H'
      end
    end

    context 'when the video link is missing' do
      it 'returns nil' do
        expect(subject.video_link).to be nil
      end
    end
  end

  describe '#front_box_art' do
    it 'returns the URL of the game box art' do
      expect(subject.front_box_art).to eq 'https://media.nintendo.com/nintendo/bin/S9233-zQTduo1uWckvUcVqikBSFMUzxZ/7hWl7WrFj-twgIgF1fB6a8Y74qMEGm59.png'
    end
  end

  describe '#game_code' do
    it 'returns the game game code' do
      expect(subject.game_code).to eq 'HACNAK98A'
    end
  end

  describe '#buy_online?' do
    context 'when it is "true"' do
      it 'returns true' do
        expect(subject.buy_online?).to be true
      end
    end

    context 'when it is "false"' do
      before do
        data['buyonline'] = 'false'
      end

      it 'returns false' do
        expect(subject.buy_online?).to be false
      end
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
