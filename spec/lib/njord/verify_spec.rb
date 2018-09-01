describe Njord::Verify do
  context "when ip returned is the same" do
    before do
      stub_request(:get, "http://api.ipify.org/")
        .to_return(status: 200, body: "200.6.140.115", headers: {})
    end

    it "returns true" do
      result = Njord::Verify.call("200.6.140.115", 80, 123)
      expect(result).to be_truthy
    end
  end

  context "when ip returned is different" do
    before do
      stub_request(:get, "http://api.ipify.org/")
        .to_return(status: 200, body: "1.1.1.1", headers: {})
    end

    it "returns true" do
      result = Njord::Verify.call("200.6.140.115", 80, 123)
      expect(result).to be_falsey
    end
  end
end
