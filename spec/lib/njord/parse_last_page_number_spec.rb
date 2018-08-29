describe Njord::ParseLastPageNumber do
  let(:body) { fixture("proxy_page.html") }

  it "returns number of pages" do
    result = Njord::ParseLastPageNumber.call(body)
    expect(result).to eq(141)
  end
end
