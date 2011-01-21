require 'spec_helper'

describe Recipe do
  before do
    @recipe = Factory(:recipe)
  end

  it "should be valid with valid attributes" do
    @recipe.should be_valid
  end

  it "should not be valid without a name" do
    @recipe.title = nil
    @recipe.should_not be_valid
  end

  it "should not be valid without difficulty" do
    @recipe.difficulty = nil
    @recipe.should_not be_valid
  end

  it "should not be valid with anything other than an integer" do
    @recipe.difficulty = 'a'
    @recipe.should_not be_valid
  end

  it " difficulty should not be valid with anything below 1" do
    @recipe.difficulty = 0
    @recipe.should_not be_valid
  end
  it "should not be valid with anything over than difficulty 5" do
    @recipe.difficulty = 6
    @recipe.should_not be_valid
  end

  it "should not be valid without instructions" do
    @recipe.instructions = nil
    @recipe.should_not be_valid
  end

  it "should not be valid with blank instructions" do
    @recipe.instructions = ''
    @recipe.should_not be_valid
  end

  it "should not be valid with less than 5 characters for short_desc" do
    @recipe.short_desc = "a" * 4
    @recipe.should_not be_valid
  end 

  it "should not be valid with more than 255 characters for short_desc" do
    @recipe.short_desc = "a" * 256
    @recipe.should_not be_valid
  end 

  it "should not be valid with less than 5 characters for instructions" do
    @recipe.short_desc = "a" * 4
    @recipe.should_not be_valid
  end 

  it "should not be valid with more than 5001 characters for instructions" do
    @recipe.short_desc = "a" * 5001
    @recipe.should_not be_valid
  end 

  it "should not be valid without a cook time" do
    @recipe.cook_time = nil
    @recipe.should_not be_valid
  end

  it "should not be valid with a non integer for cook time" do
    @recipe.cook_time = 'a'
    @recipe.should_not be_valid
  end
  it "should not be valid with less than 0 cooktime" do
    @recipe.cook_time = -1
    @recipe.should_not be_valid
  end

  context "adding ingredients" do

    before do
      @ingredient = Factory(:ingredient)
    end

    it "should have one ingredient after adding an ingredient" do
      @recipe.add_ingredient(@ingredient)
      @recipe.ingredients.length.should eq(1)
    end

  end
end
