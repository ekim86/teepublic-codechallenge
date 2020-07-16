
describe "#welcome" do
  it "prints a welcome message to screen" do
    expect($stdout).to receive(:puts).with("Welcome to TeePublic!")
    welcome
  end
end


describe "#product_options" do
  it "returns the value of a `gets.chomp` method" do
    ["tshirt", "mug", "sticker"].each do |string|
      expect(self).to receive(:gets).and_return(string)
      expect(user_inputs).to eq(string)
    end
  end
end
