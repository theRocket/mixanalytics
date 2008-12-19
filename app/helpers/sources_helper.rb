module SourcesHelper


  # helper function to come up with the string used for the name_value_list
  # name_value_list =  [ { "name" => "name", "value" => "rhomobile" },
  #                     { "name" => "industry", "value" => "software" } ]
  def make_name_value_list(hash)
    if hash and hash.keys.size>0
      result="["
      hash.keys.each do |x|
        result << ("{'name' => '"+ x +"', 'value' => '" + hash[x] + "'},") if x and x.size>0 and hash[x]
      end
      result=result[0...result.size-1]  # chop off last comma
      result += "]"
    end
  end

  def do_refresh(id)
    @source=Source.find id
    @source.initadapter
    # not all endpoints require WSDL! dont do this if you dont see WSDL in the URL (a bit of a hack)
    client = SOAP::WSDLDriverFactory.new(@source.url).create_rpc_driver if @source.url and @source.url.size>0 and @source.url=~/wsdl/
    @source.source_adapter.client=client if @source.source_adapter
    # make sure to use @client and @session_id variables
    # in your code that is edited into each source!
    if @source.source_adapter
      @source.source_adapter.login
    else
      callbinding=eval %"#{@source.prolog};binding"
    end

    # first do all the the creates
    creates=ObjectValue.find_by_sql("select * from object_values where update_type='create' and source_id="+id)
    uniqobjs=creates.map {|x| x.object}
    uniqobjs.uniq!
    uniqobjs.each do |x|
      xvals=ObjectValue.find_all_by_object_and_update_type(x,'create')  # this has all the attribute value pairs for this particular object
      if xvals.size>0
        attrvalues={}
        xvals.each do |y|
          attrvalues[y.attrib]=y.value if y.attrib and y.value
          y.destroy
        end
        # now attrvalues has the attribute values needed for the createcall
        # the Sugar adapter will use the name_value_list variable that we're building up here
        # TODO: name_value_list is probably too specific to Sugar, although we've made it work with other apps
        #  need a clean way to pass the attrvalues hash to any source adapter cleanly
        nvlist=make_name_value_list(attrvalues)
        if @source.source_adapter
          @source.source_adapter.create(nvlist)
        else
          raise ArgumentError,"Need some create code to execute" if @source.createcall.nil?
          callbinding=eval("name_value_list="+nvlist+";"+@source.createcall+";binding",callbinding)
        end
      end
    end

    # now do the updates
    updates=ObjectValue.find_by_sql("select * from object_values where update_type='update' and source_id="+id)
    uniqobjs=updates.map {|x|x.object}
    uniqobjs.uniq!
    uniqobjs.each do |x|
      objvals=ObjectValue.find_all_by_object_and_update_type(x,'update')  # this has all the attribute value pairs now
      attrvalues={}
      attrvalues["id"]=x  # setting the ID allows it be an update
      objvals.each do |y|
        attrvalues[y.attrib]=y.value
        y.destroy
      end
      # now attrvalues has the attribute values needed for the createcall
      nvlist=make_name_value_list(attrvalues)
      if @source.source_adapter
        @source.source_adapter.update(nvlist)
      else
        raise ArgumentError,"Need some update code to execute" if @source.updatecall.nil?
        callbinding=eval("name_value_list="+nvlist+";"+@source.updatecall+";binding",callbinding)
      end
    end


    # now do the deletes
    deletes=ObjectValue.find_by_sql("select * from object_values where update_type='delete' and source_id="+id)
    uniqobjs=deletes.map {|x|x.object}
    uniqobjs.uniq!
    uniqobjs.each do |x|
      attrvalues={}
      attrvalues["id"]=x
      nvlist=make_name_value_list(attrvalues)
      if @source.source_adapter
        @source.source_adapter.delete(nvlist)
      else
        raise ArgumentError,"Need some delete code to execute" if @source.deletecall.nil?
        callbinding=eval("name_value_list="+nvlist+";"+@source.deletecall+";binding",callbinding)
      end
    end
    deletes.each do |x|  # get rid of the deletes
      x.destroy
    end
      
    # do the query call and sync of records
    if @source.source_adapter
      @source.source_adapter.query
      @source.source_adapter.sync
    else
      callbinding=eval(@source.call+";binding",callbinding)
      callbinding=eval(@source.sync+";binding",callbinding) if @source.sync
    end
    ObjectValue.delete_all "(update_type='query') and source_id="+@source.id.to_s
    ObjectValue.find_by_sql("update object_values set update_type='query' where (update_type='pending' or update_type is null) and source_id="+@source.id.to_s)

    # now do the logoff
    if @source.source_adapter
      @source.source_adapter.logoff
    else
      if @source.epilog and @source.epilog.size>0
        callbinding=eval(@source.epilog+";binding",callbinding)
      end
    end

    @source.refreshtime=Time.new  # keep track of the refresh time to help optimize show queries
    @source.save
  end


    # Generate the SQL CREATE statement
  # to create a table which is an "app/source specific table"
  # (usable by an ORM on top of SQLITE on the device)
  # based on all of the attributes present in the object values table
  #
  # RETURNS:
  #   XMLified or Jsonified string containing the SQL CREATE statement
  def table_create
    @source=Source.find params[:id]

    objectvals=ObjectValue.find_all_by_source_id @source.id
    colnames=[]
    objectvals.each do |x|  # each attrib is a column name
      colnames << x.attrib if x.attrib and !colnames.index(x.attrib)
    end
    result="DROP TABLE "+@source.name + ";"
    result+="CREATE TABLE "+@source.name + "(id INTEGER PRIMARY KEY,"
    colnames.each do |x|
      result = result + x + " VARCHAR(255)," if x
    end
    result=result[0...result.size-1]  # chop off that last comma
    result = result + ");"

    respond_to do |format|
      format.html { render :xml => result}
      format.xml  { render :xml => result }
      format.json  { render :json => result }
    end
  end

  # the calls below create tables from the object values table property bag
  # they aren't really necessary now given the presence of Rhom

  # this create the set of INSERT statements to be executed to populate the
  # an "app/source specific table" (usable by an ORM on top of SQLITE on the device)
  # from the object values table
  #
  # RETURNS:
  #   an array of INSERT strings inside JSON or XML
  def table_inserts
    @source=Source.find params[:id]
    objectvals=ObjectValue.find_all_by_source_id @source.id

    # first find all the column names
    # TODO: inefficient, should be separate select of just the colnames
    colnames=[]
    objectvals.each do |x|  # each attrib is a column name
      colnames << x.attrib if x.attrib and !colnames.index(x.attrib)
    end

    # based on those column names formulate the INSERT statement starting text to be used for all INSERTs below
    insertstart="INSERT INTO " + @source.name + " ("
    colnames.each do |colname|
      insertstart+=(colname+",")
    end
    insertstart=insertstart[0...insertstart.size-1] # chop off the comma
    insertstart+=") VALUES("

    # get the list of distinct objects, which will be rows in the new table
    objects=objectvals.map {|x| x.object}
    objects.uniq!  # all the distinct objects in the object values array
    # now go create all the insert statements based on the object values
    @inserts=[]
    objects.each do |x|
      sql=insertstart
      xvals = ObjectValue.find_all_by_object x # only use the values for this object x!

      valuelist=[]
      colnames.each do |col|
        xvals.each do |xval|
          if xval.attrib==col and !valuelist.index(xval.value)
            sql = sql +"\"" + xval.value + "\","
            valuelist << xval.value
          end
        end
      end
      sql=sql[0...sql.size-1]
      sql+=");"  # chop off the trailing comma and close the VALUES right paren
      @inserts << sql
    end

    respond_to do |format|
      format.html {render :action=>"table_inserts"}
      format.xml  { render :xml => @inserts}
      format.json  { render :json => @inserts }
    end
  end

  # generate updates for the "app/source specific table" described above

  def table_updates
    @source=Source.find params[:id]
    objectvals=ObjectValue.find_all_by_source_id @source.id
    # first find all the column names
    # TODO: inefficient, should be separate select of just the colnames
    colnames=[]
    objectvals.each do |x|  # each attrib is a column name
      colnames << x.attrib if x.attrib and !colnames.index(x.attrib)
    end

    # get the list of distinct objects, which will be rows in the new table
    objects=objectvals.map {|x| x.object}
    objects.uniq!  # all the distinct objects in the object values array

    # based on those column names formulate the INSERT statement starting text to be used for all INSERTs below
    updatestart="UPDATE " + @source.name + " SET "

    # now go create all the update statements based on the object values
    @updates=[]
    objectid=nil
    objects.each do |x|  # each value is a column name
      sql=updatestart
      xvals = ObjectValue.find_all_by_object x # only use the values for this object x!
      valuelist=[]
      colnames.each do |col|
        xvals.each do |xval|
          if xval.attrib==col and !valuelist.index(xval.value)
            sql = sql + col +"=\"" + xval.value + "\","
            valuelist << xval.value
          end
          objectid=xval.value if xval.attrib.downcase=="id"
        end
      end
      sql=sql[0...sql.size-1]  # chop last comma off
      sql += " WHERE ID=" + objectid + ";"
      @updates << sql if objectid  # only add if we got an ID to use for the object
    end

    respond_to do |format|
      format.html { render :action => "table_updates"}
      format.xml  { render :xml => @updates }
      format.json  { render :json => @updates }
    end
  end

end
