require "menu"

describe Menu do
  context "#read" do
    it "Adds and displays 1 dish" do
      calamari = double(:fake_dish, name: "Calamari", price: 3)
      menu = Menu.new
      menu.add(calamari)
      expect(menu.read).to eq ["Calamari: £3"]
    end

    it "Adds and displays 2 dishes" do
      calamari = double(:fake_dish, name: "Calamari", price: 3)
      chips = double(:fake_dish, name: "Chips", price: 2)
      menu = Menu.new
      menu.add(calamari)
      menu.add(chips)
      expect(menu.read).to eq ["Calamari: £3", "Chips: £2"]
    end

    it "Adds and removes dishes" do 
      calamari = double(:fake_dish, name: "Calamari", price: 3)
      chips = double(:fake_dish, name: "Chips", price: 2)
      menu = Menu.new
      menu.add(calamari)
      menu.add(chips)
      menu.remove(chips)
      expect(menu.read).to eq ["Calamari: £3"]
    end
  end

  context "#add" do
    it "Fails to add dish if already on menu" do 
      calamari = double(:fake_dish, name: "Calamari", price: 3)
      menu = Menu.new
      menu.add(calamari)
      expect { menu.add(calamari) }.to raise_error "Dish is already on the menu"
    end
  end

  context "#remove" do
    it "Fails to remove dish if it not on the menu" do 
      calamari = double(:fake_dish, name: "Calamari", price: 3)
      menu = Menu.new
      expect { menu.remove(calamari) }.to raise_error "Dish is not on the menu"
    end

    it "Fails to remove dish if it has already been removed from the menu" do 
      calamari = double(:fake_dish, name: "Calamari", price: 3)
      menu = Menu.new
      menu.add(calamari)
      menu.remove(calamari)
      expect { menu.remove(calamari) }.to raise_error "Dish is not on the menu"
    end
  end

  context "#dishes" do
    it "returns the list of dishes" do
      calamari = double(:fake_dish, name: "Calamari", price: 3)
      chips = double(:fake_dish, name: "Chips", price: 2)
      menu = Menu.new
      menu.add(calamari)
      menu.add(chips)
      expect(menu.dishes).to eq [calamari, chips]
    end
  end
  
end