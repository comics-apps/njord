Sequel.migration do
  up do
    create_table(:proxies) do
      primary_key :id
      String :ip, null: false
      Integer :port, null: false
      Integer :time, null: false
      String :status

      index [:ip, :port]
      index :time
      index :status
    end
  end

  down do
    drop_table(:proxies)
  end
end
