 require 'support/number_helper.rb' 
 class Restaurant
  include NumberHelper
  
  @@file_path = nil
  attr_accessor :name, :cuisine, :price

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
    restaurants = []
    # read the restaurant file
    # return instances of restaurant
    if file_usable? 
      file = File.new(@@file_path, "r")
      file.each_line do |line| 
        restaurants << Restaurant.new.import_line(line.chomp) 
      end
      file.close
    end
    return restaurants
  end

  def self.build_using_questions
    args = {}

    print "Restaurant name: "
    args[:name] = gets.chomp.strip
    
    print "Cuisine type: "
    args[:cuisine] = gets.chomp.strip

    print "Average price: "
    args[:price] = gets.chomp.strip

    return self.new(args)
  end

  def initialize(args={})
    @name     = args[:name]    || ""
    @cuisine  = args[:cuisine] || ""
    @price    = args[:price]   || ""
  end

  def import_line(line)
    line_array = line.split("\t")
    @name, @cuisine, @price = line_array
    return self
  end

  def save
    return false unless Restaurant.file_usable?
    File.open(@@file_path, "a") do |file|
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
    end
    return true
  end

  def formatted_price
    number_to_currency(@price)
  end
 end