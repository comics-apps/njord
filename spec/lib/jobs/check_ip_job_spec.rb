describe CheckIpJob do
  let(:ip) { "123.123.123.123" }
  let(:port) { 9876 }
  let(:time) { 11 }

  context "when proxy works" do
    before do
      stub_request(:get, "http://api.ipify.org/")
         .to_return(status: 200, body: ip, headers: {})
    end

    it "saves proxy in database" do
      expect {
        CheckIpJob.run(ip, port, time)
      }.to change{ Database[:proxies].count }.by(1)
    end
  end

  context "when proxy does not work" do
    before do
      stub_request(:get, "http://api.ipify.org/")
         .to_return(status: 200, body: "foo", headers: {})
    end

    it "do not save it" do
      expect {
        CheckIpJob.run(ip, port, time)
      }.not_to change{ Database[:proxies].count }
    end
  end
end
