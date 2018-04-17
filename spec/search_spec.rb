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

end
