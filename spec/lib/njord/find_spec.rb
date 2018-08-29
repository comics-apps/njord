describe Njord::Fetch do
  before do
    stub_request(:post, "http://www.gatherproxy.com/proxylist/anonymity/")
      .to_return(status: 200, body: fixture("proxy_page.html"), headers: {})

    allow(Njord::ParseLastPageNumber).to receive(:call).and_return(1)
  end

  it "returns proxy list" do
    result = Njord::Find.call
    expect(result).to be_an(Array)
    expect(result.size).to eq(30)

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
