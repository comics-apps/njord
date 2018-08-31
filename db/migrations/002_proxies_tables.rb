Sequel.migration do
  up do
    create_table(:proxies) do
      primary_key :id
      String :ip, null: false
      Integer :port, null: false
    end
  end

  down do
    drop_table(:proxies)
  end
end
