describe Njord::ParseProxies do
  let(:body) { fixture("proxy_page.html") }

  before do
    allow(CheckAndPersistProxyJob).to receive(:enqueue)
  end

  it "returns proxy list" do
    result = Njord::ParseProxies.call(body)

    expect(result).to be_an(Array)
    expect(result.size).to eq(30)
  end

  it "all proxies must be elite level" do
    result = Njord::ParseProxies.call(body)
    levels = result.map{ |r| r[:level] }.uniq

    expect(levels).to eq(["Elite"])
  end

  it "returns valid proxy hash" do
    result = Njord::ParseProxies.call(body)
    proxy = result[0]

    expect(proxy).to be_a(Hash)
    expect(proxy.keys)
      .to match_array([:country, :ip, :level, :port, :response_time, :uptime])
    expect(proxy[:country]).to eq("Russia")
    expect(proxy[:ip]).to eq("188.68.106.152")
    expect(proxy[:level]).to eq("Elite")
    expect(proxy[:port]).to eq(36127)
    expect(proxy[:response_time]).to eq(176)
    expect(proxy[:uptime]).to eq("5/2")
  end
end
