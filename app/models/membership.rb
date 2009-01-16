class Membership < ActiveRecord::Base
  belongs_to :app
  belongs_to :user
  has_one :credential
end
