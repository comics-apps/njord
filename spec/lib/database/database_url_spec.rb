describe Database::DatabaseUrl do
  let(:klass) do
    Class.new { include Database::DatabaseUrl }
  end

  subject { klass.new }

  describe ".build_database_url" do
    context "with ENV[DATABASE_URL]" do
      before do
        ENV["DATABASE_URL"] = "foo"
      end

      after do
        ENV.delete("DATABASE_URL")
      end

      it "returns value from ENV[DATABASE_URL]" do
        expect(subject.build_database_url).to eq("foo")
      end
    end

    context "without ENV[DATABASE_URL]" do
      before do
        subject.class.define_method(:default_config) do
          {
            adapter: "postgres",
            database: "db_foo",
            encoding: "utf8",
            host: "host_foo",
            password: "password_foo",
            username: "user_foo"
          }
        end
      end

      it "returns filled hash" do
        expect(subject.build_database_url)
          .to eq("postgres://user_foo:password_foo@host_foo/db_foo")
      end
    end
  end
end
