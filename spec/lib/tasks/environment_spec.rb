describe "environment" do
  include_context "rake"

  it "call Environment.load" do
    expect(Environment).to receive(:load)

    subject.invoke
  end
end
