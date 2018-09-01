describe Njord::LoadProxies do
  before do
    Database[:proxies].insert(
      ip: "1.1.1.1", port: "80", time: 123, status: "checked"
    )
    Database[:proxies].insert(
      ip: "1.1.1.2", port: "80", time: 124, status: "checked"
    )
    Database[:proxies].insert(
      ip: "2.2.2.2", port: "80", time: 0, status: "unchecked"
    )
  end

  context "with default kind" do
    it "loads all proxies" do
      result = Njord::LoadProxies.call
      statuses = result.map{ |p| p[:status] }.uniq.sort

      expect(result.size).to eq(3)
      expect(statuses).to match_array(%w(checked unchecked))
    end
  end

  context "with unchecked kind" do
    it "loads only unchecked proxies" do
      result = Njord::LoadProxies.call(:unchecked)
      statuses = result.map{ |p| p[:status] }.uniq.sort
      expect(statuses).to match_array(%w(unchecked))
    end
  end

  context "with checked kind" do
    it "loads checked proxies" do
      result = Njord::LoadProxies.call(:checked)
      statuses = result.map{ |p| p[:status] }.uniq.sort
      expect(statuses).to match_array(%w(checked))
    end

    it "returns 1 proxy by default" do
      result = Njord::LoadProxies.call(:checked)
      expect(result.size).to eq(1)
    end

    it "returns more proxies sorted by time" do
      result = Njord::LoadProxies.call(:checked, count: 2)
      ips = statuses = result.map{ |p| p[:ip] }.uniq.sort
      times = statuses = result.map{ |p| p[:time] }.uniq.sort

      expect(result.size).to eq(2)
      expect(ips).to match_array(["1.1.1.1", "1.1.1.2"])
      expect(times).to match_array([123, 124])
    end
  end

  context "with different kind" do
    it "loads all proxies" do
      result = Njord::LoadProxies.call(:foo)
      statuses = result.map{ |p| p[:status] }.uniq.sort

      expect(result.size).to eq(3)
      expect(statuses).to match_array(%w(checked unchecked))
    end
  end
end
