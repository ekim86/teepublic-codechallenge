require_relative '../../app/model/product.rb'

describe Product, type: :model do
  describe '.create_product' do
    context 'for product_type tshirt' do
      it 'creates Tshirt object with gender, color, and size attributes' do
        options = {
          'gender' => 'female',
          'color' => 'red',
          'size' => 'small'
        }
        Product.create_product('tshirt', options)

        tshirt = Tshirt.all[0]

        expect(Tshirt.all.count).to eq(1)
        expect(tshirt.gender).to eq(options['gender'])
        expect(tshirt.color).to eq(options['color'])
        expect(tshirt.size).to eq(options['size'])
      end
    end

    context 'for product_type mug' do
      it 'creates Mug object with type attribute' do
        options = {
          'type' => 'coffee-mug'
        }
        Mug.create_product('mug', options)

        mug = Mug.all[0]

        expect(Mug.all.count).to eq(1)
        expect(mug.type).to eq(options['type'])
      end
    end

    context 'for product_type sticker' do
      it 'creates Sticker object with size and style attributes' do
        options = {
          'size' => 'small',
          'style' => 'matte',
        }
        Product.create_product('sticker', options)

        sticker = Sticker.all[0]

        expect(Sticker.all.count).to eq(1)
        expect(sticker.size).to eq(options['size'])
        expect(sticker.style).to eq(options['style'])
      end
    end
  end
end
