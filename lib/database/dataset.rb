module Dataset
  def [](name)
    Database.instance.connection[name]
  end
end