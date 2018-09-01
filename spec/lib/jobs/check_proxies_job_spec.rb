describe CheckProxiesJob do
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
    Database[:proxies].insert(
      ip: "2.2.2.3", port: "80", time: 0, status: "unchecked"
    )
  end

  it "checks each unchecked proxy" do
    expect(CheckAndPersistProxyJob).to receive(:enqueue).with("2.2.2.2", 80, 0)
    expect(CheckAndPersistProxyJob).to receive(:enqueue).with("2.2.2.3", 80, 0)

    CheckProxiesJob.run
  end
end
