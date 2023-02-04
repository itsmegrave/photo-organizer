# frozen_string_literal: true

require 'time'

class Photo
  attr_accessor :formatted_photo_name

  def initialize(photo_data)
    @original_data = photo_data
  end

  def extension
    File.extname(parsed_data[0])
  end

  def city_name
    parsed_data[1]
  end

  def timestamp
    Time.new(parsed_data[2])
  end

  def add_formatted_photo_name(index, zero_mask)
    "#{city_name}#{index.to_s.rjust(zero_mask, '0')}#{extension}"
  end

  private

  def parsed_data
    @parsed_data ||= @original_data.split(', ')
  end
end
