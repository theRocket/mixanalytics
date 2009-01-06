require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ObjectValuesController do

  def mock_object_value(stubs={})
    @mock_object_value ||= mock_model(ObjectValue, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all object_values as @object_values" do
      ObjectValue.should_receive(:find).with(:all,{:order=>:object}).and_return([mock_object_value])
      get :index
      assigns[:object_values].should == [mock_object_value]
    end

    describe "with mime type of xml" do
  
      it "should render all object_values as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        ObjectValue.should_receive(:find).with(:all,{:order=>:object}).and_return(object_values = mock("Array of ObjectValues"))
        object_values.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end
  
  describe "responding to GET new" do
  
    it "should expose a new object_value as @object_value" do
      ObjectValue.should_receive(:new).and_return(mock_object_value)
      get :new
      assigns[:object_value].should equal(mock_object_value)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested object_value as @object_value" do
      ObjectValue.should_receive(:find).with("37").and_return(mock_object_value)
      get :edit, :id => "37"
      assigns[:object_value].should equal(mock_object_value)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created object_value as @object_value" do
        ObjectValue.should_receive(:new).with({'these' => 'params'}).and_return(mock_object_value(:save => true))
        post :create, :object_value => {:these => 'params'}
        assigns(:object_value).should equal(mock_object_value)
      end

      it "should redirect to the created object_value" do
        ObjectValue.stub!(:new).and_return(mock_object_value(:save => true))
        post :create, :object_value => {}
        response.should redirect_to(object_value_url(mock_object_value))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved object_value as @object_value" do
        ObjectValue.stub!(:new).with({'these' => 'params'}).and_return(mock_object_value(:save => false))
        post :create, :object_value => {:these => 'params'}
        assigns(:object_value).should equal(mock_object_value)
      end

      it "should re-render the 'new' template" do
        ObjectValue.stub!(:new).and_return(mock_object_value(:save => false))
        post :create, :object_value => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested object_value" do
        ObjectValue.should_receive(:find).with("37").and_return(mock_object_value)
        mock_object_value.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :object_value => {:these => 'params'}
      end

      it "should expose the requested object_value as @object_value" do
        ObjectValue.stub!(:find).and_return(mock_object_value(:update_attributes => true))
        put :update, :id => "1"
        assigns(:object_value).should equal(mock_object_value)
      end

      it "should redirect to the object_value" do
        ObjectValue.stub!(:find).and_return(mock_object_value(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(object_value_url(mock_object_value))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested object_value" do
        ObjectValue.should_receive(:find).with("37").and_return(mock_object_value)
        mock_object_value.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :object_value => {:these => 'params'}
      end

      it "should expose the object_value as @object_value" do
        ObjectValue.stub!(:find).and_return(mock_object_value(:update_attributes => false))
        put :update, :id => "1"
        assigns(:object_value).should equal(mock_object_value)
      end

      it "should re-render the 'edit' template" do
        ObjectValue.stub!(:find).and_return(mock_object_value(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested object_value" do
      ObjectValue.should_receive(:find).with("37").and_return(mock_object_value)
      mock_object_value.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the object_values list" do
      ObjectValue.stub!(:find).and_return(mock_object_value(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(object_values_url)
    end

  end

end
