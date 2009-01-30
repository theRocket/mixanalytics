class SourceAdapter
  attr_accessor :client
  def initialize(source=nil,credential=nil)
    @source = source.nil? ? self : source
  end

  def login

  end

  def query
  end

  def sync
    user_id=@source.current_user.id
    @result.entry_list.each do |x|
      x.name_value_list.each do |y|
        o=ObjectValue.new
        o.source_id=@source.id
        o.object=x['id']
        o.attrib=y.name
        o.value=y.value
        o.user_id=user_id if user_id
        o.save
      end
    end
  end

  def create(name_value_list)
  end

  def update(name_value_list)
  end

  def delete(name_value_list)
  end

  def logoff
  end
  
  def set_callback(notify_urL)
  end
end