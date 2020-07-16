require 'pry'
require 'rest-client'
require 'json'
require_relative '../config/environment'

FILE = File.open "product.json"
DATA = JSON.load FILE
FILE.close

def welcome
  puts 'Welcome to TeePublic!'
end

def create_products
  file = File.open('product.json')
  products_data = JSON.load(file)
  file.close

  products_data.each do |product_data|
    Product.create_product(product_data['product_type'], product_data['options'])
  end
end

def product_options
  user_input = gets.chomp
  user_inputs = user_input.split(" ")
  product_type = user_inputs[0]

  if product_type == 'tshirt'
    gender = user_inputs[1]
    color = user_inputs[2]
    size = user_inputs[3]

    all_tshirt_genders = Tshirt.all.map(&:gender).uniq
    all_tshirt_colors = Tshirt.all.map(&:color).uniq
    all_tshirt_sizes = Tshirt.all.map(&:size).uniq

    tshirt_colors = all_tshirt_colors
    tshirt_sizes = all_tshirt_sizes

    if all_tshirt_genders.include?(gender)
      tshirt_with_gender = Tshirt.all.select { |tshirt| tshirt.gender == gender}
      tshirt_colors = tshirt_with_gender.map(&:color).uniq
      tshirt_sizes = tshirt_with_gender.map(&:size).uniq
    elsif gender.present?
      tshirt_colors = nil
      tshirt_sizes = nil
      puts "Invalid gender option: #{gender}"
    end
  
    if tshirt_colors.present? && tshirt_colors.include?(color)
      tshirt_colors = nil
      tshirt_with_gender_color = tshirt_with_gender.select { |tshirt| tshirt.color == color }
      tshirt_sizes = tshirt_with_gender_color.map(&:size)
    elsif all_tshirt_colors.include?(color)
      tshirt_colors = nil
      tshirt_sizes = nil
      puts "Invalid color: #{color} for gender: #{gender}"
    elsif color
      tshirt_colors = nil
      tshirt_sizes = nil
      puts "Invalid color: #{color}"
    end

    if tshirt_sizes.present? && tshirt_sizes.include?(size)
      tshirt_sizes = nil
      puts "No other additional options"
    elsif all_tshirt_sizes.include?(size)
      tshirt_sizes = nil
      puts "Invalid size: #{size} for #{color} tshirt for #{gender}s"
    elsif size
      tshirt_sizes = nil
      puts "Invalid size: #{size}"
    end

    puts "Genders: #{all_tshirt_genders.join(', ')}" if gender.nil?
    puts "Colors: #{tshirt_colors.join(', ')}" if tshirt_colors
    puts "Sizes: #{tshirt_sizes.join(', ')}" if tshirt_sizes
  elsif product_type == 'mug'
    type = user_inputs[1]

    all_mug_types = Mug.all.map(&:type).uniq

    if type.nil?
      puts "Type: #{all_mug_types.join(', ')}"
    elsif (type == 'coffee-mug' || type == 'travel-mug')
      puts 'No other additional options'
    else
      puts "Invalid type: #{type}"
    end
  elsif product_type == 'sticker'
    size = user_inputs[1]
    style = user_inputs[2]
    
    all_sticker_sizes = Sticker.all.map(&:size).uniq
    all_sticker_styles = Sticker.all.map(&:style).uniq
    
    if ['x-small','small','medium','large','x-large'].include?(size)
      stickers_with_size = Sticker.all.select { |sticker| sticker.size == size }
      all_sticker_styles = stickers_with_size.map(&:style).uniq
    elsif size.present?
      all_sticker_styles = nil
      puts "Invalid size: #{size}"
    end

    if all_sticker_styles.present? && all_sticker_styles.include?(style)
      all_sticker_styles = nil
      puts 'No other additional options'
    elsif ['glossy', 'matte'].include?(style)
      all_sticker_styles = nil
      puts "Invalid style: #{style} for size: #{size}"
    elsif style
      all_sticker_styles = nil
      puts "Invalid style: #{style}"
    end

    puts "Sizes: #{all_sticker_sizes.uniq.join(', ')}" if size.nil?
    puts "Style: #{all_sticker_styles.uniq.join(', ')}" if style.nil? && all_sticker_styles
  else
    puts 'Invalid'
  end
end

def run
  create_products
  puts "Please type in a product type and 0 or more options:"
  product_options
end
