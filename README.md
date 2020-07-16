Tee Public Take Home Code Challenge

This is a CLI terminal app.
With this app the user can type in a product type and 0 or more options.
The product type options are tshirt, mug, and sticker
Each product type has different additional options

Tshirt Options:
Genders: male, female
Colors: red, green, navy, white, black
Sizes: small, medium, large, extra-large, 2x-large

Mug Options:
Type: coffee-mug, travel-mug

Sticker Options:
Sizes: x-small, small, medium, large, x-large
Style: matte, glossy

An example for tshirt:
tshirt 
tshirt male
tshirt male red
tshirt male red small

If the user types in just tshirt then the user will see the gender, color, and size options and will be exited out.
If the user types in tshirt male then the user will see the color and sizes available and exited out.
If the user types in tshirt male red then the user will see sizes available.
If the user types in tshirt male red small then it will say no other options available.
If the user types an option that is not available it will say invalid and exit out.

An example for mug:
mug
mug coffee-mug

An example for sticker:
sticker
sticker small
sticker small matte


=================================


Directions for terminal:
1. Type 'bundle' to install gems
2. Type 'rake start' to start the program# teepublic-codechallenge
3. Type 'rspec spec/model/product_spec.rb' to start testing
