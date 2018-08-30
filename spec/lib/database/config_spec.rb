describe Database::Config do
  let(:klass) do
    Class.new { include Database::Config }
  end

  subject { klass.new }

  describe ".default_config" do
    context "with ENV[DATABASE_URL]" do
      before do
        ENV["DATABASE_URL"] = "foo"
      end

      after do
        ENV.delete("DATABASE_URL")
      end

      it "returns empty hash" do
        expect(subject.default_config).to eq({})
      end
    end

    context "without ENV[DATABASE_URL]" do
      before do
        @original_database = ENV["DATABASE_NAME"]
        @original_encoding = ENV["DATABASE_ENCODING"]
        @original_host = ENV["DATABASE_HOST"]
        @original_user = ENV["DATABASE_USER"]
        @original_password = ENV["DATABASE_PASSWORD"]

        ENV["DATABASE_NAME"] = "db_foo"
        ENV["DATABASE_ENCODING"] = "encoding_foo"
        ENV["DATABASE_HOST"] = "host_foo"
        ENV["DATABASE_USER"] = "user_foo"
        ENV["DATABASE_PASSWORD"] = "password_foo"
      end

      after do
        ENV["DATABASE_NAME"] = @original_database
        ENV["DATABASE_ENCODING"] = @original_encoding
        ENV["DATABASE_HOST"] = @original_host
        ENV["DATABASE_USER"] = @original_user
        ENV["DATABASE_PASSWORD"] = @original_password
      end

      let(:expected_config) do
        {
          adapter: "postgres",
          database: "db_foo",
          encoding: "utf8",
          host: "host_foo",
          password: "password_foo",
          username: "user_foo"
        }
      end

      it "returns filled hash" do
        expect(subject.default_config).to eq(expected_config)
      end
    end
  end
end
