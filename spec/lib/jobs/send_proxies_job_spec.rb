describe SendProxiesJob do
  context "when we want more proxies than exist in database" do
    before do
      allow(Njord::LoadProxies)
        .to receive(:call).with(:checked, count: 2).and_return([{}])
    end

    it "waits - run SendProxiesJob again" do
      expect(SendProxiesJob).to receive(:enqueue)

      SendProxiesJob.run(2)
    end
  end

  context "when there are enough proxies" do
    before do
      allow(Njord::LoadProxies)
        .to receive(:call).with(:checked, count: 2).and_return([{}, {}])
    end

    it "waits - run SendProxiesJob again" do
      expect(Njord::SendProxies).to receive(:call)

      SendProxiesJob.run(2)
    end
  end
end
