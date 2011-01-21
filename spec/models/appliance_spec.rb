require 'spec_helper'

describe Appliance do
  before do
    @appliance = Factory(:appliance)
  end

  it "should be valid with valid attributes" do
    @appliance.should be_valid
  end

  it "should not be valid without a name" do
    @appliance.name = nil
    @appliance.should_not be_valid
  end
end
