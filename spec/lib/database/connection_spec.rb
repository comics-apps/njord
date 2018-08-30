describe Database::Connection do
  let(:klass) do
    Class.new { include Database::Connection }
  end

  subject { klass.new }

  describe ".connection" do
    context "with default database_url" do
      before do
        subject.class.define_method(:build_database_url) { "database_url" }
      end

      it "calls Sequel.connect" do
        expect(Sequel).to receive(:connect).with("database_url")

        subject.connection
      end
    end

    context "with custome database_url" do
      it "calls Sequel.connect" do
        expect(Sequel).to receive(:connect).with("db_url")

        subject.connection("db_url")
      end
    end
  end

  describe ".connect_to_default_database" do
    context "when default_config has no database" do
      before do
        subject.class.define_method(:default_config) do
          {}
        end
      end

      it "does not connect via Sequel" do
        expect(Sequel).not_to receive(:connect)

        subject.connect_to_default_database
      end
    end

    context "when default_config has database" do
      before do
        subject.class.define_method(:default_config) do
          { database: "db_foo" }
        end

        subject.class.define_method(:build_database_url) { |_| "foo" }
      end

      let(:config) do
        { database: "postgres" }
      end

      it "does not connect via Sequel" do
        expect(subject)
          .to receive(:build_database_url).with(config).and_return("foobar")
        expect(Sequel).to receive(:connect).with("foobar")

        subject.connect_to_default_database
      end
    end
  end
end
