# frozen_string_literal: true

require 'time'

class Photo
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

  def new_name(index, zero_mask)
    @new_name ||= "#{city_name}#{index.to_s.rjust(zero_mask, '0')}#{extension}"
  end

  def to_s
    @new_name
  end

  private

  def parsed_data
    @parsed_data ||= @original_data.split(', ')
  end
end
