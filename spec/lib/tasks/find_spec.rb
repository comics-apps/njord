describe "find" do
  include_context "rake"

  it "invoke without error" do
    expect {
      subject.invoke
    }.not_to raise_error
  end
end
