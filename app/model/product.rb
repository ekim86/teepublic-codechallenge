class Product
  attr_reader :product_type, :options

  @@all = []

  def initialize(product_type, options = {})
    @product_type = product_type
    @options = options
  end

  def self.create_product(product_type, options)
    if product_type == 'tshirt'
      Tshirt.new(options['gender'], options['color'], options['size'])
    elsif product_type == 'mug'
      Mug.new(options['type'])
    elsif product_type == 'sticker'
      Sticker.new(options['size'], options['style'])
    end
  end

  def self.all
    @@all.select { |product| product.is_a?(self) }
  end
end

class Tshirt < Product
  attr_reader :gender, :color, :size

  def initialize(gender, color, size)
    @product_type = 'tshirt'
    @options = { gender: gender, color: color, size: size}
    @gender = gender
    @color = color
    @size = size
    @@all << self
  end
end

class Mug < Product
attr_reader :type

  def initialize(type)
    @product_type = 'Mug'
    @options = { type: type }
    @type = type
    @@all << self
  end
end

class Sticker < Product
  attr_reader :size, :style

  def initialize(size, style)
    @product_type = 'sticker'
    @options = { size: size, style: style }
    @size = size
    @style = style
    @@all << self
  end
end
