describe FindProxiesJob do
  it "calls Find service" do
    expect(Njord::Find).to receive(:call)

    FindProxiesJob.run
  end
end
