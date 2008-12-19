require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Client do
  before(:each) do
    @valid_attributes = {
      :client_id => nil,
      :session => "value for session"
    }
  end

  it "should create a new instance given valid attributes" do
    Client.create!(@valid_attributes)
  end
  
  it "should not generate same uuid twice" do
    uuids = []
    1000.times do |i|
      new_uuids = []
      uuids << Client.new.client_id
      new_uuids = uuids.clone
      new_uuids.uniq!.should == nil
    end
  end
end
