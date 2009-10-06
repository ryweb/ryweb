class Configuration < CustomerData

  def self.get_one(cfg_name)
    Configuration.find(:first, :conditions => {:name => cfg_name}).value
  end

end
