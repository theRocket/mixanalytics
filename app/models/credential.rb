class Credential < ActiveRecord::Base
  belongs_to :membership
  has_one :user, :through=>:membership
end
  