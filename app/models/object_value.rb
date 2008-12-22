require "xml/libxml"

class ObjectValue < ActiveRecord::Base
  set_primary_key :id
  belongs_to :source
  has_many :client_maps
  has_many :clients, :through => :client_maps
  # take arbitrary XML and serialize it into this table of objects and values
  def self.serialize(xml)
    p "Serializing " + xml
    xp = XML::Parser.string(xml)
    doc = xp.parse
    root=doc.root
    current=root
    current.children.each do |x|
      p "Name:" + x.name
    end
  end

  def before_validate
    self.update_type="pending"
  end
  
  def before_save
    self.id = "#{self.object}#{self.attrib}#{self.value}".hash.to_i
  end

end
