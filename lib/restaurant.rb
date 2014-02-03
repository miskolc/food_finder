 class Restaurant

  @@file_path = nil

  def self.file_path=(path=nil)
    @@file_path = path
  end
  def self.file_exists?
    # class should know if the restaurant file exists
    if @@file_path && File.exists?(@@file_path)
      true
    else
      false
    end
  end

  def self.file_usable?
    return false unless @@file_path
    return false unless File.exists?(@@file_path)
    return false unless File.readable?(@@file_path)
    return false unless File.writable?(@@file_path)
    return true
  end

  def self.create_file
    # create the restaurant file
    File.open(@@file_path, "w") unless File.exists?(@@file_path)
    file_usable?
  end

  def self.saved_restaurants
    # read the restaurant file
    # return instances of restaurant
  end
 end