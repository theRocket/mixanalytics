require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/clients/new.html.erb" do
  include ClientsHelper
  
  before(:each) do
    assigns[:client] = stub_model(Client,
      :new_record? => true,
      :session => "value for session"
    )
  end

  it "should render new form" do
    render "/clients/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", clients_path) do
      with_tag("input#client_session[name=?]", "client[session]")
    end
  end
end


