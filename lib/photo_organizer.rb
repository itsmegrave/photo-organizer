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

    photos_result = []
    photos.each do |photo|
      photos_on_city = photos_by_city[photo.city_name]
      digits_on_length = photos_on_city.length.to_s.length
      index = photos_on_city.find_index(photo) + 1

      photos_result << photo.add_formatted_photo_name(index, return_zeros(digits_on_length))
    end

    puts photos_result.join("\n")
  end

  private

  def return_zeros(size, mask = '')
    return_zeros(size, mask << '0') unless mask.length == size - 1
    mask
  end
end

PhotoOrganizer.new.run
