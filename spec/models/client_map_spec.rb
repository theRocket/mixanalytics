require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClientMap do
  before(:each) do
    @valid_attributes = {
      :client_id => "value for client_id",
      :obj_key => "value for obj_key",
      :update_type => "value for update_type"
    }
  end

  it "should create a new instance given valid attributes" do
    ClientMap.create!(@valid_attributes)
  end
end
