describe Njord::Fetch do
  before do
    stub_request(:post, "http://www.gatherproxy.com/proxylist/anonymity/")
      .to_return(status: 200, body: fixture("proxy_page.html"), headers: {})
  end

  it "does not raise error" do
    expect {
      Njord::Fetch.call(1)
    }.not_to raise_error
  end
end
