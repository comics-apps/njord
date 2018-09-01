describe "find" do
  include_context "rake"

  it "invoke without error" do
    expect(Njord::Find).to receive(:call)
    subject.invoke
  end
end
