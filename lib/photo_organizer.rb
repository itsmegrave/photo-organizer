require 'awesome_print'

require_relative 'photo'

class PhotoOrganizer
  attr_accessor :file_name

  def initialize
    @file_name = ARGV[0] || 'input.txt'
  end

  def run
    file = File.open(@file_name)
    files = file.read.split("\n")
    photos = files.map do |f|
      Photo.new(f)
    end
    photos_by_city = photos.sort_by(&:timestamp).group_by(&:city_name)

    puts photos_by_city['Krakow'].length
    photos_result = []
    photos.each do |photo|
      photos_on_city = photos_by_city[photo.city_name]
      digits_on_length = photos_on_city.length.to_s.length
      ap digits_on_length
      index = photos_on_city.find_index(photo) + 1

      photo.new_name(index, digits_on_length)

      photos_result << photo.to_s
    end

    puts photos_result.join("\n")
  end
end

PhotoOrganizer.new.run
