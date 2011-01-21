require 'spec_helper'

describe Entree do
  before do
    @entree = Factory(:entree)
  end

  it "should be valid with valid attributes" do
    @entree.should be_valid
  end

  it "should not be valid without a name" do
    @entree.name = nil
    @entree.should_not be_valid
  end
end

