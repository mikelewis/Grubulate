require 'spec_helper'

describe Notification do
  before do
    @notification = Factory(:notification)
    @comment = Factory(:comment)
    @recipe = Factory(:recipe)
  end

  it "should be valid with all attributes" do
    @notification.should be_valid
  end

  it "should not be valid without a sender" do
    @notification.sender = nil
    @notification.should_not be_valid
  end

  it "should not be valid without a receiver" do
    @notification.receiver = nil
    @notification.should_not be_valid
  end

  it "should not be valid without a notifiable id" do
    @notification.notifiable_id = nil
    @notification.should_not be_valid
  end

  it "should not be valid without a notifiable type" do
    @notification.notifiable_type = nil
    @notification.should_not be_valid
  end

  context "it should add new notifiables" do
    before do
      @profile = Factory(:profile)
    end

    it "should respond to add_comment" do
      Notification.respond_to?("add_comment").should eq(true)
    end
    it "should respond to add_recipe" do
      Notification.respond_to?("add_recipe").should eq(true)
    end
    it "should add a new comment" do
      comment = Factory(:comment)
      n = Notification.add_comment(comment, @profile)
      comment.recipe.profile.notifications.should eq([n])
    end

    it "should add a new recipe" do
      recipe = Factory(:recipe)
      n = Notification.add_recipe(recipe,recipe.profile, @profile)
      @profile.notifications.should eq([n])
    end
  end
end
