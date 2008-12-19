class Source < ActiveRecord::Base
  has_many :object_values
  belongs_to :application
  attr_accessor :source_adapter

  def before_validate
    self.initadapter
  end

  def initadapter
    #create a source adapter with methods on it if there is a source adapter class identified
    if self.adapter and self.adapter.size>0
      @source_adapter=(Object.const_get(self.adapter)).new(self)
    else # if source_adapter is nil it will
      @source_adapter=nil
    end
  end

  # useful to be able to have the source adapter code available for viewing in YAML files
  def save_to_yaml
    File.open(name+'.yml','w') do |out|
      out.puts to_yaml
    end
  end
end
