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

    it "should be able to add a profile image from a url" do
      @profile.url_to_image("http://www.google.com/logos/2011/munkacsy11-hp.jpg", true)

      @profile.avatar.url(:thumb).should match(/munkacsy11-hp\.png/)
    end

    it "should be able to add a profile image to that redirects" do
      @profile.url_to_image("http://graph.facebook.com/munit/picture?type=large", true)
      @profile.avatar.url(:thumb).should match(/_n.png/)
    end

    context "Favorite Chefs" do
      before do
        @profile1 = Factory(:profile)
        @profile.add_favorite_chef(@profile1)
      end
      it "should be able to add a favorite chef" do
        @profile.favorite_chefs.should eq([@profile1])
      end

      it "should be able to remove a favorite chef" do
        @profile.remove_favorite_chef(@profile1)
        @profile.favorite_chefs.length.should eq(0)

      end

      it "should not be able to add a favorite chef more than once" do
        lambda{@profile.add_favorite_chef(@profile1)}.should raise_error
      end

      it "should be able to have fans" do
        @profile1.fans.should eq([@profile])
      end

      it "should not be able to add itself to favorite chefs" do
        lambda{@profile.add_favorite_chef(@profile)}.should raise_error
      end

    end


  end
end
