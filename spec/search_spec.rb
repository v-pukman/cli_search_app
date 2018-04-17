require 'initech/logger'
require 'initech/search'


RSpec.describe "Search" do
  let(:search) { Initech::Search.new }
  let(:file_path) { File.join('spec', 'fixtures', 'files', "users.json") }

  describe "#parse_file" do
    it "returns parsed data" do
      result = search.parse_file file_path
      expect(result.is_a?(Array)).to eq true
    end
    context "when file not found:" do
      it "writes to the logger" do
        allow(File).to receive(:read).and_raise(Errno::ENOENT)
        expect(search).to receive(:logger).and_return(double(error: ""))
        search.parse_file file_path
      end
    end
    context "when file parse error:" do
      it "writes to the logger" do
        allow(JSON).to receive(:parse).and_raise(JSON::ParserError)
        expect(search).to receive(:logger).and_return(double(error: ""))
        search.parse_file file_path
      end
    end
  end

  describe "#search" do
    let(:json_data) { search.parse_file file_path }
    let(:key) { "_id" }
    let(:value) { "4" }
    it "searches item by key and value" do
      result = search.search json_data, key, value
      expect(result.is_a?(Array)).to eq true
      expect(result[0][key].to_s).to eq value.to_s
    end
  end

  describe "#start" do
    let(:key) { "_id" }
    let(:value) { "4" }
    it "calls parse_file" do
      expect(search).to receive(:parse_file).and_return([])
      search.start file_path, key, value
    end
    it "calls search" do
      expect(search).to receive(:search).and_return([])
      search.start file_path, key, value
    end
  end

end
