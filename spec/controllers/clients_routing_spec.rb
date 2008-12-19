require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClientsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "clients", :action => "index").should == "/clients"
    end
  
    it "should map #new" do
      route_for(:controller => "clients", :action => "new").should == "/clients/new"
    end
  
    it "should map #show" do
      route_for(:controller => "clients", :action => "show", :id => 1).should == "/clients/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "clients", :action => "edit", :id => 1).should == "/clients/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "clients", :action => "update", :id => 1).should == "/clients/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "clients", :action => "destroy", :id => 1).should == "/clients/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/clients").should == {:controller => "clients", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/clients/new").should == {:controller => "clients", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/clients").should == {:controller => "clients", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/clients/1").should == {:controller => "clients", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/clients/1/edit").should == {:controller => "clients", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/clients/1").should == {:controller => "clients", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/clients/1").should == {:controller => "clients", :action => "destroy", :id => "1"}
    end
  end
end
