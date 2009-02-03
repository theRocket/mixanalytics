require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Source do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should load fixtures" do
    Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "..", "..", "db", "migrate"), "sources")
    @source = Source.find(1)
    @source.name.should == "SugarAccounts"
    @source.attributes.size.should == 21
  end
end