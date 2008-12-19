require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/clients/show.html.erb" do
  include ClientsHelper
  
  before(:each) do
    assigns[:client] = @client = stub_model(Client,
      :session => "value for session"
    )
  end

  it "should render attributes in <p>" do
    render "/clients/show.html.erb"
    response.should have_text(/value\ for\ session/)
  end
end

