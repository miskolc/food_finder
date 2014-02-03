 class Restaurant

  @@file_path = nil

  def self.file_path=(path=nil)
    @@file_path = path
  end
  def self.file_exists?
    # class should know if the restaurant file exists
  end

  def self.create_file
    # create the restaurant file
  end

  def self.saved_restaurants
    # read the restaurant file
    # return instances of restaurant
  end
 end