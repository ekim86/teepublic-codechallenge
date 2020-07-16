require 'pry'
require 'rest-client'
require 'json'
require_relative '../config/environment'

FILE = File.open "product.json"
DATA = JSON.load FILE
FILE.close

def welcome
  puts 'Welcome to TeePublic!'
  run
end

def product_options
  product_options = DATA.uniq {|product_type| product_type['product_type']}.map {|product_type| product_type['product_type']}

  user_input = gets.chomp
  user_inputs = user_input.split(" ")
  product_type = user_inputs[0]


    if product_type == 'tshirt'
      gender = user_inputs[1]
      color = user_inputs[2]
      size = user_inputs[3]

      all_tshirts = DATA.select {|product_type| product_type['product_type'] == 'tshirt'}
      all_tshirt_genders = all_tshirts.map {|tshirt| tshirt['options']}.map {|option| option['gender']}.uniq
      all_tshirt_colors = all_tshirts.map {|tshirt| tshirt['options']}.map {|option| option['color']}.uniq
      all_tshirt_sizes = all_tshirts.map {|tshirt| tshirt['options']}.map {|option| option['size']}.uniq

      tshirt_colors = all_tshirt_colors
      tshirt_sizes = all_tshirt_sizes

      if all_tshirt_genders.include?(gender)
        tshirt_with_gender = all_tshirts.select { |tshirt| tshirt['options']['gender'] == gender }
        tshirt_colors = tshirt_with_gender.map { |tshirt| tshirt['options']['color'] }.uniq
        tshirt_sizes = tshirt_with_gender.map { |tshirt| tshirt['options']['size'] }.uniq
      elsif gender.present?
        tshirt_colors = nil
        tshirt_sizes = nil
        puts "Invalid gender option: #{gender}"
      end
  
      if tshirt_colors.present? && tshirt_colors.include?(color)
        tshirt_colors = nil
        tshirt_with_gender_color = tshirt_with_gender.select { |tshirt| tshirt['options']['color'] == color }
        tshirt_sizes = tshirt_with_gender_color.map { |tshirt| tshirt['options']['size'] }
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

    all_mugs = DATA.select {|product_type| product_type['product_type'] == 'mug'}
    all_mug_types = all_mugs.map {|mug| mug['options']}.map {|option| option['type']}

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
    all_stickers = DATA.select {|product_type| product_type['product_type'] == 'sticker'}
    all_sticker_sizes = all_stickers.map {|sticker| sticker['options']}.map {|option| option['size']}
    all_sticker_styles = all_stickers.map {|sticker| sticker['options']}.map {|option| option['style']}
    
    if ['x-small','small','medium','large','x-large'].include?(size)
      stickers_with_size = all_stickers.select { |sticker| sticker['options']['size'] == size }
      all_sticker_styles = stickers_with_size.map { |sticker| sticker['options']['style'] }.uniq
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
  puts "Please type in a product type and 0 or more options:"
  product_options
end
