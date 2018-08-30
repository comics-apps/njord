describe Environment do
  after do
    ENV["RUBY_ENV"] = "test"
  end

  context "by default" do
    before do
      ENV.delete("RUBY_ENV")
    end

    it "load Dotenv with development files" do
      expect(Dotenv)
        .to receive(:load)
              .with(".env.development.local", ".env.development", ".env")

      Environment.load
    end
  end

  context "with RUBY_ENV=test" do
    it "load Dotenv for specified environment" do
      expect(Dotenv)
        .to receive(:load)
              .with(".env.test.local", ".env.test", ".env")

      Environment.load
    end
  end

  context "with RUBY_ENV different than development and test" do
    before do
      ENV["RUBY_ENV"] = "foo"
    end

    it "load Dotenv for specified environment" do
      expect(Dotenv).not_to receive(:load)

      Environment.load
    end
  end
end
