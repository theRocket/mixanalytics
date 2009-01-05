class ObjectValuesController < ApplicationController

  # GET /object_values
  # GET /object_values.xml
  def index
    @object_values = ObjectValue.find(:all,:order=>:object)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @object_values }
    end
  end


  # GET /object_values/new
  # GET /object_values/new.xml
  def new
    @object_value = ObjectValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @object_value }
    end
  end

  # GET /object_values/1/edit
  def edit
    @object_value = ObjectValue.find(params[:id])
  end

  # POST /object_values
  # POST /object_values.xml
  def create
    @object_value = ObjectValue.new(params[:object_value])

    respond_to do |format|
      if @object_value.save
        flash[:notice] = 'ObjectValue was successfully created.'
        format.html { redirect_to(@object_value) }
        format.xml  { render :xml => @object_value, :status => :created, :location => @object_value }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @object_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /object_values/1
  # PUT /object_values/1.xml
  def update
    @object_value = ObjectValue.find(params[:id])

    respond_to do |format|
      if @object_value.update_attributes(params[:object_value])
        flash[:notice] = 'ObjectValue was successfully updated.'
        format.html { redirect_to(@object_value) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @object_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /object_values/1
  # DELETE /object_values/1.xml
  def destroy
    @object_value = ObjectValue.find(params[:id])
    @object_value.destroy

    respond_to do |format|
      format.html { redirect_to(object_values_url) }
      format.xml  { head :ok }
    end
  end
end
