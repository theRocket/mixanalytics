require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/clients/index.html.erb" do
  include ClientsHelper
  
  before(:each) do
    assigns[:clients] = [
      stub_model(Client,
        :session => "value for session"
      ),
      stub_model(Client,
        :session => "value for session"
      )
    ]
  end

  it "should render list of clients" do
    render "/clients/index.html.erb"
    response.should have_tag("tr>td", "value for session", 2)
  end
end

