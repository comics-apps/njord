describe CheckProxiesJob do
  before do
    Database[:proxies].insert(
      ip: "1.1.1.1", port: "80", time: 123, status: "checked"
    )
    Database[:proxies].insert(
      ip: "1.1.1.2", port: "80", time: 124, status: "checked"
    )
  end

  it "checks each unchecked proxy" do
    expect(CheckAndPersistProxyJob).to receive(:enqueue).with("1.1.1.1", 80, 123)
    expect(CheckAndPersistProxyJob).to receive(:enqueue).with("1.1.1.2", 80, 124)

    CheckProxiesJob.run
  end
end
