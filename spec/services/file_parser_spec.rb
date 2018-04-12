require_relative '../../services/file_parser'

describe FileParser do
  let(:path) { 'spec/fixtures/files/' }

  describe '#perform' do
    context 'when the file is found' do
      it 'returns parsed file' do
        parser = FileParser.new(path + 'users.json').perform
        expect(parser.first).to include("name"=>"Raylan Givens")
      end
    end

    context 'when the file is not found' do
      it "returns error message" do
        parser = FileParser.new('').perform
        expect(parser).to eq("Cannot find file '' :-(")
      end
    end

    context 'when the file format is not supported' do
      it 'returns error message' do
        parser = FileParser.new(path + 'invalid.txt').perform
        expect(parser).to eq('This file format is not supported')
      end
    end
  end
end
