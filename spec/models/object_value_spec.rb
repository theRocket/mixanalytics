require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ObjectValue do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    ObjectValue.create!(@valid_attributes)
  end
  
  it "should generate same id hash for known values" do
    ObjectValue.create!({:attrib => 'some-attrib', 
                         :object => 'some-object', 
                         :value => 'some-value',
                         :source_id => 37})
    ObjectValue.find(-359898525).attrib.should == 'some-attrib'
  end
end