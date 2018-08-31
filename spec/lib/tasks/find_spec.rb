describe "find" do
  include_context "rake"

  before do
    stub_request(:post, "http://www.gatherproxy.com/proxylist/anonymity/")
      .to_return(status: 200, body: fixture("proxy_page.html"), headers: {})
  end

  it "invoke without error" do
    expect {
      subject.invoke
    }.not_to raise_error
  end
end
