require 'spec_helper'

describe Comment do
  before do
    @comment = Factory(:comment)
  end
  it "should be valid" do
    @comment.should be_valid
  end

  it "should not be valid without body" do
    @comment.body = nil
    @comment.should_not be_valid
  end

  it "should not be valid with a 1001 long body" do
    @comment.body = 'a' * 1001
    @comment.should_not be_valid
  end

  it "should not be valid with a less than 2 long body" do
    @comment.body ='aa'
    @comment.should_not be_valid
  end

  it "should not be valid without a recipe_id" do
    @comment.recipe_id = nil
    @comment.should_not be_valid
  end

  it "should not be valid without a profile_id" do
    @comment.profile_id = nil
    @comment.should_not be_valid
  end
end
