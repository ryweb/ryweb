class Configuration < CustomerData

  def self.get_one(cfg_name)
    cfg = Configuration.find(:first, :conditions => {:name => cfg_name})
    return cfg.value unless cfg.nil?
    nil
  end

end
