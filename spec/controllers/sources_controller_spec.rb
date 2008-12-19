require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SourcesController do
  
  def mock_source(stubs={})
    time = Time.now.to_s
    stubs = {:url=>'',
             :prolog=>'',
             :epilog=>'',
             :login=>true,
             :createcall=>'',
             :updatecall=>'',
             :deletecall=>'',
             :call=>'',
             :sync=>'',
             :query=>'',
             :logoff=>'',
             :initadapter=>true,
             :source_adapter=>nil,
             :refreshtime=>time,
             "refreshtime=".to_sym=>time,
             :save=>true} unless stubs.size > 0
    @adapter = mock_model(SugarAccounts, stubs)
    stubs['source_adapter'] = @adapter
    @mock_source ||= mock_model(Source, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all sources as @sources" do
      Source.should_receive(:find).with(:all).and_return([mock_source])
      get :index
      assigns[:sources].should == [mock_source]
    end

    describe "with mime type of xml" do
  
      it "should render all sources as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Source.should_receive(:find).with(:all).and_return(sources = mock("Array of Sources"))
        sources.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested source as @source" do
      Source.should_receive(:find).with("37").and_return(mock_source)
      get :show, :id => "37"
      assigns[:source].should equal(mock_source)
    end
    
    describe "with mime type of xml" do

      it "should render the requested source as xml" do
        expected = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<nil-classes type=\"array\"/>\n"
        request.env["HTTP_ACCEPT"] = "application/xml"
        Source.should_receive(:find).with("37").and_return(mock_source)
        get :show, :id => "37", :format => "xml"
        response.body.should == expected
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new source as @source" do
      Source.should_receive(:new).and_return(mock_source)
      get :new
      assigns[:source].should equal(mock_source)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested source as @source" do
      Source.should_receive(:find).with("37").and_return(mock_source)
      get :edit, :id => "37"
      assigns[:source].should equal(mock_source)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created source as @source" do
        Source.should_receive(:new).with({'these' => 'params'}).and_return(mock_source(:save => true))
        post :create, :source => {:these => 'params'}
        assigns(:source).should equal(mock_source)
      end

      it "should redirect to the created source" do
        Source.stub!(:new).and_return(mock_source(:save => true))
        post :create, :source => {}
        response.should redirect_to(source_url(mock_source))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved source as @source" do
        Source.stub!(:new).with({'these' => 'params'}).and_return(mock_source(:save => false))
        post :create, :source => {:these => 'params'}
        assigns(:source).should equal(mock_source)
      end

      it "should re-render the 'new' template" do
        Source.stub!(:new).and_return(mock_source(:save => false))
        post :create, :source => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested source" do
        Source.should_receive(:find).with("37").and_return(mock_source)
        mock_source.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :source => {:these => 'params'}
      end

      it "should expose the requested source as @source" do
        Source.stub!(:find).and_return(mock_source(:update_attributes => true, :save_to_yaml => true))
        put :update, :id => "1"
        assigns(:source).should equal(mock_source)
      end

      it "should redirect to the source" do
        Source.stub!(:find).and_return(mock_source(:update_attributes => true, :save_to_yaml => true))
        put :update, :id => "1"
        response.should redirect_to(source_url(mock_source))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested source" do
        Source.should_receive(:find).with("37").and_return(mock_source)
        mock_source.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :source => {:these => 'params'}
      end

      it "should expose the source as @source" do
        Source.stub!(:find).and_return(mock_source(:update_attributes => false))
        put :update, :id => "1"
        assigns(:source).should equal(mock_source)
      end

      it "should re-render the 'edit' template" do
        Source.stub!(:find).and_return(mock_source(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested source" do
      Source.should_receive(:find).with("37").and_return(mock_source)
      mock_source.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the sources list" do
      Source.stub!(:find).and_return(mock_source(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(sources_url)
    end

  end
  
  describe "responding to GET attributes" do
    
    it "should retrieve attributes" do
      Source.should_receive(:find).with("37").and_return(mock_source)
      get :attributes, :id => "37"
      response.should be_success
    end
    
  end
  
  describe "responding to createobjects, deleteobjects, updateobjects" do
    it "should createobjects" do
      Source.should_receive(:find).with("37").and_return(mock_source)
      get :createobjects,:id => "37", :attrvals => [{"object"=>"temp1","attrib"=>"name","value"=>"rhomobile"}]
      response.should be_redirect
    end
  
    it "should updateobjects" do
      Source.should_receive(:find).with("37").and_return(mock_source)
      get :updateobjects,:id => "37", :attrvals => [{"object"=>"1","attrib"=>"name","value"=>"rhomobile"}]
      response.should be_redirect
    end
  
    it "should deleteobjects" do
      Source.should_receive(:find).with("37").and_return(mock_source)
      get :deleteobjects, :id => "37", :attrvals => [{"object"=>"1"}]
      response.should be_redirect
    end
  
    it "should refresh" do
      Source.should_receive(:find).with("37").and_return(mock_source)
      get :refresh, :id => "37"
      response.should be_redirect
    end
    
  end
  
  describe "responding to GET clientcreate" do

    it "should return the created client" do
      get :clientcreate, :format => 'json'
      response.body.should =~ /(^[^\r\n]+?)([A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}(?:@[^\s]*)?|@[^\s]*|\s*$)/
    end
    
  end
end