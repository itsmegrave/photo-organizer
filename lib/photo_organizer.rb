# frozen_string_literal: true

require_relative 'photo'

class PhotoOrganizer
  attr_accessor :file_name

  def initialize
    @file_name = ARGV[0] || 'input.txt'
    @photos_result = []
  end

  def call
    open_file
    map_photos
    map_photos_by_city
    create_photo_new_name

    puts @photos_result.join("\n")
  end

  private

  def open_file
    file = File.open(@file_name)
    @files = file.read.split("\n")
  end

  def map_photos
    @photos = @files.map { |file| Photo.new(file) }
  end

  def map_photos_by_city
    @photos_by_city = @photos.sort_by(&:timestamp).group_by(&:city_name)
  end

  def create_photo_new_name
    @photos.each do |photo|
      photos_on_city = @photos_by_city[photo.city_name]
      digits_on_length = photos_on_city.length.to_s.length

      index = photos_on_city.find_index(photo) + 1

      photo.new_name(index, digits_on_length)

      @photos_result << photo.to_s
    end
  end
end

PhotoOrganizer.new.call
