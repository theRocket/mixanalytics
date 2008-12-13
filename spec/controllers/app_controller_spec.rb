require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AppsController do

  def mock_app(stubs={})
    @mock_app ||= mock_model(App, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all apps as @apps" do
      App.should_receive(:find).with(:all).and_return([mock_app])
      get :index
      assigns[:apps].should == [mock_app]
    end

    describe "with mime type of xml" do
  
      it "should render all apps as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        App.should_receive(:find).with(:all).and_return(apps = mock("Array of Apps"))
        apps.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end
  
  describe "responding to GET new" do
  
    it "should expose a new app as @app" do
      App.should_receive(:new).and_return(mock_app)
      get :new
      assigns[:app].should equal(mock_app)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested app as @app" do
      App.should_receive(:find).with("37").and_return(mock_app)
      get :edit, :id => "37"
      assigns[:app].should equal(mock_app)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created app as @app" do
        App.should_receive(:new).with({'these' => 'params'}).and_return(mock_app(:save => true))
        post :create, :app => {:these => 'params'}
        assigns(:app).should equal(mock_app)
      end

      it "should redirect to the created app" do
        App.stub!(:new).and_return(mock_app(:save => true))
        post :create, :app => {}
        response.should redirect_to(app_url(mock_app))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved app as @app" do
        App.stub!(:new).with({'these' => 'params'}).and_return(mock_app(:save => false))
        post :create, :app => {:these => 'params'}
        assigns(:app).should equal(mock_app)
      end

      it "should re-render the 'new' template" do
        App.stub!(:new).and_return(mock_app(:save => false))
        post :create, :app => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested app" do
        App.should_receive(:find).with("37").and_return(mock_app)
        mock_app.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :app => {:these => 'params'}
      end

      it "should expose the requested app as @app" do
        App.stub!(:find).and_return(mock_app(:update_attributes => true))
        put :update, :id => "1"
        assigns(:app).should equal(mock_app)
      end

      it "should redirect to the app" do
        App.stub!(:find).and_return(mock_app(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(app_url(mock_app))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested app" do
        App.should_receive(:find).with("37").and_return(mock_app)
        mock_app.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :app => {:these => 'params'}
      end

      it "should expose the app as @app" do
        App.stub!(:find).and_return(mock_app(:update_attributes => false))
        put :update, :id => "1"
        assigns(:app).should equal(mock_app)
      end

      it "should re-render the 'edit' template" do
        App.stub!(:find).and_return(mock_app(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested app" do
      App.should_receive(:find).with("37").and_return(mock_app)
      mock_app.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the apps list" do
      App.stub!(:find).and_return(mock_app(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(apps_url)
    end

  end

end
