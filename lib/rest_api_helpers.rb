#
# Author: Vidal Graupera
#
# convenience functions extracted for rest clients from Lighthouse sample app

module RestAPIHelpers
  
  def base_url
    @source.credential.url || @source.url
  end
  
  # "recover parts of id 1000-6 => 1000, 6"
  def split_id(idstring)
    idstring =~/(\d*)\-(\d*)/
    return Regexp.last_match(1), Regexp.last_match(2)
  end
  
  # convert name_value_list to a params hash
  # name_value_list example, "[{'name' => 'title', 'value' => 'testing'},{'name' => 'state', 'value' => 'new'}]"
  # => params['title'] = 'testing', etc.
  def get_params(name_value_list)
    @params = {}
    name_value_list.each do |pair| 
      @params.merge!(Hash[pair['name'], pair['value']])
    end
    log @params.inspect
  end
  
  def params
    @params
  end
  
  def eval_value(value)
    # make all values strings
    if value.class == String
      value
    elsif value.class == Hash
      if value["nil"] && value["nil"] == "true"
        ""
      else
        value["content"].to_s
      end
    else
      value
    end
  end
  
  # make an ObjectValue triple for rhosync
  def add_triple(source_id, object_id, attrib, value, user_id)
    return if value.blank?
    
    o = ObjectValue.new
    o.source_id=source_id
    o.object=object_id
    o.attrib=attrib
    o.value = eval_value(value)
    o.user_id = user_id
    
    # values cannot contain double quotes, convert to single
    # TBD: there might be other characters as well that need escaping
    o.value.gsub!(/\"/, "\'")
          
    if !o.save
      log "failed creating triple"
    end
    
    # log "Add ObjectValue: #{source_id}, #{object_id}, #{attrib}, #{value.inspect} => \n #{o.inspect}\n"
  end
  
  def log(msg)
    puts msg
  end
    
end