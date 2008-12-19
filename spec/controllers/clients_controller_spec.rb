require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClientsController do

  def mock_client(stubs={})
    @mock_client ||= mock_model(Client, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all clients as @clients" do
      Client.should_receive(:find).with(:all).and_return([mock_client])
      get :index
      assigns[:clients].should == [mock_client]
    end

    describe "with mime type of xml" do
  
      it "should render all clients as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Client.should_receive(:find).with(:all).and_return(clients = mock("Array of Clients"))
        clients.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested client as @client" do
      Client.should_receive(:find).with("37").and_return(mock_client)
      get :show, :id => "37"
      assigns[:client].should equal(mock_client)
    end
    
    describe "with mime type of xml" do

      it "should render the requested client as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Client.should_receive(:find).with("37").and_return(mock_client)
        mock_client.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new client as @client" do
      Client.should_receive(:new).and_return(mock_client)
      get :new
      assigns[:client].should equal(mock_client)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested client as @client" do
      Client.should_receive(:find).with("37").and_return(mock_client)
      get :edit, :id => "37"
      assigns[:client].should equal(mock_client)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created client as @client" do
        Client.should_receive(:new).with({'these' => 'params'}).and_return(mock_client(:save => true))
        post :create, :client => {:these => 'params'}
        assigns(:client).should equal(mock_client)
      end

      it "should redirect to the created client" do
        Client.stub!(:new).and_return(mock_client(:save => true))
        post :create, :client => {}
        response.should redirect_to(client_url(mock_client))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved client as @client" do
        Client.stub!(:new).with({'these' => 'params'}).and_return(mock_client(:save => false))
        post :create, :client => {:these => 'params'}
        assigns(:client).should equal(mock_client)
      end

      it "should re-render the 'new' template" do
        Client.stub!(:new).and_return(mock_client(:save => false))
        post :create, :client => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested client" do
        Client.should_receive(:find).with("37").and_return(mock_client)
        mock_client.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :client => {:these => 'params'}
      end

      it "should expose the requested client as @client" do
        Client.stub!(:find).and_return(mock_client(:update_attributes => true))
        put :update, :id => "1"
        assigns(:client).should equal(mock_client)
      end

      it "should redirect to the client" do
        Client.stub!(:find).and_return(mock_client(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(client_url(mock_client))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested client" do
        Client.should_receive(:find).with("37").and_return(mock_client)
        mock_client.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :client => {:these => 'params'}
      end

      it "should expose the client as @client" do
        Client.stub!(:find).and_return(mock_client(:update_attributes => false))
        put :update, :id => "1"
        assigns(:client).should equal(mock_client)
      end

      it "should re-render the 'edit' template" do
        Client.stub!(:find).and_return(mock_client(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested client" do
      Client.should_receive(:find).with("37").and_return(mock_client)
      mock_client.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the clients list" do
      Client.stub!(:find).and_return(mock_client(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(clients_url)
    end

  end
end
