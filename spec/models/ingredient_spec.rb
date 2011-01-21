require 'spec_helper'

describe Ingredient do
  before do
    @ingredient = Factory(:ingredient)
  end

  it "should be valid with valid attributes" do
    @ingredient.should be_valid
  end
  it "should not be valid without a name" do
    @ingredient.name = nil
    @ingredient.should_not be_valid
  end

  context "Adding ingredient to recipe" do

    before do
      @recipe = Factory(:recipe)
    end

    it "should have one ingredient after adding an ingredient" do
      @recipe.add_ingredient(@ingredient)
      @ingredient.recipes.length.should eq(1)
    end

    it "ingredient should have recipe after adding it" do
      @recipe.add_ingredient(@ingredient)
      @ingredient.recipes.first.should eq(@recipe)
    end
  end
end
