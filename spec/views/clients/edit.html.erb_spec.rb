require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/clients/edit.html.erb" do
  include ClientsHelper
  
  before(:each) do
    assigns[:client] = @client = stub_model(Client,
      :new_record? => false,
      :session => "value for session"
    )
  end

  it "should render edit form" do
    render "/clients/edit.html.erb"
    
    response.should have_tag("form[action=#{client_path(@client)}][method=post]") do
      with_tag('input#client_session[name=?]', "client[session]")
    end
  end
end


