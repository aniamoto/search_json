require_relative '../../services/search_service'

describe SearchService do
  let(:data) do
    [
      {
        "_id": 1,
        "name": "Raylan Givens",
        "tags": [
          "Springville",
          "Sutton"
        ]
      },
      {
        "_id": 2,
        "name": "Joni Mitchell",
        "location": {
          "city": "Melbourne"
        },
        "tags": [
          "Springville"
        ]
      }
    ]
  end
  let(:target) { 'Melbourne' }
  let(:target_not_found) { 'Nothing123' }

  describe '#perform' do
    context 'when the target is found' do
      it 'returns formatted result' do
        service = SearchService.new(data, target).perform
        line = '-' * 100 + "\n"

        expect(service).to eq([
          "Id: 2\n"\
          "Name: Joni Mitchell\n"\
          "Location: city: Melbourne\n"\
          "Tags: Springville\n"\
          "#{line}"
        ])
      end
    end

    context 'when the target is not found' do
      it "returns 'No results found' message" do
        service = SearchService.new(data, target_not_found).perform
        expect(service).to eq('No results found')
      end
    end

    context 'when the target is empty' do
      it 'returns no results' do
        service = SearchService.new(data, '').perform
        expect(service).to eq('No results found')
      end
    end
  end
end
