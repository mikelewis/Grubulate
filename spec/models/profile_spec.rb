require 'spec_helper'

describe Profile do
  context "Adding recipes" do

    before do
      @recipe = Factory(:recipe)
      @profile = Factory(:profile)
    end

    it "should be able to create a valid recipe" do
      @profile.create_recipe(@recipe)
      @profile.recipes.length.should eq(1)
    end

    it "should not be able to create an invalid recipe" do
      @recipe.difficulty = -1
      @profile.create_recipe(@recipe)
      @profile.recipes.length.should eq(0)
    end


  end
end
