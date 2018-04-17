require 'initech/logger'

RSpec.describe "Logger" do
  it "returns logger object" do
    expect(Initech::Logger.logger).to_not eq nil
  end
end
